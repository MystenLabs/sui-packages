module 0x5bd161ea8e0a9dd1e0119315998943cde43650ba0cd8f67e81e39e8288bb1de5::swap {
    struct LiquidPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        rate_a2b_100: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCreateEvent has copy, drop {
        coin_a: 0x1::ascii::String,
        coin_b: 0x1::ascii::String,
        balance_a: u64,
        balance_b: u64,
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0;
        let v2 = 0x2::coin::value<T1>(&arg1);
        let v3 = v2;
        let v4 = v0 * arg2;
        let v5 = v2 * 100;
        if (v4 > v5) {
            let v6 = v5 / arg2;
            v1 = v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) - v6, arg3), 0x2::tx_context::sender(arg3));
        } else if (v4 < v5) {
            let v7 = v4 / 100;
            v3 = v7;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, 0x2::coin::value<T1>(&arg1) - v7, arg3), 0x2::tx_context::sender(arg3));
        };
        let v8 = LiquidPool<T0, T1>{
            id           : 0x2::object::new(arg3),
            balance_a    : 0x2::coin::into_balance<T0>(arg0),
            balance_b    : 0x2::coin::into_balance<T1>(arg1),
            rate_a2b_100 : arg2,
        };
        0x2::transfer::share_object<LiquidPool<T0, T1>>(v8);
        let v9 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        let v10 = 0x1::type_name::get<0x2::coin::Coin<T1>>();
        let v11 = PoolCreateEvent{
            coin_a    : *0x1::type_name::borrow_string(&v9),
            coin_b    : *0x1::type_name::borrow_string(&v10),
            balance_a : v1,
            balance_b : v3,
        };
        0x2::event::emit<PoolCreateEvent>(v11);
    }

    public fun get_pool_balance<T0, T1>(arg0: &LiquidPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun swap_a2b<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1) * arg0.rate_a2b_100 / 100;
        assert!(v0 <= 0x2::balance::value<T1>(&arg0.balance_b), 9223372174293729279);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v0), arg2)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1) * 100 / arg0.rate_a2b_100;
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance_a), 9223372225833336831);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

