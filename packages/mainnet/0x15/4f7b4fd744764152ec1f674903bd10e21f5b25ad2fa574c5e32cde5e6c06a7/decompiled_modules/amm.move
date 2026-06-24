module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::amm {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        reserve_base: 0x2::balance::Balance<T0>,
        reserve_quote: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        swap_fee_bps: u64,
        locked_until: u64,
        fee_balance: 0x2::balance::Balance<T1>,
    }

    struct LpPosition has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lp_shares: u64,
        locked: bool,
    }

    public fun collect_fees<T0, T1>(arg0: &mut Pool<T0, T1>) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.fee_balance)
    }

    public fun create_pool<T0, T1>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::pool_id(arg0);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 400);
        let v1 = 0x2::balance::value<T0>(&arg1);
        let v2 = 0x2::balance::value<T1>(&arg2);
        assert!(v1 > 0 && v2 > 0, 403);
        let v3 = sqrt(v1 * v2);
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = Pool<T0, T1>{
            id            : v4,
            launch_id     : 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg0),
            reserve_base  : arg1,
            reserve_quote : arg2,
            lp_supply     : v3,
            swap_fee_bps  : 30,
            locked_until  : arg3,
            fee_balance   : 0x2::balance::zero<T1>(),
        };
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::set_pool_id(arg0, v5);
        let v7 = LpPosition{
            id        : 0x2::object::new(arg4),
            pool_id   : v5,
            lp_shares : v3,
            locked    : true,
        };
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_pool_activated(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg0), v5, v1, v2, arg3);
        0x2::transfer::share_object<Pool<T0, T1>>(v6);
        0x2::transfer::transfer<LpPosition>(v7, 0x2::tx_context::sender(arg4));
        v5
    }

    public fun locked_until<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.locked_until
    }

    public fun pool_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun reserve_base<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_base)
    }

    public fun reserve_quote<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserve_quote)
    }

    fun sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0 / 2 + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public entry fun swap_base_for_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.locked_until, 401);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_quote) * v0 / (0x2::balance::value<T0>(&arg0.reserve_base) + v0);
        let v2 = v1 * arg0.swap_fee_bps / 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::bps_denominator();
        assert!(v1 - v2 >= arg2, 402);
        0x2::balance::join<T0>(&mut arg0.reserve_base, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::balance::split<T1>(&mut arg0.reserve_quote, v1);
        0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::balance::split<T1>(&mut v3, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_quote_for_base<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.locked_until, 401);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = v0 * arg0.swap_fee_bps / 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::bps_denominator();
        let v2 = v0 - v1;
        let v3 = 0x2::balance::value<T0>(&arg0.reserve_base) * v2 / (0x2::balance::value<T1>(&arg0.reserve_quote) + v2);
        assert!(v3 >= arg2, 402);
        let v4 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::balance::split<T1>(&mut v4, v1));
        0x2::balance::join<T1>(&mut arg0.reserve_quote, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_base, v3), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

