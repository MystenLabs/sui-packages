module 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::price_feed {
    struct PriceFeedComponent has copy, drop, store {
        value: u64,
        update_time: u64,
    }

    struct PriceFeed has copy, drop, store {
        spot: PriceFeedComponent,
        ema: 0x1::option::Option<PriceFeedComponent>,
        twap: 0x1::option::Option<PriceFeedComponent>,
    }

    public fun decimals() : u8 {
        9
    }

    public fun ema(arg0: &PriceFeed) : &PriceFeedComponent {
        0x1::option::borrow<PriceFeedComponent>(&arg0.ema)
    }

    public(friend) fun ensure_timestamp_not_stale(arg0: &PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) - update_time(arg0) * 1000 <= arg1, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::oracle_stale_price_error());
    }

    public(friend) fun multiply(arg0: &PriceFeedComponent, arg1: &PriceFeedComponent) : PriceFeedComponent {
        let v0 = if (update_time(arg0) > update_time(arg1)) {
            update_time(arg1)
        } else {
            update_time(arg0)
        };
        new_component(safe_cast_to_u64((value(arg0) as u128) * (value(arg1) as u128) / 1000000000), v0)
    }

    public(friend) fun new(arg0: PriceFeedComponent, arg1: PriceFeedComponent) : PriceFeed {
        PriceFeed{
            spot : arg0,
            ema  : 0x1::option::some<PriceFeedComponent>(arg1),
            twap : 0x1::option::none<PriceFeedComponent>(),
        }
    }

    public(friend) fun new_component(arg0: u64, arg1: u64) : PriceFeedComponent {
        PriceFeedComponent{
            value       : arg0,
            update_time : arg1,
        }
    }

    public(friend) fun safe_cast_to_u64(arg0: u128) : u64 {
        assert!(arg0 < 18446744073709551615, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::value_overflow());
        (arg0 as u64)
    }

    public(friend) fun set(arg0: &mut PriceFeed, arg1: PriceFeedComponent, arg2: PriceFeedComponent) {
        arg0.ema = 0x1::option::some<PriceFeedComponent>(arg2);
        arg0.spot = arg1;
    }

    public fun spot(arg0: &PriceFeed) : &PriceFeedComponent {
        &arg0.spot
    }

    public fun update_time(arg0: &PriceFeedComponent) : u64 {
        arg0.update_time
    }

    public fun value(arg0: &PriceFeedComponent) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

