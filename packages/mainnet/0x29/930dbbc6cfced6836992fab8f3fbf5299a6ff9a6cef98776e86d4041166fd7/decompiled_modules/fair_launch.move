module 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::fair_launch {
    struct FAIR_LAUNCH has drop {
        dummy_field: bool,
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
        tick_spacing: u32,
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

    struct MarketFinalized<phantom T0, phantom T1> has copy, drop {
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

    public fun add_priority_caps<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.curator == 0x2::tx_context::sender(arg3), 9);
        add<T0, T1>(arg0, arg1, arg2);
    }

    fun calculate_ticks(arg0: u32) : (u32, u32) {
        let v0 = 443636 - 443636 % arg0;
        (4294967295 - v0 + 1, v0)
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

    fun collect_finalize_market_fee<T0, T1>(arg0: &0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::MainConfig, arg1: &mut FairLaunch<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, arg1.contributed * 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::finalize_market_fee_bps(arg0) / 10000), arg2), 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::fee_recipient(arg0));
    }

    fun collect_open_market_fee<T0>(arg0: &0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::MainConfig, arg1: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) == 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::open_market_fee(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::fee_recipient(arg0));
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

    public fun create_fair_launch<T0, T1>(arg0: &0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::MainConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: vector<address>, arg12: vector<u64>, arg13: bool, arg14: vector<u8>, arg15: u32, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg3, 1);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg16), 1);
        validate_params(arg4, arg5, arg6, arg8, 0x2::coin::value<T0>(&arg9));
        collect_open_market_fee<T1>(arg0, arg10);
        let v0 = FairLaunch<T0, T1>{
            id                    : 0x2::object::new(arg17),
            curator               : 0x2::tx_context::sender(arg17),
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
            contributions         : 0x2::table::new<address, u64>(arg17),
            is_finalized          : false,
            contributed           : 0,
            tick_spacing          : arg15,
            admin_public_key      : arg14,
            signatures            : 0x2::table::new<vector<u8>, bool>(arg17),
            timestamp_last_ms     : 0,
            priority_caps         : 0x2::table::new<address, u64>(arg17),
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
        if (!0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg1);
        if (arg3 && v0 + *v1 > *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.priority_caps, arg1) - *v1;
        };
        if (v0 + *v1 > arg0.max_contribution) {
            v0 = arg0.max_contribution - *v1;
        };
        assert!(v0 != 0, 1);
        *v1 = *v1 + v0;
        v0
    }

    public fun finalize_fair_launch<T0, T1>(arg0: &0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::MainConfig, arg1: &mut FairLaunch<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::balance::value<T1>(&arg1.balance_y);
        assert!(v1 >= arg1.soft_cap && v0 > arg1.end_time, 8);
        if (v0 < arg1.timestamp_last_ms + 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::curator_finalizing_cooldown(arg0) || v0 < arg1.end_time + 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::curator_finalizing_cooldown(arg0)) {
            assert!(arg1.curator == 0x2::tx_context::sender(arg7), 9);
        };
        assert!(!arg1.is_finalized, 2);
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
            if (v11) {
                let v14 = sqrt(340282366920938463463374607431768211456 * (v4 as u256) / (v5 as u256));
                v3 = v14;
                let (v15, v16) = calculate_ticks(arg1.tick_spacing);
                let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg2, arg3, arg1.tick_spacing, v14, 0x1::string::utf8(b""), v15, v16, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v5), arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v4), arg7), arg4, arg5, true, arg6, arg7);
                let v20 = v17;
                let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v20);
                let v22 = 0x2::object::id_to_address(&v21);
                v2 = v22;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v19));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v18));
                0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::events::emit_lp_vault_created<T0, T1>(0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::events::get_id(&arg1.id), 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::vault::new_lp_vault<T0, T1>(v20, arg1.lp_lock_period + v0, arg1.curator, arg1.admin_public_key, 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::admin_key_id(arg0), arg7), arg1.curator, v22, v14, v4, v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v20));
            } else {
                let v23 = sqrt(340282366920938463463374607431768211456 * (v5 as u256) / (v4 as u256));
                v3 = v23;
                let (v24, v25) = calculate_ticks(arg1.tick_spacing);
                let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg2, arg3, arg1.tick_spacing, v23, 0x1::string::utf8(b""), v25, v24, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance_y, v4), arg7), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, v5), arg7), arg5, arg4, false, arg6, arg7);
                let v29 = v26;
                let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v29);
                let v31 = 0x2::object::id_to_address(&v30);
                v2 = v31;
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(v27));
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(v28));
                0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::events::emit_lp_vault_created<T0, T1>(0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::events::get_id(&arg1.id), 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::vault::new_lp_vault<T0, T1>(v29, arg1.lp_lock_period + v0, arg1.curator, arg1.admin_public_key, 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::main::admin_key_id(arg0), arg7), arg1.curator, v31, v23, v4, v5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v29));
            };
        };
        collect_finalize_market_fee<T0, T1>(arg0, arg1, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance_x, 0x2::balance::value<T0>(&arg1.balance_x) - arg1.total_sell_token_x), arg7), arg1.curator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.balance_y), arg7), arg1.curator);
        let v32 = MarketFinalized<T0, T1>{
            market_address     : 0x2::object::id_address<FairLaunch<T0, T1>>(arg1),
            finalize_time      : v0,
            lp_unlock_time     : arg1.lp_lock_period + v0,
            cetus_pool_address : v2,
            initialize_price   : v3,
        };
        0x2::event::emit<MarketFinalized<T0, T1>>(v32);
    }

    fun init(arg0: FAIR_LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_priority_address<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.priority_caps, arg1)
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

