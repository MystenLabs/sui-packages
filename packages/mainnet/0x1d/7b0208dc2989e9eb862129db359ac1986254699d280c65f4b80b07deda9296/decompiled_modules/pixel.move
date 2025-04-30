module 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel {
    struct Coordinates has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    struct Pixel has drop, store {
        coordinates: Coordinates,
        last_painter: 0x1::option::Option<address>,
        price_multiplier: u64,
        last_painted_at: u64,
        color: 0x1::string::String,
    }

    public fun calculate_fee(arg0: &Pixel, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: &0x2::clock::Clock) : u64 {
        if (is_multiplier_expired(arg0, arg1, arg2)) {
            0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::base_paint_fee(arg1)
        } else {
            0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::base_paint_fee(arg1) * 0x1::u64::pow(2, ((arg0.price_multiplier - 1) as u8))
        }
    }

    public fun color(arg0: &Pixel) : 0x1::string::String {
        arg0.color
    }

    public fun coordinates(arg0: &Pixel) : Coordinates {
        arg0.coordinates
    }

    public fun is_multiplier_expired(arg0: &Pixel, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: &0x2::clock::Clock) : bool {
        arg0.last_painted_at == 0 && false || 0x2::clock::timestamp_ms(arg2) - arg0.last_painted_at > 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::pixel_price_multiplier_reset_ms(arg1)
    }

    public fun last_painted_at(arg0: &Pixel) : u64 {
        arg0.last_painted_at
    }

    public fun last_painter(arg0: &Pixel) : 0x1::option::Option<address> {
        arg0.last_painter
    }

    public fun new_coordinates(arg0: u64, arg1: u64) : Coordinates {
        Coordinates{
            pos0 : arg0,
            pos1 : arg1,
        }
    }

    public(friend) fun new_pixel(arg0: u64, arg1: u64) : Pixel {
        Pixel{
            coordinates      : new_coordinates(arg0, arg1),
            last_painter     : 0x1::option::none<address>(),
            price_multiplier : 1,
            last_painted_at  : 0,
            color            : 0x1::string::utf8(b""),
        }
    }

    public(friend) fun paint(arg0: &mut Pixel, arg1: 0x1::string::String, arg2: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        update(arg0, arg1, arg2, arg3, 0x1::option::some<address>(0x2::tx_context::sender(arg4)));
    }

    public fun price_multiplier(arg0: &Pixel) : u64 {
        arg0.price_multiplier
    }

    fun update(arg0: &mut Pixel, arg1: 0x1::string::String, arg2: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<address>) {
        arg0.last_painter = arg4;
        arg0.last_painted_at = 0x2::clock::timestamp_ms(arg3);
        arg0.color = arg1;
        if (is_multiplier_expired(arg0, arg2, arg3)) {
            arg0.price_multiplier = 1;
        } else {
            arg0.price_multiplier = arg0.price_multiplier + 1;
        };
    }

    public fun x(arg0: Coordinates) : u64 {
        arg0.pos0
    }

    public fun y(arg0: Coordinates) : u64 {
        arg0.pos1
    }

    // decompiled from Move bytecode v6
}

