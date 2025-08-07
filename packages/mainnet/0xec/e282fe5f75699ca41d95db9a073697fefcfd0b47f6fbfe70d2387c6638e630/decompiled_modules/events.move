module 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events {
    struct WheelCratedEvent has copy, drop {
        wheel_id: 0x2::object::ID,
        creator: address,
    }

    struct CanvasAddedEvent has copy, drop {
        canvas_id: 0x2::object::ID,
        index: u64,
    }

    struct PixelsPaintedEvent has copy, drop {
        pixels_x: vector<u64>,
        pixels_y: vector<u64>,
        color: vector<0x1::string::String>,
    }

    struct PixelsPaintedEventV2 has copy, drop {
        pixels_x: vector<u64>,
        pixels_y: vector<u64>,
        color: vector<0x1::string::String>,
        painter: address,
        cost: u64,
    }

    struct RewardEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        won: bool,
    }

    public(friend) fun emit_canvas_added_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = CanvasAddedEvent{
            canvas_id : arg0,
            index     : arg1,
        };
        0x2::event::emit<CanvasAddedEvent>(v0);
    }

    public(friend) fun emit_pixels_painted_event(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<0x1::string::String>, arg3: address, arg4: u64) {
        let v0 = PixelsPaintedEventV2{
            pixels_x : arg0,
            pixels_y : arg1,
            color    : arg2,
            painter  : arg3,
            cost     : arg4,
        };
        0x2::event::emit<PixelsPaintedEventV2>(v0);
    }

    public(friend) fun emit_reward_event(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = RewardEvent{
            ticket_id : arg0,
            won       : arg1,
        };
        0x2::event::emit<RewardEvent>(v0);
    }

    public(friend) fun emit_wheel_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = WheelCratedEvent{
            wheel_id : arg0,
            creator  : arg1,
        };
        0x2::event::emit<WheelCratedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

