module 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::analytics {
    struct LockInfo has copy, drop {
        owner: address,
        amount: u64,
        start_time: u64,
        duration_ms: u64,
        unlock_time: u64,
    }

    struct YieldLockInfo has copy, drop {
        owner: address,
        principal_base_amount: u64,
        s_coin_balance: u64,
        start_time: u64,
        duration_ms: u64,
        coin_type: 0x1::type_name::TypeName,
        unlock_time: u64,
        s_coin_unlocked: bool,
    }

    struct PlatformStats has copy, drop {
        supported_tokens: vector<0x1::type_name::TypeName>,
        paused_deposits: bool,
        paused_withdrawals: bool,
        total_tokens_supported: u64,
    }

    struct PlatformFeeConfig has copy, drop {
        penalty_bps: u64,
        yield_fee_bps: u64,
        default_deposit_fee_bps: u64,
    }

    struct TokenFeeStats has copy, drop {
        penalty_fees: u64,
        yield_fees: u64,
        deposit_fees: u64,
        total_fees: u64,
    }

    struct UserLockSummary has copy, drop {
        total_locks: u64,
        total_yield_locks: u64,
        has_locks: bool,
        has_yield_locks: bool,
    }

    struct TVLStats has copy, drop {
        token_type: 0x1::type_name::TypeName,
        total_locked: u64,
        total_yield_locked: u64,
        combined_tvl: u64,
    }

    struct GlobalLockStats has copy, drop {
        total_locks: u64,
        total_yield_locks: u64,
        total_users_with_locks: u64,
        total_users_with_yield_locks: u64,
    }

    public fun get_accumulated_deposit_fees<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_deposit_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_accumulated_penalty_fees<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_accumulated_yield_fees<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_yield_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_all_tvl(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : vector<TVLStats> {
        let v0 = 0x1::vector::empty<TVLStats>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_supported_tokens(arg0);
        let v2 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_tvl_by_token(arg0);
        let v3 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_yield_tvl_by_token(arg0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v5 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v4);
            let v6 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v2, v5)) {
                *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v2, v5)
            } else {
                0
            };
            let v7 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v3, v5)) {
                *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v3, v5)
            } else {
                0
            };
            let v8 = TVLStats{
                token_type         : *v5,
                total_locked       : v6,
                total_yield_locked : v7,
                combined_tvl       : v6 + v7,
            };
            0x1::vector::push_back<TVLStats>(&mut v0, v8);
            v4 = v4 + 1;
        };
        v0
    }

    public fun get_fee_totals<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : TokenFeeStats {
        let v0 = get_accumulated_penalty_fees<T0>(arg0);
        let v1 = get_accumulated_yield_fees<T0>(arg0);
        let v2 = get_accumulated_deposit_fees<T0>(arg0);
        TokenFeeStats{
            penalty_fees : v0,
            yield_fees   : v1,
            deposit_fees : v2,
            total_fees   : (((v0 as u128) + (v1 as u128) + (v2 as u128)) as u64),
        }
    }

    public fun get_global_lock_stats(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform, arg1: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry) : GlobalLockStats {
        GlobalLockStats{
            total_locks                  : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_lock_count(arg0),
            total_yield_locks            : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_yield_lock_count(arg0),
            total_users_with_locks       : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_users_with_locks(arg1),
            total_users_with_yield_locks : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_users_with_yield_locks(arg1),
        }
    }

    public fun get_lock_count_by_token<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_lock_count_for_token(arg0, 0x1::type_name::with_original_ids<T0>())
    }

    public fun get_lock_details<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Lock<T0>) : LockInfo {
        let v0 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::lock_start_time<T0>(arg0);
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::lock_duration_ms<T0>(arg0);
        LockInfo{
            owner       : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::lock_owner<T0>(arg0),
            amount      : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::lock_balance_value<T0>(arg0),
            start_time  : v0,
            duration_ms : v1,
            unlock_time : v0 + v1,
        }
    }

    public fun get_multiple_lock_details<T0>(arg0: &vector<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Lock<T0>>) : vector<LockInfo> {
        let v0 = 0x1::vector::empty<LockInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Lock<T0>>(arg0)) {
            0x1::vector::push_back<LockInfo>(&mut v0, get_lock_details<T0>(0x1::vector::borrow<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Lock<T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_multiple_yield_lock_details<T0>(arg0: &vector<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::YieldLock<T0>>) : vector<YieldLockInfo> {
        let v0 = 0x1::vector::empty<YieldLockInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::YieldLock<T0>>(arg0)) {
            0x1::vector::push_back<YieldLockInfo>(&mut v0, get_yield_lock_details<T0>(0x1::vector::borrow<0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::YieldLock<T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_platform_fee_config(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : PlatformFeeConfig {
        PlatformFeeConfig{
            penalty_bps             : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_penalty_bps(arg0),
            yield_fee_bps           : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_yield_fee_bps(arg0),
            default_deposit_fee_bps : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_default_deposit_fee_bps(arg0),
        }
    }

    public fun get_platform_stats(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : PlatformStats {
        let v0 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_supported_tokens(arg0);
        let (v1, v2) = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_pause_status(arg0);
        PlatformStats{
            supported_tokens       : v0,
            paused_deposits        : v1,
            paused_withdrawals     : v2,
            total_tokens_supported : 0x1::vector::length<0x1::type_name::TypeName>(&v0),
        }
    }

    public fun get_time_until_unlock(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun get_total_lock_count(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_lock_count(arg0)
    }

    public fun get_total_users_with_locks(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_users_with_locks(arg0)
    }

    public fun get_total_users_with_yield_locks(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_users_with_yield_locks(arg0)
    }

    public fun get_total_yield_lock_count(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_total_yield_lock_count(arg0)
    }

    public fun get_total_yield_locked<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_yield_tvl_by_token(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v1, &v0)
        } else {
            0
        }
    }

    public fun get_tvl<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::platform_tvl_by_token(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v1, &v0)
        } else {
            0
        }
    }

    public fun get_tvl_stats<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : TVLStats {
        let v0 = get_tvl<T0>(arg0);
        let v1 = get_total_yield_locked<T0>(arg0);
        TVLStats{
            token_type         : 0x1::type_name::with_original_ids<T0>(),
            total_locked       : v0,
            total_yield_locked : v1,
            combined_tvl       : v0 + v1,
        }
    }

    public fun get_user_lock_count(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : u64 {
        if (!0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_locks(arg0, arg1)) {
            return 0
        };
        1
    }

    public fun get_user_lock_summary(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : UserLockSummary {
        UserLockSummary{
            total_locks       : get_user_lock_count(arg0, arg1),
            total_yield_locks : get_user_yield_lock_count(arg0, arg1),
            has_locks         : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_locks(arg0, arg1),
            has_yield_locks   : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_yield_locks(arg0, arg1),
        }
    }

    public fun get_user_yield_lock_count(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : u64 {
        if (!0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_yield_locks(arg0, arg1)) {
            return 0
        };
        1
    }

    public fun get_yield_lock_count_by_token<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform) : u64 {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::get_yield_lock_count_for_token(arg0, 0x1::type_name::with_original_ids<T0>())
    }

    public fun get_yield_lock_details<T0>(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::YieldLock<T0>) : YieldLockInfo {
        let v0 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_start_time<T0>(arg0);
        let v1 = 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_duration_ms<T0>(arg0);
        YieldLockInfo{
            owner                 : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_owner<T0>(arg0),
            principal_base_amount : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_principal_amount<T0>(arg0),
            s_coin_balance        : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_s_coin_balance_value<T0>(arg0),
            start_time            : v0,
            duration_ms           : v1,
            coin_type             : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_coin_type<T0>(arg0),
            unlock_time           : v0 + v1,
            s_coin_unlocked       : 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_s_coin_unlocked<T0>(arg0),
        }
    }

    public fun is_lock_unlocked(arg0: &LockInfo, arg1: u64) : bool {
        arg1 >= arg0.unlock_time
    }

    public fun is_yield_lock_unlocked(arg0: &YieldLockInfo, arg1: u64) : bool {
        arg1 >= arg0.unlock_time
    }

    public fun lock_exists(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform, arg1: 0x2::object::ID) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::lock_exists(arg0, arg1)
    }

    public fun user_has_any_locks(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_locks(arg0, arg1) || 0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_yield_locks(arg0, arg1)
    }

    public fun user_has_locks(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_locks(arg0, arg1)
    }

    public fun user_has_yield_locks(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_has_yield_locks(arg0, arg1)
    }

    public fun user_owns_lock(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_owns_lock(arg0, arg1, arg2)
    }

    public fun user_owns_yield_lock(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::UserRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::user_owns_yield_lock(arg0, arg1, arg2)
    }

    public fun yield_lock_exists(arg0: &0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::Platform, arg1: 0x2::object::ID) : bool {
        0xc047d8d71a3c0704b4056baf3c8e97496714d74fc2a2c20dc76522e1bacf8f4e::sentra::yield_lock_exists(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

