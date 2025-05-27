module 0x1a76ad77a85a2d58beb7d502aca3647b9a652ac975ee3487540ccb2770963::fair_launch {
    struct FAIR_LAUNCH has drop {
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
        curator_finalizing_cooldown: u64,
    }

    struct FairLaunch<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        curator: address,
        start_time: u64,
        market_only_whitelist: u64,
        end_time: u64,
        soft_cap: u64,
        max_contribution: u64,
        liquidity_percent: u64,
        lp_lock_period: u64,
        total_sell_token_x: u64,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        contributions: 0x2::table::Table<address, u64>,
        is_finalized: bool,
        contributed: u64,
        admin_public_key: vector<u8>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
        timestamp_last_ms: u64,
        priority_caps: 0x2::table::Table<address, u64>,
        is_auto_add_liquidity: bool,
    }

    struct Proof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        contributed_y: u64,
    }

    struct Locker<T0> has store, key {
        id: 0x2::object::UID,
        item: T0,
        unlock_at: u64,
    }

    struct FairLaunchCreated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        start_time: u64,
        market_only_whitelist: u64,
        end_time: u64,
        soft_cap: u64,
        max_contribution: u64,
        liquidity_percent: u64,
        lp_lock_period: u64,
        total_sell_token_x: u64,
        is_auto_add_liquidity: bool,
        admin_public_key: vector<u8>,
    }

    struct PriorityCapsUpdated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
    }

    struct FairLaunchContributed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        timestamp: u64,
        amount: u64,
        coin_y_address: address,
        sender: address,
        proof_address: address,
        reached_priority_cap: bool,
    }

    struct FairLaunchFinalized<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        finalize_time: u64,
        lp_unlock_time: u64,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct FairLaunchClaimed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        claimable_x: u64,
        recipient: address,
    }

    struct FairLaunchRefunded<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        recipient: address,
    }

    fun add<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            if (0x2::table::contains<address, u64>(&arg0.priority_caps, v0)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.priority_caps, v0) = v1;
                continue
            };
            0x2::table::add<address, u64>(&mut arg0.priority_caps, v0, v1);
        };
        let v2 = PriorityCapsUpdated<T0, T1>{market_address: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<PriorityCapsUpdated<T0, T1>>(v2);
    }

    public fun add_priority_caps<T0, T1>(arg0: &AdminCapability, arg1: &mut FairLaunch<T0, T1>, arg2: vector<address>, arg3: vector<u64>) {
        add<T0, T1>(arg1, arg2, arg3);
    }

    public fun claim<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: Proof<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_finalized, 8);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 7);
        let v0 = arg1.contributed_y * arg0.total_sell_token_x / arg0.contributed;
        let Proof {
            id            : v1,
            market_id     : _,
            contributed_y : v3,
        } = arg1;
        let v4 = v1;
        0x2::object::delete(v4);
        let v5 = FairLaunchClaimed<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v4),
            contributed_y  : v3,
            claimable_x    : v0,
            recipient      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FairLaunchClaimed<T0, T1>>(v5);
        0x2::coin::take<T0>(&mut arg0.balance_x, v0, arg2)
    }

    fun collect_finalize_market_fee<T0, T1>(arg0: &MainConfig, arg1: &mut FairLaunch<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, arg1.contributed * arg0.finalize_market_fee_bps / 10000), arg2), arg0.fee_recipient);
    }

    fun collect_open_market_fee<T0>(arg0: &MainConfig, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.open_market_fee, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.fee_recipient);
    }

    public fun contribute<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Proof<T0, T1>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.is_finalized, 2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 3);
        let v2 = false;
        let v3 = false;
        if (v1 < arg0.market_only_whitelist && arg0.contributed < arg0.soft_cap) {
            assert!(is_priority_address<T0, T1>(arg0, v0), 13);
            v2 = true;
        } else {
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.signatures, arg3), 11);
            assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.admin_public_key, &arg2) == true, 12);
            0x2::table::add<vector<u8>, bool>(&mut arg0.signatures, arg3, true);
        };
        let v4 = 0x2::coin::value<T1>(&arg1);
        assert!(v4 > 0, 1);
        let v5 = effective_amount<T0, T1>(arg0, v0, v4, v2);
        arg0.contributed = arg0.contributed + v5;
        if (v2 && arg0.contributed == arg0.soft_cap) {
            v3 = true;
        };
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v5, arg5)));
        let v6 = Proof<T0, T1>{
            id            : 0x2::object::new(arg5),
            market_id     : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            contributed_y : v5,
        };
        arg0.timestamp_last_ms = v1;
        let v7 = FairLaunchContributed<T0, T1>{
            market_address       : 0x2::object::uid_to_address(&arg0.id),
            timestamp            : v1,
            amount               : v5,
            coin_y_address       : 0x2::object::id_address<0x2::coin::Coin<T1>>(&arg1),
            sender               : v0,
            proof_address        : 0x2::object::uid_to_address(&v6.id),
            reached_priority_cap : v3,
        };
        0x2::event::emit<FairLaunchContributed<T0, T1>>(v7);
        (v6, arg1)
    }

    public fun create_fair_launch<T0, T1>(arg0: &MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: vector<address>, arg12: vector<u64>, arg13: bool, arg14: vector<u8>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg3, 1);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg15), 1);
        validate_params(arg4, arg5, arg6, arg8, 0x2::coin::value<T0>(&arg9));
        collect_open_market_fee<T1>(arg0, arg10);
        let v0 = FairLaunch<T0, T1>{
            id                    : 0x2::object::new(arg16),
            curator               : 0x2::tx_context::sender(arg16),
            start_time            : arg1,
            market_only_whitelist : arg2,
            end_time              : arg3,
            soft_cap              : arg4,
            max_contribution      : arg5,
            liquidity_percent     : arg6,
            lp_lock_period        : arg7,
            total_sell_token_x    : arg8,
            balance_x             : 0x2::coin::into_balance<T0>(arg9),
            balance_y             : 0x2::balance::zero<T1>(),
            contributions         : 0x2::table::new<address, u64>(arg16),
            is_finalized          : false,
            contributed           : 0,
            admin_public_key      : arg14,
            signatures            : 0x2::table::new<vector<u8>, bool>(arg16),
            timestamp_last_ms     : 0,
            priority_caps         : 0x2::table::new<address, u64>(arg16),
            is_auto_add_liquidity : arg13,
        };
        let v1 = &mut v0;
        add<T0, T1>(v1, arg11, arg12);
        0x2::transfer::share_object<FairLaunch<T0, T1>>(v0);
        let v2 = FairLaunchCreated<T0, T1>{
            market_address        : 0x2::object::uid_to_address(&v0.id),
            start_time            : arg1,
            market_only_whitelist : arg2,
            end_time              : arg3,
            soft_cap              : arg4,
            max_contribution      : arg5,
            liquidity_percent     : arg6,
            lp_lock_period        : arg7,
            total_sell_token_x    : arg8,
            is_auto_add_liquidity : arg13,
            admin_public_key      : arg14,
        };
        0x2::event::emit<FairLaunchCreated<T0, T1>>(v2);
    }

    fun effective_amount<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.contributed > arg0.soft_cap) {
            v0 = arg0.soft_cap - arg0.contributed;
        };
        if (v0 + arg0.contributed > arg0.max_contribution) {
            v0 = arg0.max_contribution - arg0.contributed;
        };
        if (!0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        if (arg3 && v0 + *v1 > *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1) - *v1;
        };
        assert!(v0 != 0, 1);
        *v1 = *v1 + v0;
        v0
    }

    public fun finalize_fair_launch<T0, T1>(arg0: &MainConfig, arg1: &mut FairLaunch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.curator == 0x2::tx_context::sender(arg7), 9);
        assert!(!arg1.is_finalized, 2);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::balance::value<T1>(&arg1.balance_y);
        assert!(v1 > arg1.soft_cap && v0 > arg1.end_time, 8);
        arg1.is_finalized = true;
        let v2 = @0x0;
        let v3 = 0;
        if (arg1.is_auto_add_liquidity) {
            let v4 = v1 * arg1.liquidity_percent / 10000;
            let v5 = arg1.total_sell_token_x * arg1.liquidity_percent / 10000;
            let v6 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
            let v7 = 0x1::ascii::as_bytes(&v6);
            let v8 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            let v9 = 0x1::ascii::as_bytes(&v8);
            let v10 = 0;
            let v11 = false;
            while (v10 < 0x1::vector::length<u8>(v7)) {
                let v12 = *0x1::vector::borrow<u8>(v7, v10);
                let v13 = *0x1::vector::borrow<u8>(v9, v10);
                if (v13 < v12) {
                    break
                };
                if (v13 > v12) {
                    v11 = true;
                    break
                };
                v10 = v10 + 1;
            };
            let v14 = if (v11) {
                let v15 = sqrt(340282366920938463463374607431768211456 * (v4 as u256) / (v5 as u256));
                v3 = v15;
                let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg2, arg3, 60, v15, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v5), arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v4), arg7), arg4, arg5, true, arg6, arg7);
                let v19 = v16;
                let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v19);
                v2 = 0x2::object::id_to_address(&v20);
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v18));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v17));
                lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v19, v0 + arg1.lp_lock_period, arg7)
            } else {
                let v21 = sqrt(340282366920938463463374607431768211456 * (v5 as u256) / (v4 as u256));
                v3 = v21;
                let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg2, arg3, 60, v21, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v4), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v5), arg7), arg5, arg4, false, arg6, arg7);
                let v25 = v22;
                let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v25);
                v2 = 0x2::object::id_to_address(&v26);
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v23));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v24));
                lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v25, v0 + arg1.lp_lock_period, arg7)
            };
            0x2::transfer::public_transfer<Locker<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v14, arg1.curator);
        };
        collect_finalize_market_fee<T0, T1>(arg0, arg1, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, 0x2::balance::value<T0>(&arg1.balance_x) - arg1.total_sell_token_x), arg7), arg1.curator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.balance_y), arg7), arg1.curator);
        let v27 = FairLaunchFinalized<T0, T1>{
            market_address     : 0x2::object::id_address<FairLaunch<T0, T1>>(arg1),
            finalize_time      : v0,
            lp_unlock_time     : v0 + arg1.lp_lock_period,
            cetus_pool_address : v2,
            initialize_price   : v3,
        };
        0x2::event::emit<FairLaunchFinalized<T0, T1>>(v27);
    }

    fun init(arg0: FAIR_LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: &AdminCapability, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MainConfig{
            id                          : 0x2::object::new(arg4),
            fee_recipient               : 0x2::tx_context::sender(arg4),
            open_market_fee             : arg1,
            finalize_market_fee_bps     : arg2,
            curator_finalizing_cooldown : arg3,
        };
        0x2::transfer::share_object<MainConfig>(v0);
    }

    public fun is_priority_address<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.priority_caps, arg1)
    }

    fun lock<T0>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Locker<T0> {
        Locker<T0>{
            id        : 0x2::object::new(arg2),
            item      : arg0,
            unlock_at : arg1,
        }
    }

    public fun refund<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: Proof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_time, 4);
        assert!(arg0.contributed < arg0.soft_cap, 6);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 7);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : v2,
        } = arg1;
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = FairLaunchRefunded<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v3),
            contributed_y  : v2,
            recipient      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FairLaunchRefunded<T0, T1>>(v4);
        0x2::coin::take<T1>(&mut arg0.balance_y, arg1.contributed_y, arg3)
    }

    public fun refund_to_curator<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.curator == 0x2::tx_context::sender(arg2), 9);
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 4);
        assert!(arg0.contributed < arg0.soft_cap, 6);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_x), arg2)
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
            id        : v0,
            item      : v1,
            unlock_at : v2,
        } = arg0;
        assert!(v2 <= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::object::delete(v0);
        v1
    }

    public fun update_proof<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: &mut Proof<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::object::uid_to_address(&arg1.id) == 0x2::tx_context::sender(arg3), 1);
        arg1.contributed_y = arg1.contributed_y + arg2;
        arg0.contributed = arg0.contributed + arg2;
    }

    fun validate_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 1);
        assert!(arg2 >= 4900, 10);
        assert!(arg2 <= 98000, 10);
        assert!(arg3 > 0, 1);
        assert!(arg4 > 0, 1);
        assert!(arg3 + arg3 * arg2 / 10000 <= arg4, 1);
    }

    // decompiled from Move bytecode v6
}

