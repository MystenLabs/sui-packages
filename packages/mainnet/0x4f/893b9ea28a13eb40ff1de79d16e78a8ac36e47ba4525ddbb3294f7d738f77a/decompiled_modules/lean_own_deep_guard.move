module 0x4f893b9ea28a13eb40ff1de79d16e78a8ac36e47ba4525ddbb3294f7d738f77a::lean_own_deep_guard {
    struct Ticket<phantom T0, phantom T1> {
        owner: address,
        source: 0x2::object::ID,
        before: u64,
        reserve: u64,
        floor: u64,
        deadline_ms: u64,
    }

    struct Completed has copy, drop {
        owner: address,
        source: 0x2::object::ID,
        fee_spent: u64,
        usdc_returned: u64,
        floor: u64,
        execution_ms: u64,
        deadline_ms: u64,
    }

    public fun begin<T0, T1>(arg0: &mut 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Ticket<T0, T1>) {
        assert!(arg2 > 0 && arg2 <= 5000000000, 1);
        assert!(arg1 > 0 && arg1 <= 100000000, 1);
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg5 >= 30000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = if (0x2::tx_context::gas_price(arg9) == 2000) {
            let v2 = 0x2::tx_context::sponsor(arg9);
            0x1::option::is_none<address>(&v2)
        } else {
            false
        };
        assert!(v1, 1);
        let v3 = arg3 + arg4 + arg5;
        assert!(v3 < arg2, 1);
        assert!(arg6 <= arg7 && arg7 - arg6 >= 1000, 2);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg6, 2);
        let v4 = Ticket<T0, T1>{
            owner       : 0x2::tx_context::sender(arg9),
            source      : 0x2::object::id<0x2::coin::Coin<T1>>(arg0),
            before      : 0x2::coin::value<T1>(arg0),
            reserve     : arg1,
            floor       : v3,
            deadline_ms : arg6,
        };
        (0x2::coin::split<T1>(arg0, arg1, arg9), v4)
    }

    public fun finish<T0, T1>(arg0: Ticket<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let Ticket {
            owner       : v0,
            source      : v1,
            before      : v2,
            reserve     : v3,
            floor       : v4,
            deadline_ms : v5,
        } = arg0;
        assert!(0x2::tx_context::sender(arg4) == v0, 5);
        assert!(0x2::clock::timestamp_ms(arg3) <= v5, 2);
        let v6 = 0x2::coin::value<T1>(&arg2);
        let v7 = if (0x2::object::id<0x2::coin::Coin<T1>>(&arg2) == v1) {
            if (v6 <= v2) {
                v2 - v6 <= v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 3);
        assert!(0x2::coin::value<T0>(&arg1) >= v4, 4);
        let v8 = Completed{
            owner         : v0,
            source        : v1,
            fee_spent     : v2 - v6,
            usdc_returned : 0x2::coin::value<T0>(&arg1),
            floor         : v4,
            execution_ms  : 0x2::clock::timestamp_ms(arg3),
            deadline_ms   : v5,
        };
        0x2::event::emit<Completed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v0);
    }

    // decompiled from Move bytecode v7
}

