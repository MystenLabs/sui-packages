module 0x9ae186172fe051dfc2e6e596b8cf623c64ce8a39fdc41dd0cb0a488156d26f9::route {
    struct Route<phantom T0> {
        debt: u64,
        min_profit: u64,
        hops: u64,
    }

    struct RouteProfit has copy, drop {
        debt: u64,
        profit: u64,
        hops: u64,
        to: address,
    }

    public fun close<T0>(arg0: Route<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let Route {
            debt       : v0,
            min_profit : v1,
            hops       : v2,
        } = arg0;
        assert!(0x2::balance::value<T0>(&arg1) >= v0 + v1, 110);
        let v3 = 0x2::balance::value<T0>(&arg1);
        let v4 = 0x2::tx_context::sender(arg2);
        let v5 = RouteProfit{
            debt   : v0,
            profit : v3,
            hops   : v2,
            to     : v4,
        };
        0x2::event::emit<RouteProfit>(v5);
        if (v3 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), v4);
        };
        0x2::balance::split<T0>(&mut arg1, v0)
    }

    public fun min_out_code() : u64 {
        113
    }

    public fun min_profit_code() : u64 {
        110
    }

    public fun open<T0>(arg0: u64, arg1: u64) : Route<T0> {
        Route<T0>{
            debt       : arg0,
            min_profit : arg1,
            hops       : 0,
        }
    }

    public fun required<T0>(arg0: &Route<T0>) : u64 {
        arg0.debt + arg0.min_profit
    }

    public fun tick<T0, T1>(arg0: &mut Route<T0>, arg1: &0x2::balance::Balance<T1>, arg2: u64) {
        assert!(0x2::balance::value<T1>(arg1) >= arg2, 113);
        arg0.hops = arg0.hops + 1;
    }

    // decompiled from Move bytecode v7
}

