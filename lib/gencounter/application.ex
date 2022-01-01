defmodule Gencounter.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      {Gencounter.Producer, 0},
      {Gencounter.ProducerConsumer, []},
      Supervisor.child_spec({Gencounter.Consumer, []}, id: :a),
      Supervisor.child_spec({Gencounter.Consumer, []}, id: :b),
      Supervisor.child_spec({Gencounter.Consumer, []}, id: :c),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gencounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
