# frozen_string_literal: true

# Gets controller button input icons
class ControllerButtons
  attr_gtk

  BUTTONS = {
    bottom_button: ->(controller, color) { "sprites/buttons/#{controller}_bottom_button#{'_color' if color}.png" },
    top_button: ->(controller, color) { "sprites/buttons/#{controller}_top_button#{'_color' if color}.png" },
    left_button: ->(controller, color) { "sprites/buttons/#{controller}_left_button#{'_color' if color}.png" },
    right_button: ->(controller, color) { "sprites/buttons/#{controller}_right_button#{'_color' if color}.png" },
    left_trigger: ->(controller, color) { "sprites/buttons/#{controller}_left_trigger#{'_color' if color}.png" },
    right_trigger: ->(controller, color) { "sprites/buttons/#{controller}_right_trigger#{'_color' if color}.png" },
    left_bumper: ->(controller, color) { "sprites/buttons/#{controller}_left_bumper#{'_color' if color}.png" },
    right_bumper: ->(controller, color) { "sprites/buttons/#{controller}_right_bumper#{'_color' if color}.png" },
    ls: ->(controller, color) { "sprites/buttons/#{controller}_ls#{'_color' if color}.png" },
    rs: ->(controller, color) { "sprites/buttons/#{controller}_rs#{'_color' if color}.png" },
    up_down: ->(controller, color) { "sprites/buttons/#{controller}_up_down#{'_color' if color}.png" },
    left_right: ->(controller, color) { "sprites/buttons/#{controller}_left_right#{'_color' if color}.png" }
  }.freeze

  attr_accessor :controller_number, :controller_name

  def initialize(controller_number: :one)
    @controller_number = controller_number
    @controller_name = nil
  end

  # Sets the controller name dynamically based on the controller number
  def find_controller_name(args)
    method_name = "controller_#{@controller_number}"

    raise ArgumentError, "Invalid controller number: #{@controller_number}" unless args.inputs.respond_to?(method_name)

    raw_name = args.inputs.send(method_name).name.downcase # Normalize string to lowercase
    @controller_name =
      if raw_name.include?('xbox')
        'xbox'
      elsif raw_name.include?('playstation')
        'ps'
      elsif raw_name.include?('nintendo')
        'ns'
      elsif raw_name.include?('steam')
        'steamdeck'
      else
        'unknown' # Default value if no match
      end
  end

  # Gets the button icon path for the given button and current controller
  def button_icon(button = :bottom_button, color: true)
    raise 'Controller name not set. Call `set_controller_name` first.' unless @controller_name

    BUTTONS[button.to_sym].call(@controller_name, color)
  end
end
