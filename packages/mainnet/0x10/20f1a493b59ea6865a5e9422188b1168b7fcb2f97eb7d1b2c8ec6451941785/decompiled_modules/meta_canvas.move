module 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::meta_canvas {
    struct MetaCanvas has store, key {
        id: 0x2::object::UID,
        canvases: 0x2::object_table::ObjectTable<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>,
        rules: 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasRules,
        ticket_odds: u64,
    }

    public fun update_base_paint_fee(arg0: &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasAdminCap, arg1: &mut MetaCanvas, arg2: u64) {
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::update_base_paint_fee(&mut arg1.rules, arg2);
    }

    public fun update_canvas_treasury(arg0: &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasAdminCap, arg1: &mut MetaCanvas, arg2: address) {
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::update_canvas_treasury(&mut arg1.rules, arg2);
    }

    public fun update_pixel_price_multiplier_reset_ms(arg0: &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasAdminCap, arg1: &mut MetaCanvas, arg2: u64) {
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::update_pixel_price_multiplier_reset_ms(&mut arg1.rules, arg2);
    }

    public fun add_new_canvas(arg0: &mut MetaCanvas, arg1: &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::new_canvas(arg1, arg2);
        let v1 = 0x2::object_table::length<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&arg0.canvases);
        0x2::object_table::add<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&mut arg0.canvases, calculate_next_canvas_location(v1), v0);
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::events::emit_canvas_added_event(0x2::object::id<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&v0), v1);
    }

    public fun calculate_next_canvas_location(arg0: u64) : 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates {
        if (arg0 == 0) {
            return 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::new_coordinates(0, 0)
        };
        let v0 = 0x1::u64::sqrt(arg0);
        let v1 = arg0 - v0 * v0;
        if (v1 <= v0) {
            return 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::new_coordinates(v1, v0)
        };
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::new_coordinates(v0, 2 * v0 - v1)
    }

    public fun calculate_pixels_paint_fee(arg0: &MetaCanvas, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = get_canvas_coordinates_from_pixel(*0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1));
            let (v3, v4) = offset_pixel_coordinates(*0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1), v2);
            v0 = v0 + 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::calculate_pixel_paint_fee(0x2::object_table::borrow<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&arg0.canvases, v2), &arg0.rules, v3, v4, arg3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_canvas(arg0: &MetaCanvas, arg1: 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates) : &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas {
        0x2::object_table::borrow<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&arg0.canvases, arg1)
    }

    public fun get_canvas_coordinates_from_pixel(arg0: u64, arg1: u64) : 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates {
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::new_coordinates(arg0 / 45, arg1 / 45)
    }

    public fun get_pixel(arg0: &MetaCanvas, arg1: u64, arg2: u64) : &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Pixel {
        let v0 = get_canvas_coordinates_from_pixel(arg1, arg2);
        let (v1, v2) = offset_pixel_coordinates(arg1, arg2, v0);
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::pixel(0x2::object_table::borrow<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&arg0.canvases, v0), 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::new_coordinates(v1, v2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaCanvas{
            id          : 0x2::object::new(arg0),
            canvases    : 0x2::object_table::new<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(arg0),
            rules       : 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::new_rules(10000000, 300000, 0x2::tx_context::sender(arg0), 100000000),
            ticket_odds : 10000,
        };
        0x2::transfer::share_object<MetaCanvas>(v0);
    }

    public fun offset_pixel_coordinates(arg0: u64, arg1: u64, arg2: 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates) : (u64, u64) {
        (arg0 - 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::x(arg2) * 45, arg1 - 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::y(arg2) * 45)
    }

    entry fun paint_pixels(arg0: &mut MetaCanvas, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906834479286124546);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = get_canvas_coordinates_from_pixel(*0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0));
            let v2 = 0x2::object_table::borrow_mut<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&mut arg0.canvases, v1);
            let (v3, v4) = offset_pixel_coordinates(*0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0), v1);
            0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::paint_pixel(v2, &arg0.rules, v3, v4, *0x1::vector::borrow<0x1::string::String>(&arg3, v0), 0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::calculate_pixel_paint_fee(v2, &arg0.rules, v3, v4, arg4), arg7), arg4, arg7);
            v0 = v0 + 1;
        };
        let v5 = 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::create_ticket(arg0.ticket_odds, (0x1::vector::length<u64>(&arg1) as u16), arg5, arg7);
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::events::emit_reward_event(0x2::object::id<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::Ticket>(&v5), 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::is_valid(&v5));
        if (0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::is_valid(&v5)) {
            0x2::transfer::public_transfer<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::Ticket>(v5, 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::rewards::Ticket>(v5, @0x0);
        };
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::events::emit_pixels_painted_event(arg1, arg2, arg3, 0x2::tx_context::sender(arg7), 0x2::coin::value<0x2::sui::SUI>(&arg6) - 0x2::coin::value<0x2::sui::SUI>(&arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x2::tx_context::sender(arg7));
    }

    entry fun paint_pixels_with_paint(arg0: &mut MetaCanvas, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin::PAINT_COIN>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906834754164031490);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = get_canvas_coordinates_from_pixel(*0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0));
            let (v2, v3) = offset_pixel_coordinates(*0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0), v1);
            0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::paint_pixel_with_paint(0x2::object_table::borrow_mut<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::pixel::Coordinates, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas::Canvas>(&mut arg0.canvases, v1), &arg0.rules, v2, v3, *0x1::vector::borrow<0x1::string::String>(&arg3, v0), 0x2::coin::split<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin::PAINT_COIN>(&mut arg5, 0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::paint_coin_fee(&arg0.rules), arg6), arg4, arg6);
            v0 = v0 + 1;
        };
        0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::events::emit_pixels_painted_event(arg1, arg2, arg3, 0x2::tx_context::sender(arg6), 0x2::coin::value<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin::PAINT_COIN>(&arg5) - 0x2::coin::value<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin::PAINT_COIN>(&arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::paint_coin::PAINT_COIN>>(arg5, 0x2::tx_context::sender(arg6));
    }

    public fun rules(arg0: &MetaCanvas) : &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasRules {
        &arg0.rules
    }

    public fun update_ticket_odds(arg0: &0x1020f1a493b59ea6865a5e9422188b1168b7fcb2f97eb7d1b2c8ec6451941785::canvas_admin::CanvasAdminCap, arg1: &mut MetaCanvas, arg2: u64) {
        arg1.ticket_odds = arg2;
    }

    // decompiled from Move bytecode v6
}

