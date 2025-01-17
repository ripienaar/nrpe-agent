metadata    :name        => "nrpe",
            :description => "Agent to query NRPE commands via Choria",
            :author      => "R.I.Pienaar <rip@devco.net>",
            :license     => "Apache-2.0",
            :version     => "4.1.0",
            :url         => "https://github.com/choria-plugins/nrpe-agent",
            :timeout     => 30

requires :mcollective => "2.2.1"

action "runcommand", :description => "Run a NRPE command" do
    input :command,
          :prompt      => "Command",
          :description => "NRPE command to run",
          :type        => :string,
          :validation  => '\A[a-zA-Z0-9_-]+\z',
          :optional    => false,
          :maxlength   => 50

    input :args,
           :prompt      => "Arguments",
           :description => "NRPE Command arguments",
           :type        => :string,
           :validation  => '.*',
           :optional    => true,
           :maxlength   => 50

    output :output,
           :description => "Output from the Nagios plugin",
           :display_as  => "Output",
           :default     => ""

    output :exitcode,
           :description  => "Exit Code from the Nagios plugin",
           :display_as   => "Exit Code",
           :default      => 3

    output :perfdata,
           :description  => "Performance Data from the Nagios plugin",
           :display_as   => "Performance Data",
           :default      => ""

    output :command,
           :description  => "Command that was run",
           :display_as   => "Command",
           :default      => ""

    if respond_to?(:summarize)
        summarize do
            aggregate nagios_states(:exitcode)
        end
    end
end

action "runallcommands", :description => "Run all defined NRPE commands" do
    output :commands,
           :description => "Output status of all defined commands",
           :display_as  => "Commands"
end
