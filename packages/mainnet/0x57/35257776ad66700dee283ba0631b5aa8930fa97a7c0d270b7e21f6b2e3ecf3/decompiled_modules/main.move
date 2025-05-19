module 0x5735257776ad66700dee283ba0631b5aa8930fa97a7c0d270b7e21f6b2e3ecf3::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    struct AdminCapability has store, key {
        id: 0x2::object::UID,
    }

    struct MainConfig has store, key {
        id: 0x2::object::UID,
        fee_recipient: address,
        open_market_fee: u64,
        finalize_market_fee_bps: u64,
    }

    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        curator: address,
        market_open: u64,
        market_only_whitelist: u64,
        market_close: u64,
        soft_cap: u64,
        hard_cap: u64,
        total_priority_cap: u64,
        cap_per_address: u64,
        presale_rate_x64: u128,
        initialize_price_x64: u128,
        priority_rate_x64: u128,
        add_liquidity_bps: u64,
        lp_lock_period: u64,
        is_auto_add_liquidity: bool,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        priority_caps: 0x2::table::Table<address, u64>,
        contributions: 0x2::table::Table<address, u64>,
        is_finalized: bool,
        contributed: u64,
        total_claimable_x: u64,
    }

    struct Proof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        contributed_y: u64,
        claimable_x: u64,
    }

    struct Locker<T0> {
        item: T0,
        unlock_at: u64,
    }

    fun add<T0, T1>(arg0: &mut Market<T0, T1>, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (0x2::table::contains<address, u64>(&arg0.priority_caps, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.priority_caps, v0) = v1;
            };
            0x2::table::add<address, u64>(&mut arg0.priority_caps, v0, v1);
        };
    }

    public fun add_priority_caps<T0, T1>(arg0: &AdminCapability, arg1: &mut Market<T0, T1>, arg2: vector<address>, arg3: vector<u64>) {
        add<T0, T1>(arg1, arg2, arg3);
    }

    public fun claim<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Proof<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_finalized, 9);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 8);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : _,
            claimable_x   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::take<T0>(&mut arg0.balance_x, arg1.claimable_x, arg2)
    }

    fun collect_finalize_market_fee<T0, T1>(arg0: &MainConfig, arg1: &mut Market<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, arg1.contributed * arg0.finalize_market_fee_bps / 10000), arg2), arg0.fee_recipient);
    }

    fun collect_open_market_fee<T0>(arg0: &MainConfig, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.open_market_fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.fee_recipient);
    }

    public fun contribute<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Proof<T0, T1>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!arg0.is_finalized, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.market_open && v1 <= arg0.market_close, 3);
        let v2 = false;
        if (v1 < arg0.market_only_whitelist && arg0.contributed < arg0.total_priority_cap) {
            assert!(is_priority_address<T0, T1>(arg0, v0), 4);
            v2 = true;
        };
        let v3 = effective_amount<T0, T1>(arg0, v0, 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1)), v2);
        arg0.contributed = arg0.contributed + v3;
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v3, arg3)));
        let v4 = arg0.presale_rate_x64;
        if (v2) {
            v4 = arg0.priority_rate_x64;
        };
        let v5 = ((18446744073709551616 * (v3 as u128) / v4) as u64);
        arg0.total_claimable_x = arg0.total_claimable_x + v5;
        let v6 = Proof<T0, T1>{
            id            : 0x2::object::new(arg3),
            market_id     : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            contributed_y : v3,
            claimable_x   : v5,
        };
        (v6, arg1)
    }

    public fun create_market<T0, T1>(arg0: &MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u128, arg11: u64, arg12: u64, arg13: bool, arg14: 0x2::coin::Coin<T0>, arg15: 0x2::coin::Coin<T1>, arg16: vector<address>, arg17: vector<u64>, arg18: &mut 0x2::tx_context::TxContext) {
        validate_params(arg0, arg4, arg5, arg6, arg10, arg8, arg9, arg11, 0x2::coin::value<T0>(&arg14));
        collect_open_market_fee<T1>(arg0, arg15);
        let v0 = Market<T0, T1>{
            id                    : 0x2::object::new(arg18),
            curator               : 0x2::tx_context::sender(arg18),
            market_open           : arg1,
            market_only_whitelist : arg2,
            market_close          : arg3,
            soft_cap              : arg4,
            hard_cap              : arg5,
            total_priority_cap    : arg6,
            cap_per_address       : arg7,
            presale_rate_x64      : arg8,
            initialize_price_x64  : arg9,
            priority_rate_x64     : arg10,
            add_liquidity_bps     : arg11,
            lp_lock_period        : arg12,
            is_auto_add_liquidity : arg13,
            balance_x             : 0x2::coin::into_balance<T0>(arg14),
            balance_y             : 0x2::balance::zero<T1>(),
            priority_caps         : 0x2::table::new<address, u64>(arg18),
            contributions         : 0x2::table::new<address, u64>(arg18),
            is_finalized          : false,
            contributed           : 0,
            total_claimable_x     : 0,
        };
        let v1 = &mut v0;
        add<T0, T1>(v1, arg16, arg17);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
    }

    fun effective_amount<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.contributed > arg0.total_priority_cap) {
            v0 = arg0.total_priority_cap - arg0.contributed;
        };
        if (v0 + arg0.contributed > arg0.hard_cap) {
            v0 = arg0.hard_cap - arg0.contributed;
        };
        if (!0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        if (arg3 && v0 + *v1 > *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1) - *v1;
        };
        if (arg0.cap_per_address == 0) {
            return v0
        };
        if (!arg3 && v0 + *v1 > arg0.cap_per_address) {
            v0 = arg0.cap_per_address - *v1;
        };
        assert!(v0 != 0, 5);
        *v1 = *v1 + v0;
        v0
    }

    public fun finalize_dao<T0, T1>(arg0: &MainConfig, arg1: &mut Market<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Locker<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.curator == 0x2::tx_context::sender(arg7), 10);
        assert!(!arg1.is_finalized, 2);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::balance::value<T1>(&arg1.balance_y);
        assert!(v1 == arg1.hard_cap || v1 > arg1.soft_cap && v0 > arg1.market_close, 9);
        arg1.is_finalized = true;
        let v2 = arg1.add_liquidity_bps * v1 / 10000;
        let v3 = ((18446744073709551616 * (v2 as u128) / arg1.initialize_price_x64) as u64);
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v5 = 0x1::ascii::as_bytes(&v4);
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v7 = 0x1::ascii::as_bytes(&v6);
        let v8 = 0;
        let v9 = false;
        while (v8 < 0x1::vector::length<u8>(v5)) {
            let v10 = *0x1::vector::borrow<u8>(v5, v8);
            let v11 = *0x1::vector::borrow<u8>(v7, v8);
            if (v11 < v10) {
                break
            };
            if (v11 > v10) {
                v9 = true;
                break
            };
            v8 = v8 + 1;
        };
        let v12 = if (v9) {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg2, arg3, 60, sqrt(340282366920938463463374607431768211456 * (v2 as u256) / (v3 as u256)), 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v3), arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v2), arg7), arg4, arg5, true, arg6, arg7);
            let v16 = v13;
            let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v16);
            0x2::object::id_to_address(&v17);
            0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v15));
            0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v14));
            lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v16, v0 + arg1.lp_lock_period)
        } else {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg2, arg3, 60, sqrt(340282366920938463463374607431768211456 * (v3 as u256) / (v2 as u256)), 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v2), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v3), arg7), arg5, arg4, false, arg6, arg7);
            let v21 = v18;
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v21);
            0x2::object::id_to_address(&v22);
            0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v19));
            0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v20));
            lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, v0 + arg1.lp_lock_period)
        };
        collect_finalize_market_fee<T0, T1>(arg0, arg1, arg7);
        (v12, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, 0x2::balance::value<T0>(&arg1.balance_x) - arg1.total_claimable_x), arg7), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.balance_y), arg7))
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: &AdminCapability, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MainConfig{
            id                      : 0x2::object::new(arg3),
            fee_recipient           : 0x2::tx_context::sender(arg3),
            open_market_fee         : arg1,
            finalize_market_fee_bps : arg2,
        };
        0x2::transfer::share_object<MainConfig>(v0);
    }

    public fun is_priority_address<T0, T1>(arg0: &mut Market<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.priority_caps, arg1)
    }

    fun lock<T0>(arg0: T0, arg1: u64) : Locker<T0> {
        Locker<T0>{
            item      : arg0,
            unlock_at : arg1,
        }
    }

    public fun refund<T0, T1>(arg0: &mut Market<T0, T1>, arg1: Proof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.market_close, 6);
        assert!(arg0.contributed < arg0.soft_cap, 7);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 8);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : _,
            claimable_x   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::take<T1>(&mut arg0.balance_y, arg1.contributed_y, arg3)
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun unlock<T0>(arg0: Locker<T0>, arg1: &0x2::clock::Clock) : T0 {
        let Locker {
            item      : v0,
            unlock_at : v1,
        } = arg0;
        assert!(v1 <= 0x2::clock::timestamp_ms(arg1), 1);
        v0
    }

    fun validate_params(arg0: &MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
        assert!(arg1 <= arg2, 1);
        assert!(arg3 <= arg2, 1);
        assert!(arg7 + arg0.finalize_market_fee_bps <= 10000, 1);
        assert!(((18446744073709551616 * (arg3 as u128) / arg4) as u64) + ((18446744073709551616 * ((arg2 - arg3) as u128) / arg5) as u64) + ((18446744073709551616 * ((arg2 * arg7 / 10000) as u128) / arg6) as u64) <= arg8, 1);
    }

    // decompiled from Move bytecode v6
}

