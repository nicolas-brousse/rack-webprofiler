module Rack
  class WebProfiler::Collectors::TimeCollector
    include Rack::WebProfiler::Collector::DSL

    icon <<-'ICON'
data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+PHN2ZyB3aWR0aD0iMjBweCIgaGVpZ2h0PSIyMHB4IiB2aWV3Qm94PSIwIDAgMjAgMjAiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+ICAgICAgICA8dGl0bGU+R3JvdXAgMjwvdGl0bGU+ICAgIDxkZXNjPkNyZWF0ZWQgd2l0aCBTa2V0Y2guPC9kZXNjPiAgICA8ZGVmcz48L2RlZnM+ICAgIDxnIGlkPSJQYWdlLTEiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPiAgICAgICAgPGcgaWQ9IkRlc2t0b3AtMiIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEwLjAwMDAwMCwgLTE3MC4wMDAwMDApIiBmaWxsPSIjNTg1NDczIj4gICAgICAgICAgICA8ZyBpZD0iUGVyZm9ybWFuY2UiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDAuMDAwMDAwLCAxNjAuMDAwMDAwKSI+ICAgICAgICAgICAgICAgIDxnIGlkPSJHcm91cC0yIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgxMC4wMDAwMDAsIDEwLjAwMDAwMCkiPiAgICAgICAgICAgICAgICAgICAgPHBhdGggZD0iTTEwLDE4IEwxMCwxOCBDMTQuNDE4Mjc4LDE4IDE4LDE0LjQxODI3OCAxOCwxMCBDMTgsNS41ODE3MjIgMTQuNDE4Mjc4LDIgMTAsMiBDNS41ODE3MjIsMiAyLDUuNTgxNzIyIDIsMTAgQzIsMTQuNDE4Mjc4IDUuNTgxNzIyLDE4IDEwLDE4IEwxMCwxOCBMMTAsMTggWiBNMCwxMCBDMCw0LjQ3NzE1MjUgNC40NzcxNTI1LDAgMTAsMCBDMTUuNTIyODQ3NSwwIDIwLDQuNDc3MTUyNSAyMCwxMCBDMjAsMTUuNTIyODQ3NSAxNS41MjI4NDc1LDIwIDEwLDIwIEM0LjQ3NzE1MjUsMjAgMCwxNS41MjI4NDc1IDAsMTAgWiIgaWQ9IlNoYXBlIj48L3BhdGg+ICAgICAgICAgICAgICAgICAgICA8cmVjdCBpZD0iUmVjdGFuZ2xlLTQzIiB4PSI5IiB5PSI0IiB3aWR0aD0iMiIgaGVpZ2h0PSI1Ij48L3JlY3Q+ICAgICAgICAgICAgICAgICAgICA8cmVjdCBpZD0iUmVjdGFuZ2xlLTQzLUNvcHkiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDE0LjAwMDAwMCwgMTAuMDAwMDAwKSByb3RhdGUoLTI3MC4wMDAwMDApIHRyYW5zbGF0ZSgtMTQuMDAwMDAwLCAtMTAuMDAwMDAwKSAiIHg9IjEzIiB5PSI4IiB3aWR0aD0iMiIgaGVpZ2h0PSI0Ij48L3JlY3Q+ICAgICAgICAgICAgICAgIDwvZz4gICAgICAgICAgICA8L2c+ICAgICAgICA8L2c+ICAgIDwvZz48L3N2Zz4=
ICON

    identifier "time"
    label      "Time"
    position   3

    collect do |request, _response|
      runtime = request.env[WebProfiler::ENV_RUNTIME] * 1000.0

      store :runtime, runtime

      status :warning if runtime >= 200
      status :danger  if runtime >= 1000

      show_panel false
    end

    template __FILE__, type: :DATA
  end
end

__END__
<% tab_content do %>
  <%= data(:runtime).round(2) %> ms
<% end %>
