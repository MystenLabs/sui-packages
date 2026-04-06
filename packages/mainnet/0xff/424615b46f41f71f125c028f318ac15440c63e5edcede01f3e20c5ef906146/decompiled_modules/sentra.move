module 0xff424615b46f41f71f125c028f318ac15440c63e5edcede01f3e20c5ef906146::sentra {
    struct Lock<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        start_time: u64,
        duration_ms: u64,
    }

    struct YieldLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        start_time: u64,
        duration_ms: u64,
        principal_base_amount: u64,
        principal_s_coin_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        expected_s_coin_type: 0x1::type_name::TypeName,
        s_coin_balance: 0x2::balance::Balance<T0>,
        description: 0x1::string::String,
        s_coin_unlocked: bool,
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
        paused_deposits: bool,
        paused_withdrawals: bool,
        tvl_by_token: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        yield_tvl_by_token: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        global_lock_list: 0x2::table::Table<0x2::object::ID, bool>,
        global_yield_lock_list: 0x2::table::Table<0x2::object::ID, bool>,
        locks_by_token_count: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        yield_locks_by_token_count: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct UserRegistry has store, key {
        id: 0x2::object::UID,
        locks: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>,
        yield_locks: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>,
        lock_user_count: u64,
        yield_lock_user_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        platform_id: 0x2::object::ID,
    }

    struct PendingAdminTransfer has key {
        id: 0x2::object::UID,
        cap: AdminCap,
        current_admin: address,
        new_admin: address,
    }

    struct LockCreated<phantom T0> has copy, drop, store {
        owner: address,
        amount: u64,
        deposit_fee_paid: u64,
        start_time: u64,
        duration_ms: u64,
    }

    struct LockExtended<phantom T0> has copy, drop, store {
        owner: address,
        added_amount: u64,
        deposit_fee_paid: u64,
        new_total: u64,
    }

    struct LockWithdrawn<phantom T0> has copy, drop, store {
        owner: address,
        amount_withdrawn: u64,
        withdrawn_time: u64,
    }

    struct YieldLockCreated has copy, drop, store {
        owner: address,
        principal_s_coin_amount: u64,
        principal_base_amount: u64,
        deposit_fee_paid: u64,
        coin_type: 0x1::type_name::TypeName,
        s_coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        duration_ms: u64,
        yield_lock_id: 0x2::object::ID,
        description: 0x1::string::String,
    }

    struct YieldLockExtended has copy, drop, store {
        owner: address,
        added_s_coin_amount: u64,
        deposit_fee_paid: u64,
        new_s_coin_balance: u64,
        new_principal_base_amount: u64,
        new_principal_s_coin_amount: u64,
        coin_type: 0x1::type_name::TypeName,
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

    struct AdminTransferred has copy, drop, store {
        old_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    public entry fun accept_admin_transfer(arg0: PendingAdminTransfer, arg1: &mut Platform, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.new_admin, 1);
        let PendingAdminTransfer {
            id            : v0,
            cap           : v1,
            current_admin : v2,
            new_admin     : v3,
        } = arg0;
        let v4 = v1;
        assert!(0x2::object::id<AdminCap>(&v4) == arg1.admin_cap_id, 7);
        arg1.admin = v3;
        arg1.admin_cap_id = 0x2::object::id<AdminCap>(&v4);
        0x2::transfer::transfer<AdminCap>(v4, v3);
        0x2::object::delete(v0);
        let v5 = AdminTransferred{
            old_admin : v2,
            new_admin : v3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminTransferred>(v5);
    }

    public entry fun add_s_coin_support<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.deposit_fees, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.deposit_fees, v0, 0x2::balance::zero<T0>());
        };
    }

    public entry fun add_to_lock<T0>(arg0: &mut Lock<T0>, arg1: &mut Platform, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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
        update_tvl<T0>(arg1, v5, true);
        let v6 = LockExtended<T0>{
            owner            : v0,
            added_amount     : v5,
            deposit_fee_paid : v3,
            new_total        : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<LockExtended<T0>>(v6);
    }

    public entry fun add_to_yield_lock<T0, T1>(arg0: &mut YieldLock<T1>, arg1: &mut Platform, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg1.token_fee_configs, &v1), 9);
        assert!(arg0.coin_type == v1, 2);
        assert!(arg0.expected_s_coin_type == v2, 12);
        assert!(arg3 > 0, 5);
        let v3 = 0x2::coin::value<T1>(&arg2);
        assert!(v3 > 1, 5);
        let v4 = calculate_deposit_fee(v3, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg1.token_fee_configs, &v1));
        assert!(v3 > v4, 8);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.deposit_fees, v2), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v4, arg4)));
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        let v6 = 0x2::balance::value<T1>(&v5);
        0x2::balance::join<T1>(&mut arg0.s_coin_balance, v5);
        arg0.principal_base_amount = arg0.principal_base_amount + arg3;
        arg0.principal_s_coin_amount = arg0.principal_s_coin_amount + v6;
        update_yield_tvl<T0>(arg1, v6, true);
        let v7 = YieldLockExtended{
            owner                       : v0,
            added_s_coin_amount         : v6,
            deposit_fee_paid            : v4,
            new_s_coin_balance          : 0x2::balance::value<T1>(&arg0.s_coin_balance),
            new_principal_base_amount   : arg0.principal_base_amount,
            new_principal_s_coin_amount : arg0.principal_s_coin_amount,
            coin_type                   : v1,
        };
        0x2::event::emit<YieldLockExtended>(v7);
    }

    public entry fun add_token_support<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.tvl_by_token, v1, 0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.yield_tvl_by_token, v1, 0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.locks_by_token_count, v1, 0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.yield_locks_by_token_count, v1, 0);
            let v3 = TokenAdded{
                token_type : v1,
                admin      : v0,
            };
            0x2::event::emit<TokenAdded>(v3);
        };
    }

    fun calculate_deposit_fee(arg0: u64, arg1: &TokenFeeConfig) : u64 {
        let v0 = safe_mul_div_ceil(arg0, arg1.deposit_fee_bps, 10000);
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
        assert!(v2 < arg0, 8);
        v2
    }

    public fun calculate_fee_for_amount<T0>(arg0: &Platform, arg1: u64) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0)) {
            calculate_deposit_fee(arg1, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0))
        } else {
            0
        }
    }

    public entry fun cancel_admin_transfer(arg0: PendingAdminTransfer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.current_admin, 1);
        let PendingAdminTransfer {
            id            : v0,
            cap           : v1,
            current_admin : v2,
            new_admin     : _,
        } = arg0;
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::object::delete(v0);
    }

    entry fun collect_deposit_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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

    entry fun collect_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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

    entry fun collect_yield_fees<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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
        assert!(arg0.s_coin_unlocked, 11);
        let YieldLock {
            id                      : v1,
            owner                   : _,
            start_time              : v3,
            duration_ms             : v4,
            principal_base_amount   : v5,
            principal_s_coin_amount : v6,
            coin_type               : v7,
            expected_s_coin_type    : _,
            s_coin_balance          : v9,
            description             : _,
            s_coin_unlocked         : _,
        } = arg0;
        let v12 = v1;
        let v13 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.supported_tokens, &v13), 2);
        assert!(v7 == v13, 2);
        let v14 = 0x2::object::uid_to_inner(&v12);
        let v15 = 0x2::clock::timestamp_ms(arg4);
        0x2::coin::destroy_zero<T1>(0x2::coin::from_balance<T1>(v9, arg5));
        let v16 = 0x2::coin::value<T0>(&arg1);
        assert!(v16 >= v5, 5);
        let v17 = v16 - v5;
        let (v18, v19) = if (v15 >= v3 + v4) {
            (v5, 0)
        } else {
            let v20 = safe_mul_div(v5, 200, 10000);
            let v21 = if (v5 > v20) {
                v5 - v20
            } else {
                0
            };
            (v21, v20)
        };
        let (v22, v23) = if (v17 > 0) {
            let v24 = safe_mul_div(v17, 3000, 10000);
            (v24, v17 - v24)
        } else {
            (0, 0)
        };
        let v25 = v18 + v23;
        let v26 = v19 + v22;
        assert!(v25 + v26 <= 0x2::coin::value<T0>(&arg1), 5);
        if (v25 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v25, arg5), v0);
        };
        if (v26 > 0) {
            let v27 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v26, arg5));
            if (v19 > 0) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.fees, v13), 0x2::balance::split<T0>(&mut v27, v19));
            };
            if (v22 > 0) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.yield_fees, v13), v27);
            } else {
                0x2::balance::destroy_zero<T0>(v27);
            };
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        registry_remove_yield_lock(arg3, v0, v14);
        update_yield_tvl<T0>(arg2, v6, false);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg2.global_yield_lock_list, v14)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.global_yield_lock_list, v14);
        };
        decrement_token_yield_lock_count(arg2, v13);
        let v28 = YieldLockWithdrawn{
            owner               : v0,
            principal_withdrawn : v18,
            yield_earned        : v17,
            platform_yield_fee  : v22,
            user_yield_amount   : v23,
            withdrawn_time      : v15,
            coin_type           : v13,
        };
        0x2::event::emit<YieldLockWithdrawn>(v28);
        0x2::object::delete(v12);
    }

    public entry fun configure_token_fee<T0>(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 7);
        assert!(arg2 <= 10000, 5);
        let v1 = 0x1::type_name::with_original_ids<T0>();
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

    public entry fun create_lock<T0>(arg0: &mut Platform, arg1: &mut UserRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_deposits, 6);
        assert!(arg3 > 0, 0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0), 9);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 1, 5);
        let v2 = calculate_deposit_fee(v1, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0));
        assert!(v1 > v2, 8);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.deposit_fees, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v2, arg5)));
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 > 0, 5);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = 0x2::tx_context::sender(arg5);
        let v6 = Lock<T0>{
            id          : 0x2::object::new(arg5),
            balance     : 0x2::coin::into_balance<T0>(arg2),
            owner       : v5,
            start_time  : v4,
            duration_ms : arg3,
        };
        let v7 = 0x2::object::id<Lock<T0>>(&v6);
        registry_add_lock(arg1, v5, v7, arg5);
        update_tvl<T0>(arg0, v3, true);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.global_lock_list, v7, true);
        increment_token_lock_count(arg0, v0);
        0x2::transfer::transfer<Lock<T0>>(v6, v5);
        let v8 = LockCreated<T0>{
            owner            : v5,
            amount           : v3,
            deposit_fee_paid : v2,
            start_time       : v4,
            duration_ms      : arg3,
        };
        0x2::event::emit<LockCreated<T0>>(v8);
    }

    public entry fun create_yield_lock<T0, T1>(arg0: &mut Platform, arg1: &mut UserRegistry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused_deposits, 6);
        assert!(arg3 > 0, 0);
        assert!(arg4 > 0, 5);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0), 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0), 9);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, v1), 2);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 1, 5);
        let v3 = calculate_deposit_fee(v2, 0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0));
        assert!(v2 > v3, 8);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.deposit_fees, v1), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg7)));
        let v4 = 0x2::coin::value<T1>(&arg2);
        assert!(v4 > 0, 5);
        let v5 = 0x2::clock::timestamp_ms(arg6);
        let v6 = 0x2::tx_context::sender(arg7);
        let v7 = 0x1::string::utf8(arg5);
        let v8 = YieldLock<T1>{
            id                      : 0x2::object::new(arg7),
            owner                   : v6,
            start_time              : v5,
            duration_ms             : arg3,
            principal_base_amount   : arg4,
            principal_s_coin_amount : v4,
            coin_type               : v0,
            expected_s_coin_type    : v1,
            s_coin_balance          : 0x2::coin::into_balance<T1>(arg2),
            description             : v7,
            s_coin_unlocked         : false,
        };
        let v9 = 0x2::object::id<YieldLock<T1>>(&v8);
        registry_add_yield_lock(arg1, v6, v9, arg7);
        update_yield_tvl<T0>(arg0, v4, true);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.global_yield_lock_list, v9, true);
        increment_token_yield_lock_count(arg0, v0);
        0x2::transfer::transfer<YieldLock<T1>>(v8, v6);
        let v10 = YieldLockCreated{
            owner                   : v6,
            principal_s_coin_amount : v4,
            principal_base_amount   : arg4,
            deposit_fee_paid        : v3,
            coin_type               : v0,
            s_coin_type             : v1,
            start_time              : v5,
            duration_ms             : arg3,
            yield_lock_id           : v9,
            description             : v7,
        };
        0x2::event::emit<YieldLockCreated>(v10);
    }

    fun decrement_token_lock_count(arg0: &mut Platform, arg1: 0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.locks_by_token_count, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.locks_by_token_count, &arg1);
            if (*v0 > 0) {
                *v0 = *v0 - 1;
            };
        };
    }

    fun decrement_token_yield_lock_count(arg0: &mut Platform, arg1: 0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.yield_locks_by_token_count, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.yield_locks_by_token_count, &arg1);
            if (*v0 > 0) {
                *v0 = *v0 - 1;
            };
        };
    }

    public fun get_admin(arg0: &Platform) : address {
        arg0.admin
    }

    public fun get_lock_count_for_token(arg0: &Platform, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.locks_by_token_count, &arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.locks_by_token_count, &arg1)
        } else {
            0
        }
    }

    public fun get_market_coin_deposit_fee_balance<T0>(arg0: &Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.deposit_fees, v0))
        } else {
            0
        }
    }

    public fun get_pause_status(arg0: &Platform) : (bool, bool) {
        (arg0.paused_deposits, arg0.paused_withdrawals)
    }

    public fun get_supported_tokens(arg0: &Platform) : vector<0x1::type_name::TypeName> {
        arg0.supported_tokens
    }

    public fun get_token_fee_config<T0>(arg0: &Platform) : 0x1::option::Option<TokenFeeConfig> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0)) {
            0x1::option::some<TokenFeeConfig>(*0x2::vec_map::get<0x1::type_name::TypeName, TokenFeeConfig>(&arg0.token_fee_configs, &v0))
        } else {
            0x1::option::none<TokenFeeConfig>()
        }
    }

    public fun get_total_lock_count(arg0: &Platform) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.global_lock_list)
    }

    public fun get_total_users_with_locks(arg0: &UserRegistry) : u64 {
        arg0.lock_user_count
    }

    public fun get_total_users_with_yield_locks(arg0: &UserRegistry) : u64 {
        arg0.yield_lock_user_count
    }

    public fun get_total_yield_lock_count(arg0: &Platform) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.global_yield_lock_list)
    }

    public fun get_yield_lock_count_for_token(arg0: &Platform, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.yield_locks_by_token_count, &arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.yield_locks_by_token_count, &arg1)
        } else {
            0
        }
    }

    public fun has_market_coin_deposit_fees<T0>(arg0: &Platform) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposit_fees, 0x1::type_name::with_original_ids<T0>())
    }

    fun increment_token_lock_count(arg0: &mut Platform, arg1: 0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.locks_by_token_count, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.locks_by_token_count, &arg1);
            *v0 = *v0 + 1;
        };
    }

    fun increment_token_yield_lock_count(arg0: &mut Platform, arg1: 0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.yield_locks_by_token_count, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.yield_locks_by_token_count, &arg1);
            *v0 = *v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap{
            id          : 0x2::object::new(arg0),
            platform_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = UserRegistry{
            id                    : 0x2::object::new(arg0),
            locks                 : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0),
            yield_locks           : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, bool>>(arg0),
            lock_user_count       : 0,
            yield_lock_user_count : 0,
        };
        0x2::transfer::share_object<UserRegistry>(v2);
        let v3 = Platform{
            id                         : v0,
            admin                      : 0x2::tx_context::sender(arg0),
            admin_cap_id               : 0x2::object::id<AdminCap>(&v1),
            fees                       : 0x2::bag::new(arg0),
            yield_fees                 : 0x2::bag::new(arg0),
            deposit_fees               : 0x2::bag::new(arg0),
            token_fee_configs          : 0x2::vec_map::empty<0x1::type_name::TypeName, TokenFeeConfig>(),
            supported_tokens           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            paused_deposits            : false,
            paused_withdrawals         : false,
            tvl_by_token               : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            yield_tvl_by_token         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            global_lock_list           : 0x2::table::new<0x2::object::ID, bool>(arg0),
            global_yield_lock_list     : 0x2::table::new<0x2::object::ID, bool>(arg0),
            locks_by_token_count       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            yield_locks_by_token_count : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<Platform>(v3);
    }

    public fun is_token_supported<T0>(arg0: &Platform) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0)
    }

    public fun lock_balance_value<T0>(arg0: &Lock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun lock_duration_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.duration_ms
    }

    public fun lock_exists(arg0: &Platform, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.global_lock_list, arg1)
    }

    public fun lock_owner<T0>(arg0: &Lock<T0>) : address {
        arg0.owner
    }

    public fun lock_start_time<T0>(arg0: &Lock<T0>) : u64 {
        arg0.start_time
    }

    public fun platform_admin_cap_id(arg0: &Platform) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun platform_deposit_fees(arg0: &Platform) : &0x2::bag::Bag {
        &arg0.deposit_fees
    }

    public fun platform_fees(arg0: &Platform) : &0x2::bag::Bag {
        &arg0.fees
    }

    public fun platform_tvl_by_token(arg0: &Platform) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.tvl_by_token
    }

    public fun platform_yield_fees(arg0: &Platform) : &0x2::bag::Bag {
        &arg0.yield_fees
    }

    public fun platform_yield_tvl_by_token(arg0: &Platform) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.yield_tvl_by_token
    }

    fun registry_add_lock(arg0: &mut UserRegistry, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.locks, arg1, 0x2::table::new<0x2::object::ID, bool>(arg3));
            arg0.lock_user_count = arg0.lock_user_count + 1;
        };
        0x2::table::add<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.locks, arg1), arg2, true);
    }

    fun registry_add_yield_lock(arg0: &mut UserRegistry, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.yield_locks, arg1, 0x2::table::new<0x2::object::ID, bool>(arg3));
            arg0.yield_lock_user_count = arg0.yield_lock_user_count + 1;
        };
        0x2::table::add<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.yield_locks, arg1), arg2, true);
    }

    fun registry_remove_lock(arg0: &mut UserRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.locks, arg1);
            if (0x2::table::contains<0x2::object::ID, bool>(v0, arg2)) {
                0x2::table::remove<0x2::object::ID, bool>(v0, arg2);
            };
        };
    }

    fun registry_remove_yield_lock(arg0: &mut UserRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.yield_locks, arg1);
            if (0x2::table::contains<0x2::object::ID, bool>(v0, arg2)) {
                0x2::table::remove<0x2::object::ID, bool>(v0, arg2);
            };
        };
    }

    public entry fun request_admin_transfer(arg0: AdminCap, arg1: &mut Platform, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 1);
        assert!(0x2::object::id<AdminCap>(&arg0) == arg1.admin_cap_id, 7);
        let v1 = PendingAdminTransfer{
            id            : 0x2::object::new(arg3),
            cap           : arg0,
            current_admin : v0,
            new_admin     : arg2,
        };
        0x2::transfer::share_object<PendingAdminTransfer>(v1);
    }

    fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun safe_mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
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

    public entry fun unlock_yield_lock_s_coin<T0>(arg0: &mut YieldLock<T0>, arg1: &Platform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused_withdrawals, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        assert!(!arg0.s_coin_unlocked, 10);
        let v1 = 0x2::balance::value<T0>(&arg0.s_coin_balance);
        assert!(v1 > 0, 5);
        arg0.s_coin_unlocked = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.s_coin_balance, v1, arg2), v0);
    }

    fun update_tvl<T0>(arg0: &mut Platform, arg1: u64, arg2: bool) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.tvl_by_token, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.tvl_by_token, &v0);
            if (arg2) {
                *v1 = *v1 + arg1;
            } else {
                *v1 = *v1 - arg1;
            };
        };
    }

    fun update_yield_tvl<T0>(arg0: &mut Platform, arg1: u64, arg2: bool) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.yield_tvl_by_token, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.yield_tvl_by_token, &v0);
            if (arg2) {
                *v1 = *v1 + arg1;
            } else {
                *v1 = *v1 - arg1;
            };
        };
    }

    public fun user_has_locks(arg0: &UserRegistry, arg1: address) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1)) {
            return false
        };
        0x2::table::length<0x2::object::ID, bool>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1)) > 0
    }

    public fun user_has_yield_locks(arg0: &UserRegistry, arg1: address) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1)) {
            return false
        };
        0x2::table::length<0x2::object::ID, bool>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1)) > 0
    }

    public fun user_owns_lock(arg0: &UserRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1)) {
            return false
        };
        0x2::table::contains<0x2::object::ID, bool>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.locks, arg1), arg2)
    }

    public fun user_owns_yield_lock(arg0: &UserRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1)) {
            return false
        };
        0x2::table::contains<0x2::object::ID, bool>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.yield_locks, arg1), arg2)
    }

    public entry fun withdraw<T0>(arg0: Lock<T0>, arg1: &mut Platform, arg2: &mut UserRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused_withdrawals, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.supported_tokens, &v1), 2);
        let Lock {
            id          : v2,
            balance     : v3,
            owner       : _,
            start_time  : v5,
            duration_ms : v6,
        } = arg0;
        let v7 = v3;
        let v8 = v2;
        let v9 = 0x2::object::uid_to_inner(&v8);
        let v10 = 0x2::balance::value<T0>(&v7);
        let v11 = 0x2::clock::timestamp_ms(arg3);
        let (v12, v13) = if (v11 >= v5 + v6) {
            (v10, 0)
        } else {
            let v14 = safe_mul_div(v10, 200, 10000);
            (v10 - v14, v14)
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7, v12, arg4), v0);
        };
        if (v13 > 0) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v1), 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v7, v13, arg4)));
        };
        registry_remove_lock(arg2, v0, v9);
        update_tvl<T0>(arg1, v12, false);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.global_lock_list, v9)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.global_lock_list, v9);
        };
        decrement_token_lock_count(arg1, v1);
        let v15 = LockWithdrawn<T0>{
            owner            : v0,
            amount_withdrawn : v12,
            withdrawn_time   : v11,
        };
        0x2::event::emit<LockWithdrawn<T0>>(v15);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::object::delete(v8);
    }

    public fun yield_lock_coin_type<T0>(arg0: &YieldLock<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun yield_lock_duration_ms<T0>(arg0: &YieldLock<T0>) : u64 {
        arg0.duration_ms
    }

    public fun yield_lock_exists(arg0: &Platform, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.global_yield_lock_list, arg1)
    }

    public fun yield_lock_owner<T0>(arg0: &YieldLock<T0>) : address {
        arg0.owner
    }

    public fun yield_lock_principal_amount<T0>(arg0: &YieldLock<T0>) : u64 {
        arg0.principal_base_amount
    }

    public fun yield_lock_s_coin_balance_value<T0>(arg0: &YieldLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.s_coin_balance)
    }

    public fun yield_lock_s_coin_unlocked<T0>(arg0: &YieldLock<T0>) : bool {
        arg0.s_coin_unlocked
    }

    public fun yield_lock_start_time<T0>(arg0: &YieldLock<T0>) : u64 {
        arg0.start_time
    }

    public fun yield_lock_strategy<T0>(arg0: &YieldLock<T0>) : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

