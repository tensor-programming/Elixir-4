defmodule Gencounter.Producer do
	use GenStage

	def start_link(init \\ 0) do
		GenStage.start_link(__MODULE__, init, name: __MODULE__)
	end

	def init(counter), do: {:producer, counter}

	def handle_demand(demand, state) do
		events = Enum.to_list(state..state + demand - 1)
		{:noreply, events, (state+demand)}
	end
end