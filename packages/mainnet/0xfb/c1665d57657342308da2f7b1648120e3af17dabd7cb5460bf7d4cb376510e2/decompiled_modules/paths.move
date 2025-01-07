module 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths {
    struct PriceNode has copy, drop, store {
        from: u64,
        to: u64,
        arg: u16,
        sqrtPrice: u128,
    }

    struct PriceEvent has copy, drop, store {
        prices: vector<PriceNode>,
    }

    public(friend) fun copy_price_node(arg0: &PriceNode) : PriceNode {
        new_price_node(arg0.from, arg0.to, arg0.arg, arg0.sqrtPrice)
    }

    public(friend) fun emit_prices(arg0: vector<PriceNode>) {
        let v0 = PriceEvent{prices: arg0};
        0x2::event::emit<PriceEvent>(v0);
    }

    public(friend) fun new_price_node(arg0: u64, arg1: u64, arg2: u16, arg3: u128) : PriceNode {
        PriceNode{
            from      : arg0,
            to        : arg1,
            arg       : arg2,
            sqrtPrice : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

