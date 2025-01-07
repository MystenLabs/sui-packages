module 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        max_lot_size: u64,
        min_lot_size: u64,
        max_order_size: u64,
        min_order_size: u64,
        base_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
    }

    public fun base_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base_balance)
    }

    public(friend) fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = if (arg1 > 0) {
            if (arg1 < arg0) {
                if (arg3 > 0) {
                    arg3 < arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        Pool<T0, T1>{
            id             : 0x2::object::new(arg4),
            max_lot_size   : arg0,
            min_lot_size   : arg1,
            max_order_size : arg2,
            min_order_size : arg3,
            base_balance   : 0x2::balance::zero<T0>(),
            quote_balance  : 0x2::balance::zero<T1>(),
        }
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.base_balance, arg1);
        0x2::balance::join<T1>(&mut arg0.quote_balance, arg2);
    }

    public fun max_lot_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.max_lot_size
    }

    public fun max_order_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.max_order_size
    }

    public fun min_lot_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_lot_size
    }

    public fun min_order_size<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.min_order_size
    }

    public fun quote_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_balance)
    }

    public(friend) fun update_pool_config<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 > 0) {
            if (arg2 < arg1) {
                if (arg4 > 0) {
                    arg4 < arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        arg0.max_lot_size = arg1;
        arg0.min_lot_size = arg2;
        arg0.max_order_size = arg3;
        arg0.min_order_size = arg4;
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.base_balance, arg1), 0x2::balance::split<T1>(&mut arg0.quote_balance, arg2))
    }

    // decompiled from Move bytecode v6
}

