module 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas {
    struct Coordinate has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    struct Canvas has store, key {
        id: 0x2::object::UID,
        chunks: 0x2::object_table::ObjectTable<Coordinate, CanvasChunk>,
        rules: 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules,
        ticket_odds: u64,
        fee_router: 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::FeeRouter,
    }

    struct CanvasChunk has store, key {
        id: 0x2::object::UID,
        pixels: vector<vector<Pixel>>,
    }

    struct Pixel has copy, drop, store {
        color: 0x1::string::String,
        cost: u64,
        last_painter: address,
        last_painted_at: u64,
    }

    public fun add_new_chunk(arg0: &mut Canvas, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<Pixel>>();
        let v1 = 0;
        while (v1 < 45) {
            let v2 = 0x1::vector::empty<Pixel>();
            let v3 = 0;
            while (v3 < 45) {
                let v4 = Pixel{
                    color           : 0x1::string::utf8(b""),
                    cost            : 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::base_paint_fee(&arg0.rules),
                    last_painter    : 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::canvas_treasury(&arg0.rules),
                    last_painted_at : 0,
                };
                0x1::vector::push_back<Pixel>(&mut v2, v4);
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<Pixel>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v5 = CanvasChunk{
            id     : 0x2::object::new(arg2),
            pixels : v0,
        };
        let v6 = 0x2::object_table::length<Coordinate, CanvasChunk>(&arg0.chunks);
        0x2::object_table::add<Coordinate, CanvasChunk>(&mut arg0.chunks, get_next_chunk_location(v6), v5);
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_canvas_added_event(0x2::object::id<CanvasChunk>(&v5), v6);
    }

    public fun calculate_cost_in_paint(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules, arg1: u64) : u64 {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::paint_coin_fee(arg0) * arg1
    }

    public fun calculate_pixels_paint_fee(arg0: &Canvas, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + get_cost(pixel(arg0, *0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1)), &arg0.rules, arg3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun color(arg0: &Pixel) : 0x1::string::String {
        arg0.color
    }

    public fun cost(arg0: &Pixel) : u64 {
        arg0.cost
    }

    public(friend) fun fee_router_mut(arg0: &mut Canvas) : &mut 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::FeeRouter {
        &mut arg0.fee_router
    }

    public fun get_accrued_fees(arg0: &Canvas, arg1: address) : u64 {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::get_accrued_fees(&arg0.fee_router, arg1)
    }

    public fun get_chunk_coordinate_from_pixel(arg0: u64, arg1: u64) : Coordinate {
        Coordinate{
            pos0 : arg0 / 45,
            pos1 : arg1 / 45,
        }
    }

    public fun get_cost(arg0: &Pixel, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules, arg2: &0x2::clock::Clock) : u64 {
        if (is_multiplier_expired(arg0, arg1, arg2)) {
            0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::base_paint_fee(arg1)
        } else {
            arg0.cost
        }
    }

    public fun get_next_chunk_location(arg0: u64) : Coordinate {
        if (arg0 == 0) {
            return Coordinate{
                pos0 : 0,
                pos1 : 0,
            }
        };
        let v0 = 0x1::u64::sqrt(arg0);
        let v1 = arg0 - v0 * v0;
        if (v1 <= v0) {
            return Coordinate{
                pos0 : v1,
                pos1 : v0,
            }
        };
        Coordinate{
            pos0 : v0,
            pos1 : 2 * v0 - v1,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Canvas{
            id          : 0x2::object::new(arg0),
            chunks      : 0x2::object_table::new<Coordinate, CanvasChunk>(arg0),
            rules       : 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::new_rules(10000000, 2177280000000, 0x2::tx_context::sender(arg0), 100000000),
            ticket_odds : 10000,
            fee_router  : 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::new_fee_router(arg0),
        };
        0x2::transfer::share_object<Canvas>(v0);
    }

    public fun is_multiplier_expired(arg0: &Pixel, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules, arg2: &0x2::clock::Clock) : bool {
        arg0.last_painted_at == 0 && false || 0x2::clock::timestamp_ms(arg2) - arg0.last_painted_at > 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::pixel_price_multiplier_reset_ms(arg1)
    }

    public fun last_painted_at(arg0: &Pixel) : u64 {
        arg0.last_painted_at
    }

    public fun last_painter(arg0: &Pixel) : address {
        arg0.last_painter
    }

    public fun offset_pixel_coordinate(arg0: u64, arg1: u64, arg2: Coordinate) : (u64, u64) {
        (arg0 - x(arg2) * 45, arg1 - y(arg2) * 45)
    }

    public fun paint(arg0: &mut Pixel, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg0.last_painter = 0x2::tx_context::sender(arg4);
        arg0.last_painted_at = 0x2::clock::timestamp_ms(arg3);
        arg0.color = arg2;
        if (is_multiplier_expired(arg0, arg1, arg3)) {
            arg0.cost = 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::base_paint_fee(arg1) * 2;
        } else {
            arg0.cost = arg0.cost * 2;
        };
    }

    entry fun paint_pixels(arg0: &mut Canvas, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906834629609979906);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= calculate_pixels_paint_fee(arg0, arg1, arg2, arg4), 13906834646789980164);
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::deposit_payment(&mut arg0.fee_router, arg6);
        let v0 = arg0.rules;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = pixel_mut(arg0, *0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1));
            let v3 = v2.last_painter;
            let v4 = get_cost(v2, &v0, arg4);
            paint(v2, &v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), arg4, arg7);
            let v5 = if (v4 == 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::base_paint_fee(&v0)) {
                0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::canvas_treasury(&v0)
            } else {
                v3
            };
            0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::record_fee(&mut arg0.fee_router, v5, v4);
            v1 = v1 + 1;
        };
        let v6 = 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::create_ticket(arg0.ticket_odds, (0x1::vector::length<u64>(&arg1) as u16), arg5, arg7);
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_reward_event(0x2::object::id<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(&v6), 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::is_valid(&v6));
        if (0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::is_valid(&v6)) {
            0x2::transfer::public_transfer<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(v6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(v6, @0x0);
        };
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_pixels_painted_event(arg1, arg2, arg3, 0x2::tx_context::sender(arg7), 0x2::coin::value<0x2::sui::SUI>(&arg6));
    }

    entry fun paint_pixels_with_paint(arg0: &mut Canvas, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: 0x2::coin::Coin<0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin::PAINT_COIN>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 13906834968912396290);
        assert!(0x2::coin::value<0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin::PAINT_COIN>(&arg6) >= calculate_cost_in_paint(rules(arg0), 0x1::vector::length<u64>(&arg1)), 13906834998977298436);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin::PAINT_COIN>>(arg6, 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::canvas_treasury(rules(arg0)));
        let v0 = arg0.rules;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = pixel_mut(arg0, *0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1));
            paint(v2, &v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), arg4, arg7);
            v1 = v1 + 1;
        };
        let v3 = 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::create_ticket(arg0.ticket_odds, (0x1::vector::length<u64>(&arg1) as u16), arg5, arg7);
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_reward_event(0x2::object::id<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(&v3), 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::is_valid(&v3));
        if (0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::is_valid(&v3)) {
            0x2::transfer::public_transfer<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(v3, 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards::Ticket>(v3, @0x0);
        };
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_pixels_painted_event(arg1, arg2, arg3, 0x2::tx_context::sender(arg7), 0x2::coin::value<0x8d572055ac7168a40878ca9f90dfec10c11f77da086f215277da52ab06a62952::paint_coin::PAINT_COIN>(&arg6));
    }

    public fun pixel(arg0: &Canvas, arg1: u64, arg2: u64) : &Pixel {
        let v0 = get_chunk_coordinate_from_pixel(arg1, arg2);
        let (v1, v2) = offset_pixel_coordinate(arg1, arg2, v0);
        0x1::vector::borrow<Pixel>(0x1::vector::borrow<vector<Pixel>>(&0x2::object_table::borrow<Coordinate, CanvasChunk>(&arg0.chunks, v0).pixels, v1), v2)
    }

    fun pixel_mut(arg0: &mut Canvas, arg1: u64, arg2: u64) : &mut Pixel {
        let v0 = get_chunk_coordinate_from_pixel(arg1, arg2);
        let (v1, v2) = offset_pixel_coordinate(arg1, arg2, v0);
        0x1::vector::borrow_mut<Pixel>(0x1::vector::borrow_mut<vector<Pixel>>(&mut 0x2::object_table::borrow_mut<Coordinate, CanvasChunk>(&mut arg0.chunks, v0).pixels, v1), v2)
    }

    public fun rules(arg0: &Canvas) : &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasRules {
        &arg0.rules
    }

    public fun update_base_paint_fee(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut Canvas, arg2: u64) {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::update_base_paint_fee(&mut arg1.rules, arg2);
    }

    public fun update_canvas_treasury(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut Canvas, arg2: address) {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::update_canvas_treasury(&mut arg1.rules, arg2);
    }

    public fun update_pixel_price_multiplier_reset_ms(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut Canvas, arg2: u64) {
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::update_pixel_price_multiplier_reset_ms(&mut arg1.rules, arg2);
    }

    public fun update_ticket_odds(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut Canvas, arg2: u64) {
        arg1.ticket_odds = arg2;
    }

    public fun withdraw_fees(arg0: &mut Canvas, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::fee_router::withdraw_fees(&mut arg0.fee_router, arg1), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun x(arg0: Coordinate) : u64 {
        arg0.pos0
    }

    public fun y(arg0: Coordinate) : u64 {
        arg0.pos1
    }

    // decompiled from Move bytecode v6
}

