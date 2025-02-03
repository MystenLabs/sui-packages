module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::sale_type {
    struct Free has store {
        dummy_field: bool,
    }

    struct FixedPrice<phantom T0> has store {
        price: u64,
    }

    struct Refundable<phantom T0> has store {
        price: u64,
    }

    struct EnglishAuction<phantom T0> has store {
        start_price: u64,
        min_bid: u64,
    }

    struct DutchAuction<phantom T0> has store {
        start_price: u64,
        end_price: u64,
        curve_length: u16,
        drop_interval: u16,
    }

    public entry fun add_dutch_auction_sale_type<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: u64, arg3: u64, arg4: u16, arg5: u16, arg6: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config, arg7: &0x2::clock::Clock, arg8: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::EventOrganizerCap) {
        assert_coin_supported<T0>(arg6);
        let v0 = DutchAuction<T0>{
            start_price   : arg2,
            end_price     : arg3,
            curve_length  : arg4,
            drop_interval : arg5,
        };
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::add_sale_type<DutchAuction<T0>>(v0, arg0, arg1, arg7);
    }

    public entry fun add_english_auction_sale_type<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: u64, arg3: u64, arg4: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config, arg5: &0x2::clock::Clock, arg6: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::EventOrganizerCap) {
        assert_coin_supported<T0>(arg4);
        let v0 = EnglishAuction<T0>{
            start_price : arg2,
            min_bid     : arg3,
        };
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::add_sale_type<EnglishAuction<T0>>(v0, arg0, arg1, arg5);
    }

    public entry fun add_fixed_price_sale_type<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: u64, arg3: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config, arg4: &0x2::clock::Clock, arg5: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::EventOrganizerCap) {
        assert_coin_supported<T0>(arg3);
        let v0 = FixedPrice<T0>{price: arg2};
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::add_sale_type<FixedPrice<T0>>(v0, arg0, arg1, arg4);
    }

    public entry fun add_free_sale_type(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::EventOrganizerCap) {
        let v0 = Free{dummy_field: false};
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::add_sale_type<Free>(v0, arg0, arg1, arg2);
    }

    public entry fun add_refundable_sale_type<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: u64, arg3: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config, arg4: &0x2::clock::Clock, arg5: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::EventOrganizerCap) {
        assert_coin_supported<T0>(arg3);
        let v0 = Refundable<T0>{price: arg2};
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::add_sale_type<Refundable<T0>>(v0, arg0, arg1, arg4);
    }

    fun assert_coin_supported<T0>(arg0: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config) {
        let v0 = 0x1::hash::sha3_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::is_coin_supported(arg0, &v0), 1);
    }

    public fun get_fixed_price_amount<T0>(arg0: &FixedPrice<T0>) : u64 {
        arg0.price
    }

    public fun get_refundable_price_amount<T0>(arg0: &Refundable<T0>) : u64 {
        arg0.price
    }

    // decompiled from Move bytecode v6
}

