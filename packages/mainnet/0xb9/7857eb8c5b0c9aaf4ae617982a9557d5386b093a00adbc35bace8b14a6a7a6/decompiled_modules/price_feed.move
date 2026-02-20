module 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::price_feed {
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

