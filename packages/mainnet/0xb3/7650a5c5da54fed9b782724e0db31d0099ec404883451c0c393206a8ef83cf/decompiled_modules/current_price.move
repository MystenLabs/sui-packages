module 0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price {
    struct CurrentPrice<phantom T0> has copy, drop {
        price: u64,
        decimals: u8,
        timestamp_ms: u64,
    }

    public fun decimals<T0>(arg0: &CurrentPrice<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun new_current_price<T0>(arg0: u64, arg1: u8, arg2: u64) : CurrentPrice<T0> {
        CurrentPrice<T0>{
            price        : arg0,
            decimals     : arg1,
            timestamp_ms : arg2,
        }
    }

    public fun price<T0>(arg0: &CurrentPrice<T0>) : u64 {
        arg0.price
    }

    public fun timestamp_ms<T0>(arg0: &CurrentPrice<T0>) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

