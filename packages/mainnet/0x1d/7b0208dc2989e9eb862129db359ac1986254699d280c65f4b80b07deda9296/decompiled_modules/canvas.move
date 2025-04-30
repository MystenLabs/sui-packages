module 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas {
    struct Canvas has store, key {
        id: 0x2::object::UID,
        pixels: vector<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>,
        version: u64,
    }

    public fun calculate_pixel_paint_fee(arg0: &Canvas, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::calculate_fee(pixel(arg0, 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::new_coordinates(arg2, arg3)), arg1, arg4)
    }

    public fun calculate_pixels_paint_fee(arg0: &mut Canvas, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            v0 = v0 + calculate_pixel_paint_fee(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun id(arg0: &Canvas) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new_canvas(arg0: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasAdminCap, arg1: &mut 0x2::tx_context::TxContext) : Canvas {
        let v0 = 0x1::vector::empty<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>();
        let v1 = 0;
        while (v1 < 45) {
            let v2 = 0x1::vector::empty<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>();
            let v3 = 0;
            while (v3 < 45) {
                0x1::vector::push_back<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(&mut v2, 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::new_pixel(v1, v3));
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        Canvas{
            id      : 0x2::object::new(arg1),
            pixels  : v0,
            version : 1,
        }
    }

    public(friend) fun paint_pixel(arg0: &mut Canvas, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::calculate_fee(0x1::vector::borrow<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(0x1::vector::borrow<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&arg0.pixels, arg2), arg3), arg1, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v0, 13906834414861680643);
        route_fees(0x1::vector::borrow<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(0x1::vector::borrow<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&arg0.pixels, arg2), arg3), arg1, v0, arg5, arg6);
        0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::paint(0x1::vector::borrow_mut<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(0x1::vector::borrow_mut<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&mut arg0.pixels, arg2), arg3), arg4, arg1, arg6, arg7);
    }

    public(friend) fun paint_pixel_with_paint(arg0: &mut Canvas, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::paint_coin::PAINT_COIN>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::paint_coin::PAINT_COIN>(&arg5) == 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::paint_coin_fee(arg1), 13906834487876124675);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::paint_coin::PAINT_COIN>>(arg5, 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::canvas_treasury(arg1));
        0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::paint(0x1::vector::borrow_mut<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(0x1::vector::borrow_mut<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&mut arg0.pixels, arg2), arg3), arg4, arg1, arg6, arg7);
    }

    public fun pixel(arg0: &Canvas, arg1: 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Coordinates) : &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel {
        0x1::vector::borrow<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>(0x1::vector::borrow<vector<0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel>>(&arg0.pixels, 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::x(arg1)), 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::y(arg1))
    }

    fun route_fees(arg0: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::Pixel, arg1: &0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::CanvasRules, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        let v0 = 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::calculate_fee(arg0, arg1, arg4);
        assert!(arg2 >= v0, 13906834706919456771);
        let v1 = 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::pixel::last_painter(arg0);
        let v2 = 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::canvas_treasury(arg1);
        let v3 = 0x1::option::borrow_with_default<address>(&v1, &v2);
        if (v0 == 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::base_paint_fee(arg1)) {
            let v4 = 0x1d7b0208dc2989e9eb862129db359ac1986254699d280c65f4b80b07deda9296::canvas_admin::canvas_treasury(arg1);
            v3 = &v4;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, *v3);
    }

    // decompiled from Move bytecode v6
}

