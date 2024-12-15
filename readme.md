# DragonRuby Button Icon Selector

This is for the DragonRuby Game Toolkit: https://dragonruby.org/

This is a work in progress.

Images used under the CCO license, they are from Kenney.nl. Specifically this pack: https://www.kenney.nl/assets/input-prompts
Please consider supporting him if you end up liking his assets!

## Adding to your project
This is really easy to add to your project. If you download the whole repo, you should just be able to copy the lib and sprites folder into your mygame folder.
If you want to do this manually, copy the buttons directory `/sprites/buttons` into `<dir>/mygrame/sprites` then copy `mygame/lib/buttons.rb` into `<dir>/mygame/lib`

## Using the lib

Somewhere in your project, you'll need to add:
```ruby
require 'lib/buttons'
```
Likely to your main.rb, but this will depend on your project. After this, you'll need to instantiate a variable with this. I'm still playing around with the best approach. My current approach:

```ruby
  return unless args.inputs.controller.one.connected

  args.state.controller.one = ControllerButtons.new(controller_number: :one)
  args.state.controller.one.find_controller_name args
```

You *MUST* call `.find_controller_name` as this will pick up the type of controller being used. Note also, that the default controller_number will be `:one`. If it's controller `:two` you can call that. I plan to look at tweaking this some to take care of it automatically based on the idx, but this is just a first pass.

One alternative I intend to try is:

```ruby
    args.state.controller.one = nil
    args.state.controller.two = nil
    
    if args.inputs.controller_one.connected
        controller_one_connected args
    end
    
    def controller_one_connected args
        args.state.controller.one = ControllerButtons.new(controller_number: :one)
        args.state.controller.one.find_controller_name args
    end
    
    def controller_two_connected args
        args.state.controller.two = ControllerButtons.new(controller_number: :two)
        args.state.controller.two.find_controller_name args
    end
```
Now when adding a sprite for the button prompt, you can use: 
```ruby
        path: args.state.controller_one.button_icon(:bottom_button),
```

