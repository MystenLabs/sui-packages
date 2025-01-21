module 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::quote {
    struct Quote<phantom T0, phantom T1> has copy, drop, store {
        base_amount: u64,
        quote_amount: u64,
        timestamp_ms: u64,
        quoter: address,
    }

    public fun base_amount<T0, T1>(arg0: &Quote<T0, T1>) : u64 {
        arg0.base_amount
    }

    public fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : Quote<T0, T1> {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                let v1 = 0x1::type_name::get<T0>();
                let v2 = 0x1::type_name::get<T1>();
                0x1::type_name::borrow_string(&v1) != 0x1::type_name::borrow_string(&v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        Quote<T0, T1>{
            base_amount  : arg0,
            quote_amount : arg1,
            timestamp_ms : arg2,
            quoter       : 0x2::tx_context::sender(arg3),
        }
    }

    public fun quote_amount<T0, T1>(arg0: &Quote<T0, T1>) : u64 {
        arg0.quote_amount
    }

    public fun quoter<T0, T1>(arg0: &Quote<T0, T1>) : address {
        arg0.quoter
    }

    public fun timestamp_ms<T0, T1>(arg0: &Quote<T0, T1>) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

