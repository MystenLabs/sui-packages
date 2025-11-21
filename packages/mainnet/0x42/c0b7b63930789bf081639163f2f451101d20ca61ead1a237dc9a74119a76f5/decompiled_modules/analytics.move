module 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::analytics {
    struct LockInfo has copy, drop {
        owner: address,
        amount: u64,
        start_time: u64,
        duration_ms: u64,
        strategy: u8,
        unlock_time: u64,
    }

    struct YieldLockInfo has copy, drop {
        owner: address,
        principal_amount: u64,
        market_balance: u64,
        start_time: u64,
        duration_ms: u64,
        coin_type: 0x1::type_name::TypeName,
        strategy: u8,
        unlock_time: u64,
    }

    struct PlatformStats has copy, drop {
        supported_tokens: vector<0x1::type_name::TypeName>,
        paused_deposits: bool,
        paused_withdrawals: bool,
        total_tokens_supported: u64,
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
        lock_ids: vector<0x2::object::ID>,
        yield_lock_ids: vector<0x2::object::ID>,
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

    public fun get_accumulated_deposit_fees<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_deposit_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_accumulated_penalty_fees<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_accumulated_yield_fees<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_yield_fees(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0))
        } else {
            0
        }
    }

    public fun get_all_lock_ids(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : vector<0x2::object::ID> {
        0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_global_lock_list(arg0)
    }

    public fun get_all_tvl(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : vector<TVLStats> {
        let v0 = 0x1::vector::empty<TVLStats>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_supported_tokens(arg0);
        let v2 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_tvl_by_token(arg0);
        let v3 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_yield_tvl_by_token(arg0);
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

    public fun get_all_yield_lock_ids(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : vector<0x2::object::ID> {
        0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_global_yield_lock_list(arg0)
    }

    public fun get_fee_totals<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : TokenFeeStats {
        let v0 = get_accumulated_penalty_fees<T0>(arg0);
        let v1 = get_accumulated_yield_fees<T0>(arg0);
        let v2 = get_accumulated_deposit_fees<T0>(arg0);
        TokenFeeStats{
            penalty_fees : v0,
            yield_fees   : v1,
            deposit_fees : v2,
            total_fees   : v0 + v1 + v2,
        }
    }

    public fun get_global_lock_stats(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform, arg1: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry) : GlobalLockStats {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_global_lock_list(arg0);
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_global_yield_lock_list(arg0);
        GlobalLockStats{
            total_locks                  : 0x1::vector::length<0x2::object::ID>(&v0),
            total_yield_locks            : 0x1::vector::length<0x2::object::ID>(&v1),
            total_users_with_locks       : 0x2::vec_map::length<address, vector<0x2::object::ID>>(0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::registry_locks(arg1)),
            total_users_with_yield_locks : 0x2::vec_map::length<address, vector<0x2::object::ID>>(0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::registry_yield_locks(arg1)),
        }
    }

    public fun get_lock_count_by_token<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = get_locks_by_token<T0>(arg0);
        0x1::vector::length<0x2::object::ID>(&v0)
    }

    public fun get_lock_details<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Lock<T0>) : LockInfo {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::lock_start_time<T0>(arg0);
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::lock_duration_ms<T0>(arg0);
        LockInfo{
            owner       : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::lock_owner<T0>(arg0),
            amount      : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::lock_balance_value<T0>(arg0),
            start_time  : v0,
            duration_ms : v1,
            strategy    : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::lock_strategy<T0>(arg0),
            unlock_time : v0 + v1,
        }
    }

    public fun get_locks_by_token<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : vector<0x2::object::ID> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_locks_by_token(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, &v0)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_multiple_lock_details<T0>(arg0: &vector<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Lock<T0>>) : vector<LockInfo> {
        let v0 = 0x1::vector::empty<LockInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Lock<T0>>(arg0)) {
            0x1::vector::push_back<LockInfo>(&mut v0, get_lock_details<T0>(0x1::vector::borrow<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Lock<T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_multiple_yield_lock_details<T0>(arg0: &vector<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::YieldLock<T0>>) : vector<YieldLockInfo> {
        let v0 = 0x1::vector::empty<YieldLockInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::YieldLock<T0>>(arg0)) {
            0x1::vector::push_back<YieldLockInfo>(&mut v0, get_yield_lock_details<T0>(0x1::vector::borrow<0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::YieldLock<T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_platform_stats(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : PlatformStats {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_supported_tokens(arg0);
        let (v1, v2) = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_pause_status(arg0);
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

    public fun get_total_users_with_locks(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry) : u64 {
        0x2::vec_map::length<address, vector<0x2::object::ID>>(0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::registry_locks(arg0))
    }

    public fun get_total_users_with_yield_locks(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry) : u64 {
        0x2::vec_map::length<address, vector<0x2::object::ID>>(0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::registry_yield_locks(arg0))
    }

    public fun get_total_yield_locked<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_yield_tvl_by_token(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v1, &v0)
        } else {
            0
        }
    }

    public fun get_tvl<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::platform_tvl_by_token(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(v1, &v0)
        } else {
            0
        }
    }

    public fun get_tvl_stats<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::Platform) : TVLStats {
        let v0 = get_tvl<T0>(arg0);
        let v1 = get_total_yield_locked<T0>(arg0);
        TVLStats{
            token_type         : 0x1::type_name::with_original_ids<T0>(),
            total_locked       : v0,
            total_yield_locked : v1,
            combined_tvl       : v0 + v1,
        }
    }

    public fun get_user_lock_count(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : u64 {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_user_locks(arg0, arg1);
        0x1::vector::length<0x2::object::ID>(&v0)
    }

    public fun get_user_lock_summary(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : UserLockSummary {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_user_locks(arg0, arg1);
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_user_yield_locks(arg0, arg1);
        UserLockSummary{
            total_locks       : 0x1::vector::length<0x2::object::ID>(&v0),
            total_yield_locks : 0x1::vector::length<0x2::object::ID>(&v1),
            lock_ids          : v0,
            yield_lock_ids    : v1,
        }
    }

    public fun get_user_yield_lock_count(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : u64 {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::get_user_yield_locks(arg0, arg1);
        0x1::vector::length<0x2::object::ID>(&v0)
    }

    public fun get_yield_lock_details<T0>(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::YieldLock<T0>) : YieldLockInfo {
        let v0 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_start_time<T0>(arg0);
        let v1 = 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_duration_ms<T0>(arg0);
        YieldLockInfo{
            owner            : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_owner<T0>(arg0),
            principal_amount : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_principal_amount<T0>(arg0),
            market_balance   : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_market_balance_value<T0>(arg0),
            start_time       : v0,
            duration_ms      : v1,
            coin_type        : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_coin_type<T0>(arg0),
            strategy         : 0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::yield_lock_strategy<T0>(arg0),
            unlock_time      : v0 + v1,
        }
    }

    public fun is_lock_unlocked(arg0: &LockInfo, arg1: u64) : bool {
        arg1 >= arg0.unlock_time
    }

    public fun is_yield_lock_unlocked(arg0: &YieldLockInfo, arg1: u64) : bool {
        arg1 >= arg0.unlock_time
    }

    public fun user_has_any_locks(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : bool {
        user_has_locks(arg0, arg1) || user_has_yield_locks(arg0, arg1)
    }

    public fun user_has_locks(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : bool {
        get_user_lock_count(arg0, arg1) > 0
    }

    public fun user_has_yield_locks(arg0: &0x42c0b7b63930789bf081639163f2f451101d20ca61ead1a237dc9a74119a76f5::sentra::UserRegistry, arg1: address) : bool {
        get_user_yield_lock_count(arg0, arg1) > 0
    }

    // decompiled from Move bytecode v6
}

