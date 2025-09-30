module 0xb5c4f1fc22303e8cab7f6ed0990bae73ba5e406ed1237b0d1e338331bce2c2b7::sui_safe {
    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        start_time: u64,
        duration_ms: u64,
        strategy: u8,
    }

    struct YieldLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        start_time: u64,
        duration_ms: u64,
        principal_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        strategy: u8,
        market_balance: 0x2::balance::Balance<T0>,
    }

    struct TokenFeeConfig has copy, drop, store {
        deposit_fee_bps: u64,
        min_deposit_fee: u64,
        max_deposit_fee: u64,
    }

    struct Platform has store, key {
        id: 0x2::object::UID,
        admin: address,
        admin_cap_id: 0x2::object::ID,
        fees: 0x2::bag::Bag,
        yield_fees: 0x2::bag::Bag,
        deposit_fees: 0x2::bag::Bag,
        token_fee_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, TokenFeeConfig>,
        supported_tokens: vector<0x1::type_name::TypeName>,
        scallop_market_id: 0x1::option::Option<0x2::object::ID>,
        scallop_version_id: 0x1::option::Option<0x2::object::ID>,
        paused_deposits: bool,
        paused_withdrawals: bool,
    }

    struct UserRegistry has store, key {
        id: 0x2::object::UID,
        locks: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
        yield_locks: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        platform_id: 0x2::object::ID,
    }

    struct LockCreated<phantom T0> has copy, drop, store {
        owner: address,
        amount: u64,
        deposit_fee_paid: u64,
        start_time: u64,
        duration_ms: u64,
        strategy: u8,
    }

    struct LockExtended<phantom T0> has copy, drop, store {
        owner: address,
        added_amount: u64,
        deposit_fee_paid: u64,
        new_total: u64,
        strategy: u8,
    }

    struct LockWithdrawn<phantom T0> has copy, drop, store {
        owner: address,
        amount_withdrawn: u64,
        withdrawn_time: u64,
        strategy: u8,
    }

    struct YieldLockCreated has copy, drop, store {
        owner: address,
        principal_amount: u64,
        deposit_fee_paid: u64,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        duration_ms: u64,
        market_coin_id: 0x2::object::ID,
    }

    struct YieldLockWithdrawn has copy, drop, store {
        owner: address,
        principal_withdrawn: u64,
        yield_earned: u64,
        platform_yield_fee: u64,
        user_yield_amount: u64,
        withdrawn_time: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct TokenAdded has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        admin: address,
    }

    struct TokenFeeConfigUpdated has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        admin: address,
        deposit_fee_bps: u64,
        min_deposit_fee: u64,
        max_deposit_fee: u64,
    }

    struct ScallopConfigured has copy, drop, store {
        admin: address,
        market_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
    }

    struct FeesCollected<phantom T0> has copy, drop, store {
        admin: address,
        amount: u64,
        fee_type: u8,
    }

    struct PauseStatusChanged has copy, drop, store {
        admin: address,
        deposits_paused: bool,
        withdrawals_paused: bool,
    }

    public entry fun add_market_coin_support<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.deposit_fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.deposit_fees, v0, 0x2::balance::zero<T0>());
        };
    }

    public entry fun add_to_lock<T0>(arg0: &mut Lock<T0>, arg1: &mut Platform, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 1);
        assert!(arg0.strategy == 0, 3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg1.token_fee_configs, &v1), 9);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 1, 5);
        let v3 = calculate_deposit_fee(v2, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg1.token_fee_configs, &v1));
        assert!(v2 > v3, 8);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.deposit_fees, v1), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg3)));
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = 0x2::balance::value<T0>(&v4);
        0x2::balance::join<T0>(&mut arg0.balance, v4);
        assert!(v5 > 0, 5);
        let v6 = LockExtended<T0>{
            owner            : v0,
            added_amount     : v5,
            deposit_fee_paid : v3,
            new_total        : 0x2::balance::value<T0>(&arg0.balance),
            strategy         : arg0.strategy,
        };
        0x2::event::emit<LockExtended<T0>>(v6);
    }

    public entry fun add_token_support<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.supported_tokens, v1);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v1, 0x2::balance::zero<T0>());
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.yield_fees, v1, 0x2::balance::zero<T0>());
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.deposit_fees, v1, 0x2::balance::zero<T0>());
            let v2 = TokenFeeConfig{
                deposit_fee_bps : 10,
                min_deposit_fee : 0,
                max_deposit_fee : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, TokenFeeConfig>(&mut arg1.token_fee_configs, v1, v2);
            let v3 = TokenAdded{
                token_type : v1,
                admin      : v0,
            };
            0x2::event::emit<TokenAdded>(v3);
        };
    }

    fun calculate_deposit_fee(arg0: u64, arg1: &TokenFeeConfig) : u64 {
        let v0 = safe_mul_div(arg0, arg1.deposit_fee_bps, 10000);
        let v1 = if (v0 < arg1.min_deposit_fee) {
            arg1.min_deposit_fee
        } else {
            v0
        };
        let v2 = if (arg1.max_deposit_fee > 0 && v1 > arg1.max_deposit_fee) {
            arg1.max_deposit_fee
        } else {
            v1
        };
        if (v2 >= arg0) {
            arg0 - 1
        } else {
            v2
        }
    }

    public fun calculate_fee_for_amount<T0>(arg0: &Platform, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0)) {
            calculate_deposit_fee(arg1, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0))
        } else {
            0
        }
    }

    public entry fun collect_deposit_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.deposit_fees, v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.deposit_fees, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v2), arg2), v0);
            let v4 = FeesCollected<T0>{
                admin    : v0,
                amount   : v3,
                fee_type : 2,
            };
            0x2::event::emit<FeesCollected<T0>>(v4);
        };
    }

    public entry fun collect_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v2), arg2), v0);
            let v4 = FeesCollected<T0>{
                admin    : v0,
                amount   : v3,
                fee_type : 0,
            };
            0x2::event::emit<FeesCollected<T0>>(v4);
        };
    }

    public entry fun collect_yield_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.yield_fees, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v2), arg2), v0);
            let v4 = FeesCollected<T0>{
                admin    : v0,
                amount   : v3,
                fee_type : 1,
            };
            0x2::event::emit<FeesCollected<T0>>(v4);
        };
    }

    public entry fun complete_yield_withdrawal_with_redeemed_coin<T0, T1>(arg0: YieldLock<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut Platform, arg3: &mut UserRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused_withdrawals, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 1);
        let YieldLock {
            id               : v1,
            owner            : _,
            start_time       : v3,
            duration_ms      : v4,
            principal_amount : v5,
            coin_type        : v6,
            strategy         : _,
            market_balance   : v8,
        } = arg0;
        let v9 = v1;
        let v10 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.supported_tokens, &v10), 2);
        assert!(v6 == v10, 2);
        let v11 = 0x2::clock::timestamp_ms(arg4);
        0x2::coin::destroy_zero<T1>(0x2::coin::from_balance<T1>(v8, arg5));
        let v12 = 0x2::coin::value<T0>(&arg1);
        let v13 = if (v12 >= v5) {
            v5
        } else {
            v12
        };
        let v14 = if (v12 > v5) {
            v12 - v5
        } else {
            0
        };
        let (v15, v16) = if (v11 >= v3 + v4) {
            (v13, 0)
        } else {
            let v17 = safe_mul_div(v5, 200, 10000);
            let v18 = if (v17 > v12) {
                v12
            } else {
                v17
            };
            let v19 = if (v13 > v18) {
                v13 - v18
            } else {
                0
            };
            (v19, v18)
        };
        let (v20, v21) = if (v14 > 0) {
            let v22 = safe_mul_div(v14, 3000, 10000);
            (v22, v14 - v22)
        } else {
            (0, 0)
        };
        let v23 = v15 + v21;
        let v24 = v16 + v20;
        assert!(v23 + v24 <= 0x2::coin::value<T0>(&arg1), 5);
        if (v23 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v23, arg5), v0);
        };
        if (v24 > 0) {
            let v25 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v24, arg5));
            if (v16 > 0) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.fees, v10), 0x2::balance::split<T0>(&mut v25, v16));
            };
            if (v20 > 0) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.yield_fees, v10), v25);
            } else {
                0x2::balance::destroy_zero<T0>(v25);
            };
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg3.yield_locks, &v0)) {
            let v26 = 0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg3.yield_locks, &v0);
            remove_lock_id(v26, 0x2::object::uid_to_inner(&v9));
            if (0x1::vector::is_empty<0x2::object::ID>(v26)) {
                let (_, _) = 0x2::vec_map::remove<address, vector<0x2::object::ID>>(&mut arg3.yield_locks, &v0);
            };
        };
        let v29 = YieldLockWithdrawn{
            owner               : v0,
            principal_withdrawn : v15,
            yield_earned        : v14,
            platform_yield_fee  : v20,
            user_yield_amount   : v21,
            withdrawn_time      : v11,
            coin_type           : v10,
        };
        0x2::event::emit<YieldLockWithdrawn>(v29);
        0x2::object::delete(v9);
    }

    public entry fun configure_scallop(arg0: &AdminCap, arg1: &mut Platform, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        arg1.scallop_market_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.scallop_version_id = 0x1::option::some<0x2::object::ID>(arg3);
        let v1 = ScallopConfigured{
            admin      : v0,
            market_id  : arg2,
            version_id : arg3,
        };
        0x2::event::emit<ScallopConfigured>(v1);
    }

    public entry fun configure_token_fee<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        assert!(arg2 <= 10000, 5);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let v2 = TokenFeeConfig{
            deposit_fee_bps : arg2,
            min_deposit_fee : arg3,
            max_deposit_fee : arg4,
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg1.token_fee_configs, &v1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, TokenFeeConfig>(&mut arg1.token_fee_configs, &v1) = v2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, TokenFeeConfig>(&mut arg1.token_fee_configs, v1, v2);
        };
        let v3 = TokenFeeConfigUpdated{
            token_type      : v1,
            admin           : v0,
            deposit_fee_bps : arg2,
            min_deposit_fee : arg3,
            max_deposit_fee : arg4,
        };
        0x2::event::emit<TokenFeeConfigUpdated>(v3);
    }

    public entry fun create_lock<T0>(arg0: &mut Platform, arg1: &mut UserRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_deposits, 6);
        assert!(arg3 > 0, 0);
        assert!(arg4 == 0, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0), 9);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 1, 5);
        let v2 = calculate_deposit_fee(v1, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0));
        assert!(v1 > v2, 8);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.deposit_fees, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v2, arg6)));
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 5);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = 0x2::tx_context::sender(arg6);
        let v6 = Lock<T0>{
            id          : 0x2::object::new(arg6),
            balance     : 0x2::coin::into_balance<T0>(arg2),
            owner       : v5,
            start_time  : v4,
            duration_ms : arg3,
            strategy    : arg4,
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.locks, &v5)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.locks, &v5), 0x2::object::id<Lock<T0>>(&v6));
        } else {
            let v7 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::id<Lock<T0>>(&v6));
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg1.locks, v5, v7);
        };
        0x2::transfer::public_transfer<Lock<T0>>(v6, v5);
        let v8 = LockCreated<T0>{
            owner            : v5,
            amount           : v3,
            deposit_fee_paid : v2,
            start_time       : v4,
            duration_ms      : arg3,
            strategy         : arg4,
        };
        0x2::event::emit<LockCreated<T0>>(v8);
    }

    public entry fun create_yield_lock<T0, T1>(arg0: &mut Platform, arg1: &mut UserRegistry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_deposits, 6);
        assert!(arg3 > 0, 0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.scallop_market_id), 4);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.scallop_version_id), 4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0), 9);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, v1), 2);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 1, 5);
        let v3 = calculate_deposit_fee(v2, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0));
        assert!(v2 > v3, 8);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.deposit_fees, v1), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg5)));
        let v4 = 0x2::coin::value<T1>(&arg2);
        assert!(v4 > 0, 5);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = 0x2::tx_context::sender(arg5);
        let v7 = YieldLock<T1>{
            id               : 0x2::object::new(arg5),
            owner            : v6,
            start_time       : v5,
            duration_ms      : arg3,
            principal_amount : v4,
            coin_type        : v0,
            strategy         : 1,
            market_balance   : 0x2::coin::into_balance<T1>(arg2),
        };
        let v8 = 0x2::object::id<YieldLock<T1>>(&v7);
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg1.yield_locks, &v6)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg1.yield_locks, &v6), v8);
        } else {
            let v9 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v8);
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg1.yield_locks, v6, v9);
        };
        0x2::transfer::public_transfer<YieldLock<T1>>(v7, v6);
        let v10 = YieldLockCreated{
            owner            : v6,
            principal_amount : v4,
            deposit_fee_paid : v3,
            coin_type        : v0,
            start_time       : v5,
            duration_ms      : arg3,
            market_coin_id   : v8,
        };
        0x2::event::emit<YieldLockCreated>(v10);
    }

    public fun get_market_coin_deposit_fee_balance<T0>(arg0: &Platform) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.deposit_fees, v0))
        } else {
            0
        }
    }

    public fun get_pause_status(arg0: &Platform) : (bool, bool) {
        (arg0.paused_deposits, arg0.paused_withdrawals)
    }

    public fun get_scallop_config(arg0: &Platform) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        (arg0.scallop_market_id, arg0.scallop_version_id)
    }

    public fun get_supported_tokens(arg0: &Platform) : vector<0x1::type_name::TypeName> {
        arg0.supported_tokens
    }

    public fun get_token_fee_config<T0>(arg0: &Platform) : 0x1::option::Option<TokenFeeConfig> {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0)) {
            0x1::option::some<TokenFeeConfig>(*0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0))
        } else {
            0x1::option::none<TokenFeeConfig>()
        }
    }

    public fun get_user_locks(arg0: &UserRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.locks, &arg1)) {
            *0x2::vec_map::get<address, vector<0x2::object::ID>>(&arg0.locks, &arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_yield_locks(arg0: &UserRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.yield_locks, &arg1)) {
            *0x2::vec_map::get<address, vector<0x2::object::ID>>(&arg0.yield_locks, &arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun has_market_coin_deposit_fees<T0>(arg0: &Platform) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap{
            id          : 0x2::object::new(arg0),
            platform_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = UserRegistry{
            id          : 0x2::object::new(arg0),
            locks       : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
            yield_locks : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
        };
        0x2::transfer::share_object<UserRegistry>(v2);
        let v3 = Platform{
            id                 : v0,
            admin              : 0x2::tx_context::sender(arg0),
            admin_cap_id       : 0x2::object::id<AdminCap>(&v1),
            fees               : 0x2::bag::new(arg0),
            yield_fees         : 0x2::bag::new(arg0),
            deposit_fees       : 0x2::bag::new(arg0),
            token_fee_configs  : 0x2::vec_map::empty<0x1::type_name::TypeName, TokenFeeConfig>(),
            supported_tokens   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            scallop_market_id  : 0x1::option::none<0x2::object::ID>(),
            scallop_version_id : 0x1::option::none<0x2::object::ID>(),
            paused_deposits    : false,
            paused_withdrawals : false,
        };
        0x2::transfer::share_object<Platform>(v3);
    }

    public fun is_scallop_configured(arg0: &Platform) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.scallop_market_id) && 0x1::option::is_some<0x2::object::ID>(&arg0.scallop_version_id)
    }

    public fun is_token_supported<T0>(arg0: &Platform) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0)
    }

    fun remove_lock_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun set_pause_status(arg0: &AdminCap, arg1: &mut Platform, arg2: bool, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        arg1.paused_deposits = arg2;
        arg1.paused_withdrawals = arg3;
        let v1 = PauseStatusChanged{
            admin              : v0,
            deposits_paused    : arg2,
            withdrawals_paused : arg3,
        };
        0x2::event::emit<PauseStatusChanged>(v1);
    }

    public fun unlock_yield_lock_market_coin<T0>(arg0: &mut YieldLock<T0>, arg1: &Platform, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg1.paused_withdrawals, 6);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::coin::take<T0>(&mut arg0.market_balance, 0x2::balance::value<T0>(&arg0.market_balance), arg2)
    }

    public entry fun withdraw<T0>(arg0: Lock<T0>, arg1: &mut Platform, arg2: &mut UserRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused_withdrawals, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let Lock {
            id          : v2,
            balance     : v3,
            owner       : _,
            start_time  : v5,
            duration_ms : v6,
            strategy    : v7,
        } = arg0;
        let v8 = v3;
        let v9 = v2;
        assert!(v7 == 0, 3);
        let v10 = 0x2::balance::value<T0>(&v8);
        let v11 = 0x2::clock::timestamp_ms(arg3);
        let (v12, v13) = if (v11 >= v5 + v6) {
            (v10, 0)
        } else {
            let v14 = safe_mul_div(v10, 200, 10000);
            (v10 - v14, v14)
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8, v12, arg4), v0);
        };
        if (v13 > 0) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v1), 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v8, v13, arg4)));
        };
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg2.locks, &v0)) {
            let v15 = 0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg2.locks, &v0);
            remove_lock_id(v15, 0x2::object::uid_to_inner(&v9));
            if (0x1::vector::is_empty<0x2::object::ID>(v15)) {
                let (_, _) = 0x2::vec_map::remove<address, vector<0x2::object::ID>>(&mut arg2.locks, &v0);
            };
        };
        let v18 = LockWithdrawn<T0>{
            owner            : v0,
            amount_withdrawn : v12,
            withdrawn_time   : v11,
            strategy         : v7,
        };
        0x2::event::emit<LockWithdrawn<T0>>(v18);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v9);
    }

    // decompiled from Move bytecode v6
}

