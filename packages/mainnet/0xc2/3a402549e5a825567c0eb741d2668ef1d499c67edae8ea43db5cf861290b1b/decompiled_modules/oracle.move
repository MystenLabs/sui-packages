module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle {
    struct Price has copy, drop {
        price: u128,
        conf: u128,
        publish_ms: u64,
    }

    public fun conf(arg0: &Price) : u128 {
        arg0.conf
    }

    public(friend) fun new(arg0: u128, arg1: u128, arg2: u64) : Price {
        Price{
            price      : arg0,
            conf       : arg1,
            publish_ms : arg2,
        }
    }

    public fun price(arg0: &Price) : u128 {
        arg0.price
    }

    public fun publish_ms(arg0: &Price) : u64 {
        arg0.publish_ms
    }

    // decompiled from Move bytecode v7
}

