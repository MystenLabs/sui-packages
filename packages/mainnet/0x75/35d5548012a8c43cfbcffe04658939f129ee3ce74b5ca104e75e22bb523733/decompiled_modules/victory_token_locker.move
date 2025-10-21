module 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token_locker {
    struct TokensLocked has copy, drop {
        user: address,
        lock_id: u64,
        amount: u64,
        lock_period: u64,
        lock_end: u64,
    }

    struct TokensUnlocked has copy, drop {
        user: address,
        lock_id: u64,
        amount: u64,
        victory_rewards: u64,
        sui_rewards: u64,
        timestamp: u64,
    }

    struct VictoryRewardsClaimed has copy, drop {
        user: address,
        lock_id: u64,
        amount: u64,
        timestamp: u64,
        total_claimed_for_lock: u64,
    }

    struct PoolSUIClaimed has copy, drop {
        user: address,
        epoch_id: u64,
        lock_id: u64,
        lock_period: u64,
        pool_type: u8,
        amount_staked: u64,
        sui_claimed: u64,
        timestamp: u64,
    }

    struct BatchEpochsClaimedForLock has copy, drop {
        user: address,
        lock_id: u64,
        lock_period: u64,
        lock_amount: u64,
        epochs_requested: u64,
        epochs_claimed: u64,
        epochs_skipped: u64,
        total_sui_claimed: u64,
        claimed_epoch_ids: vector<u64>,
        claimed_epoch_amounts: vector<u64>,
        timestamp: u64,
    }

    struct WeeklyRevenueAdded has copy, drop {
        epoch_id: u64,
        week_number: u64,
        amount: u64,
        total_week_revenue: u64,
        week_pool_sui: u64,
        three_month_pool_sui: u64,
        year_pool_sui: u64,
        three_year_pool_sui: u64,
        week_pool_total_staked: u64,
        three_month_pool_total_staked: u64,
        year_pool_total_staked: u64,
        three_year_pool_total_staked: u64,
        week_allocation_bp: u64,
        three_month_allocation_bp: u64,
        year_allocation_bp: u64,
        three_year_allocation_bp: u64,
        dynamic_allocations_used: bool,
        timestamp: u64,
    }

    struct ProtocolTimingInitialized has copy, drop {
        protocol_start: u64,
        epoch_duration: u64,
        timestamp: u64,
    }

    struct VictoryAllocationsUpdated has copy, drop {
        week_allocation: u64,
        three_month_allocation: u64,
        year_allocation: u64,
        three_year_allocation: u64,
        total_check: u64,
        timestamp: u64,
    }

    struct SUIAllocationsUpdated has copy, drop {
        week_allocation: u64,
        three_month_allocation: u64,
        year_allocation: u64,
        three_year_allocation: u64,
        total_check: u64,
        timestamp: u64,
    }

    struct VaultDeposit has copy, drop {
        vault_type: 0x1::string::String,
        amount: u64,
        total_balance: u64,
        timestamp: u64,
    }

    struct SUIAutoClaimSummary has copy, drop {
        user: address,
        lock_id: u64,
        total_sui_claimed: u64,
        timestamp: u64,
    }

    struct EmissionWarning has copy, drop {
        message: 0x1::string::String,
        lock_id: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct EpochCreated has copy, drop {
        epoch_id: u64,
        week_number: u64,
        week_start: u64,
        week_end: u64,
        timestamp: u64,
    }

    struct AdminPresaleLockCreated has copy, drop {
        admin: address,
        user: address,
        lock_id: u64,
        amount: u64,
        lock_period: u64,
        lock_end: u64,
        timestamp: u64,
    }

    struct LockedTokenVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct VictoryRewardVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct AdminVaultSweep has copy, drop {
        vault_type: 0x1::string::String,
        amount: u64,
        recipient: address,
        remaining_vault_balance: u64,
        timestamp: u64,
    }

    struct SUIRewardVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LockedTokenVault has key {
        id: 0x2::object::UID,
        locked_balance: 0x2::balance::Balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>,
        total_locked_amount: u64,
        total_unlocked_amount: u64,
        lock_count: u64,
        unlock_count: u64,
    }

    struct VictoryRewardVault has key {
        id: 0x2::object::UID,
        victory_balance: 0x2::balance::Balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>,
        total_deposited: u64,
        total_distributed: u64,
    }

    struct SUIRewardVault has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_deposited: u64,
        total_distributed: u64,
    }

    struct WeeklyPoolAllocations has copy, drop, store {
        epoch_id: u64,
        week_pool_allocation: u64,
        three_month_pool_allocation: u64,
        year_pool_allocation: u64,
        three_year_pool_allocation: u64,
        week_pool_sui: u64,
        three_month_pool_sui: u64,
        year_pool_sui: u64,
        three_year_pool_sui: u64,
        week_pool_total_staked: u64,
        three_month_pool_total_staked: u64,
        year_pool_total_staked: u64,
        three_year_pool_total_staked: u64,
    }

    struct WeeklyRevenueEpoch has drop, store {
        epoch_id: u64,
        week_number: u64,
        week_start_timestamp: u64,
        week_end_timestamp: u64,
        total_sui_revenue: u64,
        pool_allocations: WeeklyPoolAllocations,
        week_pool_claimed: u64,
        three_month_pool_claimed: u64,
        year_pool_claimed: u64,
        three_year_pool_claimed: u64,
        is_claimable: bool,
        allocations_finalized: bool,
    }

    struct VictoryPoolAccumulator has store {
        acc_victory_per_share: u256,
        last_reward_time: u64,
        total_staked: u64,
        total_victory_distributed: u64,
        lock_period: u64,
    }

    struct VictoryUserPosition has drop, store {
        stake_amount: u64,
        lock_start_time: u64,
        lock_end_time: u64,
        lock_period: u64,
        victory_reward_debt: u256,
        total_victory_claimed: u64,
        last_victory_claim_time: u64,
        is_active: bool,
        position_id: u64,
    }

    struct TokenLocker has key {
        id: 0x2::object::UID,
        protocol_start_timestamp: u64,
        epoch_duration_seconds: u64,
        week_locks: 0x2::table::Table<address, vector<Lock>>,
        three_month_locks: 0x2::table::Table<address, vector<Lock>>,
        year_locks: 0x2::table::Table<address, vector<Lock>>,
        three_year_locks: 0x2::table::Table<address, vector<Lock>>,
        lock_period_map: 0x2::table::Table<u64, u64>,
        week_total_locked: u64,
        three_month_total_locked: u64,
        year_total_locked: u64,
        three_year_total_locked: u64,
        victory_week_allocation: u64,
        victory_three_month_allocation: u64,
        victory_year_allocation: u64,
        victory_three_year_allocation: u64,
        sui_week_allocation: u64,
        sui_three_month_allocation: u64,
        sui_year_allocation: u64,
        sui_three_year_allocation: u64,
        weekly_epochs: 0x2::table::Table<u64, WeeklyRevenueEpoch>,
        current_epoch_id: u64,
        user_epoch_claims: 0x2::table::Table<address, 0x2::table::Table<u128, PoolClaimRecord>>,
        user_victory_claims: 0x2::table::Table<address, 0x2::table::Table<u64, VictoryClaimRecord>>,
        next_lock_id: u64,
        victory_week_accumulator: VictoryPoolAccumulator,
        victory_three_month_accumulator: VictoryPoolAccumulator,
        victory_year_accumulator: VictoryPoolAccumulator,
        victory_three_year_accumulator: VictoryPoolAccumulator,
        victory_user_positions: 0x2::table::Table<address, 0x2::table::Table<u64, VictoryUserPosition>>,
    }

    struct Lock has copy, drop, store {
        id: u64,
        amount: u64,
        lock_period: u64,
        lock_end: u64,
        stake_timestamp: u64,
        last_victory_claim_timestamp: u64,
        total_victory_claimed: u64,
        last_sui_epoch_claimed: u64,
        claimed_sui_epochs: vector<u64>,
    }

    struct PoolClaimRecord has store {
        epoch_id: u64,
        lock_id: u64,
        lock_period: u64,
        pool_type: u8,
        amount_staked: u64,
        sui_claimed: u64,
        claim_timestamp: u64,
    }

    struct VictoryClaimRecord has store {
        lock_id: u64,
        last_claim_timestamp: u64,
        total_claimed: u64,
        last_claim_amount: u64,
    }

    fun add_lock_to_pool(arg0: &mut TokenLocker, arg1: address, arg2: Lock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<u64, u64>(&mut arg0.lock_period_map, arg2.id, arg3);
        let v0 = get_lock_table_mut(arg0, arg3);
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            0x2::table::add<address, vector<Lock>>(v0, arg1, 0x1::vector::empty<Lock>());
        };
        0x1::vector::push_back<Lock>(0x2::table::borrow_mut<address, vector<Lock>>(v0, arg1), arg2);
    }

    public entry fun add_weekly_sui_revenue(arg0: &mut TokenLocker, arg1: &mut SUIRewardVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = get_current_epoch_id(arg0);
        assert!(v1 > 0, 1);
        assert!(epoch_exists(arg0, v1), 1);
        assert!(get_total_locked(arg0) >= 100000000, 27);
        assert!(!get_epoch(arg0, v1).allocations_finalized, 13);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.total_deposited = arg1.total_deposited + v0;
        let v2 = arg0.sui_week_allocation;
        let v3 = arg0.sui_three_month_allocation;
        let v4 = arg0.sui_year_allocation;
        let v5 = arg0.sui_three_year_allocation;
        assert!(v2 + v3 + v4 + v5 == 10000, 40);
        let v6 = arg0.week_total_locked;
        let v7 = arg0.three_month_total_locked;
        let v8 = arg0.year_total_locked;
        let v9 = arg0.three_year_total_locked;
        let v10 = get_epoch_mut(arg0, v1);
        v10.total_sui_revenue = v10.total_sui_revenue + v0;
        let v11 = safe_percentage_checked(v10.total_sui_revenue, v2);
        let v12 = safe_percentage_checked(v10.total_sui_revenue, v3);
        let v13 = safe_percentage_checked(v10.total_sui_revenue, v4);
        let v14 = v10.total_sui_revenue - v11 - v12 - v13;
        assert!(v11 + v12 + v13 + v14 == v10.total_sui_revenue, 41);
        let v15 = WeeklyPoolAllocations{
            epoch_id                      : v1,
            week_pool_allocation          : v2,
            three_month_pool_allocation   : v3,
            year_pool_allocation          : v4,
            three_year_pool_allocation    : v5,
            week_pool_sui                 : v11,
            three_month_pool_sui          : v12,
            year_pool_sui                 : v13,
            three_year_pool_sui           : v14,
            week_pool_total_staked        : v6,
            three_month_pool_total_staked : v7,
            year_pool_total_staked        : v8,
            three_year_pool_total_staked  : v9,
        };
        v10.pool_allocations = v15;
        v10.allocations_finalized = true;
        v10.is_claimable = true;
        let v16 = WeeklyRevenueAdded{
            epoch_id                      : v1,
            week_number                   : v10.week_number,
            amount                        : v0,
            total_week_revenue            : v10.total_sui_revenue,
            week_pool_sui                 : v11,
            three_month_pool_sui          : v12,
            year_pool_sui                 : v13,
            three_year_pool_sui           : v14,
            week_pool_total_staked        : v6,
            three_month_pool_total_staked : v7,
            year_pool_total_staked        : v8,
            three_year_pool_total_staked  : v9,
            week_allocation_bp            : v2,
            three_month_allocation_bp     : v3,
            year_allocation_bp            : v4,
            three_year_allocation_bp      : v5,
            dynamic_allocations_used      : true,
            timestamp                     : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<WeeklyRevenueAdded>(v16);
    }

    public entry fun admin_batch_create_user_locks(arg0: &mut TokenLocker, arg1: &mut LockedTokenVault, arg2: 0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg7: &AdminCap, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x1::vector::length<address>(&arg3);
        let v2 = 0x1::vector::length<u64>(&arg4);
        assert!(v1 == v2 && v2 == 0x1::vector::length<u64>(&arg5), 31);
        assert!(v1 > 0, 31);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            v3 = v3 + *0x1::vector::borrow<u64>(&arg4, v4);
            v4 = v4 + 1;
        };
        assert!(v0 >= v3, 32);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = 0x2::coin::split<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg2, *0x1::vector::borrow<u64>(&arg4, v5), arg9);
            admin_create_single_lock_internal(arg0, arg1, v6, *0x1::vector::borrow<address>(&arg3, v5), *0x1::vector::borrow<u64>(&arg5, v5), arg6, arg8, arg9);
            v5 = v5 + 1;
        };
        if (0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>>(arg2, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(arg2);
        };
    }

    public entry fun admin_create_next_epoch(arg0: &mut TokenLocker, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.protocol_start_timestamp > 0, 28);
        let (v0, _) = calculate_epoch_window(arg0, arg0.current_epoch_id + 1);
        create_new_epoch(arg0, v0);
    }

    fun admin_create_single_lock_internal(arg0: &mut TokenLocker, arg1: &mut LockedTokenVault, arg2: 0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>, arg3: address, arg4: u64, arg5: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2);
        assert!(v0 > 0, 3);
        assert!(arg3 != @0x0, 30);
        let v1 = if (arg4 == 7) {
            true
        } else if (arg4 == 90) {
            true
        } else if (arg4 == 365) {
            true
        } else {
            arg4 == 1095
        };
        assert!(v1, 8);
        let v2 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v3 = arg0.next_lock_id;
        let (v4, v5, v6) = validate_emission_state(arg5, arg6);
        if (!v4) {
        } else {
            if (!v5) {
                abort 23
            };
            if (v6) {
                abort 24
            };
        };
        let v7 = calculate_intelligent_lock_end(arg5, v2, arg4);
        let v8 = Lock{
            id                           : v3,
            amount                       : v0,
            lock_period                  : arg4,
            lock_end                     : v7,
            stake_timestamp              : v2,
            last_victory_claim_timestamp : v2,
            total_victory_claimed        : 0,
            last_sui_epoch_claimed       : 0,
            claimed_sui_epochs           : 0x1::vector::empty<u64>(),
        };
        add_lock_to_pool(arg0, arg3, v8, arg4, arg7);
        update_pool_totals(arg0, arg4, v0, true);
        arg0.next_lock_id = arg0.next_lock_id + 1;
        0x2::balance::join<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg1.locked_balance, 0x2::coin::into_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(arg2));
        arg1.total_locked_amount = arg1.total_locked_amount + v0;
        arg1.lock_count = arg1.lock_count + 1;
        create_victory_position(arg0, arg3, v3, v0, arg4, v7, v2, arg5, arg6, arg7);
        let v9 = AdminPresaleLockCreated{
            admin       : 0x2::tx_context::sender(arg7),
            user        : arg3,
            lock_id     : v3,
            amount      : v0,
            lock_period : arg4,
            lock_end    : v7,
            timestamp   : v2,
        };
        0x2::event::emit<AdminPresaleLockCreated>(v9);
        let v10 = TokensLocked{
            user        : arg3,
            lock_id     : v3,
            amount      : v0,
            lock_period : arg4,
            lock_end    : v7,
        };
        0x2::event::emit<TokensLocked>(v10);
    }

    public entry fun admin_create_user_lock(arg0: &mut TokenLocker, arg1: &mut LockedTokenVault, arg2: 0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>, arg3: address, arg4: u64, arg5: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg6: &AdminCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2);
        assert!(v0 > 0, 3);
        assert!(arg3 != @0x0, 30);
        let v1 = if (arg4 == 7) {
            true
        } else if (arg4 == 90) {
            true
        } else if (arg4 == 365) {
            true
        } else {
            arg4 == 1095
        };
        assert!(v1, 8);
        let v2 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v3 = arg0.next_lock_id;
        let (v4, v5, v6) = validate_emission_state(arg5, arg7);
        let v7 = if (!v4) {
            true
        } else if (!v5) {
            true
        } else {
            v6
        };
        if (v7) {
            let v8 = if (!v4) {
                0x1::string::utf8(b"Admin locking for presale - emissions not started yet")
            } else if (!v5) {
                0x1::string::utf8(b"Admin locking for presale - emissions ended")
            } else {
                0x1::string::utf8(b"Admin locking for presale - emissions paused")
            };
            let v9 = EmissionWarning{
                message   : v8,
                lock_id   : 0x1::option::some<u64>(v3),
                timestamp : v2,
            };
            0x2::event::emit<EmissionWarning>(v9);
        } else {
            if (!v5) {
                abort 23
            };
            if (v6) {
                abort 24
            };
        };
        let v10 = calculate_intelligent_lock_end(arg5, v2, arg4);
        let v11 = Lock{
            id                           : v3,
            amount                       : v0,
            lock_period                  : arg4,
            lock_end                     : v10,
            stake_timestamp              : v2,
            last_victory_claim_timestamp : v2,
            total_victory_claimed        : 0,
            last_sui_epoch_claimed       : 0,
            claimed_sui_epochs           : 0x1::vector::empty<u64>(),
        };
        add_lock_to_pool(arg0, arg3, v11, arg4, arg8);
        update_pool_totals(arg0, arg4, v0, true);
        arg0.next_lock_id = arg0.next_lock_id + 1;
        0x2::balance::join<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg1.locked_balance, 0x2::coin::into_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(arg2));
        arg1.total_locked_amount = arg1.total_locked_amount + v0;
        arg1.lock_count = arg1.lock_count + 1;
        create_victory_position(arg0, arg3, v3, v0, arg4, v10, v2, arg5, arg7, arg8);
        let v12 = AdminPresaleLockCreated{
            admin       : 0x2::tx_context::sender(arg8),
            user        : arg3,
            lock_id     : v3,
            amount      : v0,
            lock_period : arg4,
            lock_end    : v10,
            timestamp   : v2,
        };
        0x2::event::emit<AdminPresaleLockCreated>(v12);
        let v13 = TokensLocked{
            user        : arg3,
            lock_id     : v3,
            amount      : v0,
            lock_period : arg4,
            lock_end    : v10,
        };
        0x2::event::emit<TokensLocked>(v13);
    }

    public entry fun admin_fund_specific_epoch(arg0: &mut TokenLocker, arg1: &mut SUIRewardVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &AdminCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 3);
        assert!(epoch_exists(arg0, arg3), 1);
        assert!(get_total_locked(arg0) >= 100000000, 27);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.total_deposited = arg1.total_deposited + v0;
        let v1 = arg0.sui_week_allocation;
        let v2 = arg0.sui_three_month_allocation;
        let v3 = arg0.sui_year_allocation;
        let v4 = arg0.sui_three_year_allocation;
        assert!(v1 + v2 + v3 + v4 == 10000, 40);
        let v5 = arg0.week_total_locked;
        let v6 = arg0.three_month_total_locked;
        let v7 = arg0.year_total_locked;
        let v8 = arg0.three_year_total_locked;
        let v9 = get_epoch_mut(arg0, arg3);
        v9.total_sui_revenue = v9.total_sui_revenue + v0;
        let v10 = safe_percentage_checked(v9.total_sui_revenue, v1);
        let v11 = safe_percentage_checked(v9.total_sui_revenue, v2);
        let v12 = safe_percentage_checked(v9.total_sui_revenue, v3);
        let v13 = v9.total_sui_revenue - v10 - v11 - v12;
        assert!(v10 + v11 + v12 + v13 == v9.total_sui_revenue, 41);
        let v14 = WeeklyPoolAllocations{
            epoch_id                      : arg3,
            week_pool_allocation          : v1,
            three_month_pool_allocation   : v2,
            year_pool_allocation          : v3,
            three_year_pool_allocation    : v4,
            week_pool_sui                 : v10,
            three_month_pool_sui          : v11,
            year_pool_sui                 : v12,
            three_year_pool_sui           : v13,
            week_pool_total_staked        : v5,
            three_month_pool_total_staked : v6,
            year_pool_total_staked        : v7,
            three_year_pool_total_staked  : v8,
        };
        v9.pool_allocations = v14;
        v9.allocations_finalized = true;
        v9.is_claimable = true;
        let v15 = WeeklyRevenueAdded{
            epoch_id                      : arg3,
            week_number                   : v9.week_number,
            amount                        : v0,
            total_week_revenue            : v9.total_sui_revenue,
            week_pool_sui                 : v10,
            three_month_pool_sui          : v11,
            year_pool_sui                 : v12,
            three_year_pool_sui           : v13,
            week_pool_total_staked        : v5,
            three_month_pool_total_staked : v6,
            year_pool_total_staked        : v7,
            three_year_pool_total_staked  : v8,
            week_allocation_bp            : v1,
            three_month_allocation_bp     : v2,
            year_allocation_bp            : v3,
            three_year_allocation_bp      : v4,
            dynamic_allocations_used      : true,
            timestamp                     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<WeeklyRevenueAdded>(v15);
    }

    public entry fun admin_sweep_sui_reward_vault(arg0: &mut SUIRewardVault, arg1: u64, arg2: address, arg3: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg4: &AdminCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 30);
        assert!(arg1 > 0, 46);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 47);
        let (v0, v1, v2) = validate_emission_state(arg3, arg5);
        assert!(v2 || v0 && !v1, 44);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg6), arg2);
        let v3 = AdminVaultSweep{
            vault_type              : 0x1::string::utf8(b"SUIRewards"),
            amount                  : arg1,
            recipient               : arg2,
            remaining_vault_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            timestamp               : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<AdminVaultSweep>(v3);
    }

    public entry fun admin_sweep_victory_reward_vault(arg0: &mut VictoryRewardVault, arg1: u64, arg2: address, arg3: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg4: &AdminCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 30);
        assert!(arg1 > 0, 46);
        assert!(0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) >= arg1, 47);
        let (v0, v1, v2) = validate_emission_state(arg3, arg5);
        assert!(v2 || v0 && !v1, 44);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>>(0x2::coin::from_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(0x2::balance::split<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, arg1), arg6), arg2);
        let v3 = AdminVaultSweep{
            vault_type              : 0x1::string::utf8(b"VictoryRewards"),
            amount                  : arg1,
            recipient               : arg2,
            remaining_vault_balance : 0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance),
            timestamp               : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<AdminVaultSweep>(v3);
    }

    public fun batch_check_claim_status(arg0: &TokenLocker, arg1: address, arg2: vector<u64>, arg3: vector<u64>) : vector<bool> {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 31);
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v1, has_user_claimed_pool_epoch(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public entry fun batch_claim_epochs_for_lock(arg0: &mut TokenLocker, arg1: &mut SUIRewardVault, arg2: u64, arg3: vector<u64>, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        validate_claim_allowed(arg4, arg5);
        let v2 = 0x1::vector::length<u64>(&arg3);
        assert!(v2 > 0, 16);
        let (v3, v4) = find_user_lock_any_pool(arg0, v0, arg2);
        let v5 = *v3;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        while (v11 < v2) {
            let v12 = *0x1::vector::borrow<u64>(&arg3, v11);
            if (!epoch_exists(arg0, v12) || has_user_claimed_pool_epoch(arg0, v0, v12, arg2)) {
                0x1::vector::push_back<u64>(&mut v10, v12);
                v11 = v11 + 1;
                continue
            };
            let v13 = get_epoch(arg0, v12);
            let v14 = if (v13.is_claimable) {
                if (v1 >= v13.week_end_timestamp) {
                    if (v5.stake_timestamp < v13.week_start_timestamp) {
                        v5.lock_end >= v13.week_end_timestamp
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                let v15 = calculate_pool_based_sui_rewards_with_allocations(&v13.pool_allocations, &v5, v4);
                if (v15 > 0) {
                    mark_pool_epoch_claimed(arg0, v0, v12, arg2, v4, v15, v1, arg6);
                    update_epoch_pool_claimed(arg0, v12, v4, v15);
                    let v16 = get_user_lock_mut(arg0, v0, arg2, v4);
                    v16.last_sui_epoch_claimed = v12;
                    0x1::vector::push_back<u64>(&mut v16.claimed_sui_epochs, v12);
                    distribute_sui_from_vault(arg1, v15, v0, arg6);
                    v6 = v6 + v15;
                    v7 = v7 + 1;
                    0x1::vector::push_back<u64>(&mut v8, v12);
                    0x1::vector::push_back<u64>(&mut v9, v15);
                    let v17 = PoolSUIClaimed{
                        user          : v0,
                        epoch_id      : v12,
                        lock_id       : arg2,
                        lock_period   : v4,
                        pool_type     : get_pool_type_id(v4),
                        amount_staked : v5.amount,
                        sui_claimed   : v15,
                        timestamp     : v1,
                    };
                    0x2::event::emit<PoolSUIClaimed>(v17);
                } else {
                    0x1::vector::push_back<u64>(&mut v10, v12);
                };
            } else {
                0x1::vector::push_back<u64>(&mut v10, v12);
            };
            v11 = v11 + 1;
        };
        let v18 = BatchEpochsClaimedForLock{
            user                  : v0,
            lock_id               : arg2,
            lock_period           : v4,
            lock_amount           : v5.amount,
            epochs_requested      : v2,
            epochs_claimed        : v7,
            epochs_skipped        : 0x1::vector::length<u64>(&v10),
            total_sui_claimed     : v6,
            claimed_epoch_ids     : v8,
            claimed_epoch_amounts : v9,
            timestamp             : v1,
        };
        0x2::event::emit<BatchEpochsClaimedForLock>(v18);
    }

    fun calculate_emission_week_from_timestamp_precise(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: u64) : u64 {
        0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_canonical_week_for_timestamp(arg0, arg1)
    }

    fun calculate_emission_week_start_precise(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: u64) : u64 {
        let (v0, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg0);
        if (arg1 <= 1) {
            v0
        } else if (arg1 > 156) {
            v0 + 156 * 86400 * 7
        } else {
            v0 + (arg1 - 1) * 86400 * 7
        }
    }

    fun calculate_epoch_window(arg0: &TokenLocker, arg1: u64) : (u64, u64) {
        assert!(arg0.protocol_start_timestamp > 0, 28);
        let v0 = arg0.protocol_start_timestamp + (arg1 - 1) * arg0.epoch_duration_seconds;
        (v0, v0 + arg0.epoch_duration_seconds)
    }

    fun calculate_intelligent_lock_end(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 + arg2 * 86400;
        let (v1, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg0);
        if (v1 == 0) {
            return v0
        };
        let v3 = get_emission_end_timestamp(arg0);
        if (v0 <= v3) {
            v0
        } else {
            v3
        }
    }

    public fun calculate_pending_victory_rewards(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: &0x2::clock::Clock) : u64 {
        calculate_pending_victory_rewards_at_time(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5) / 1000)
    }

    public fun calculate_pending_victory_rewards_at_time(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: u64) : u64 {
        if (!has_victory_position(arg0, arg1, arg2)) {
            return 0
        };
        let v0 = get_victory_position(arg0, arg1, arg2);
        let v1 = get_emission_end_timestamp(arg4);
        let v2 = v0.lock_end_time;
        let v3 = arg5;
        if (arg5 > v1) {
            v3 = v1;
        };
        if (v3 > v2) {
            v3 = v2;
        };
        let v4 = safe_mul_div_u256((v0.stake_amount as u256), simulate_accumulator_update(get_victory_accumulator(arg0, arg3), arg0, arg4, v3), 1000000000000000000);
        if (v4 <= v0.victory_reward_debt) {
            return 0
        };
        let v5 = v4 - v0.victory_reward_debt;
        if (v5 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v5 as u64)
        }
    }

    fun calculate_period_rewards_multi_week(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: u64, arg2: u64, arg3: u64) : u256 {
        if (arg2 >= arg3) {
            return 0
        };
        let (v0, v1) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg0);
        if (v0 == 0 || v1) {
            return 0
        };
        let v2 = get_emission_end_timestamp(arg0);
        let v3 = if (arg3 > v2) {
            v2
        } else {
            arg3
        };
        if (arg2 >= v2) {
            return 0
        };
        let v4 = if (arg2 < v0) {
            v0
        } else {
            arg2
        };
        let v5 = calculate_emission_week_from_timestamp_precise(arg0, v4);
        let v6 = calculate_emission_week_from_timestamp_precise(arg0, v3);
        let v7 = if (v5 == 0) {
            true
        } else if (v6 == 0) {
            true
        } else if (v5 > 156) {
            true
        } else {
            v6 > 156
        };
        if (v7) {
            return 0
        };
        let v8 = 0;
        while (v5 <= v6 && v5 <= 156) {
            let v9 = calculate_emission_week_start_precise(arg0, v5);
            let v10 = v9 + 86400 * 7;
            let v11 = if (v5 == v5) {
                if (v4 > v9) {
                    v4
                } else {
                    v9
                }
            } else {
                v9
            };
            let v12 = if (v3 < v10) {
                v3
            } else {
                v10
            };
            if (v11 < v12) {
                v8 = v8 + get_victory_allocation_for_emission_week_precise(arg0, v5) * (arg1 as u256) / (10000 as u256) * ((v12 - v11) as u256);
            };
            v5 = v5 + 1;
        };
        v8
    }

    fun calculate_pool_based_sui_rewards_with_allocations(arg0: &WeeklyPoolAllocations, arg1: &Lock, arg2: u64) : u64 {
        let (v0, v1) = if (arg2 == 7) {
            (arg0.week_pool_sui, arg0.week_pool_total_staked)
        } else if (arg2 == 90) {
            (arg0.three_month_pool_sui, arg0.three_month_pool_total_staked)
        } else if (arg2 == 365) {
            (arg0.year_pool_sui, arg0.year_pool_total_staked)
        } else {
            (arg0.three_year_pool_sui, arg0.three_year_pool_total_staked)
        };
        if (v1 == 0 || v0 == 0) {
            return 0
        };
        safe_mul_div(arg1.amount, v0, v1)
    }

    public fun can_user_claim_epoch(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        if (!epoch_exists(arg0, arg2)) {
            return (false, 0x1::string::utf8(b"Epoch does not exist"))
        };
        let v0 = get_epoch(arg0, arg2);
        if (0x2::clock::timestamp_ms(arg4) / 1000 < v0.week_end_timestamp) {
            return (false, 0x1::string::utf8(b"Week not finished"))
        };
        if (!v0.is_claimable) {
            return (false, 0x1::string::utf8(b"Claiming disabled"))
        };
        let (v1, _) = find_user_lock_any_pool_safe(arg0, arg1, arg3);
        if (!v1) {
            return (false, 0x1::string::utf8(b"User does not own this lock"))
        };
        if (has_user_claimed_pool_epoch(arg0, arg1, arg2, arg3)) {
            return (false, 0x1::string::utf8(b"Already claimed"))
        };
        let (v3, _) = find_user_lock_any_pool(arg0, arg1, arg3);
        if (v3.stake_timestamp >= v0.week_start_timestamp) {
            return (false, 0x1::string::utf8(b"Staked during or after epoch start"))
        };
        if (v3.lock_end < v0.week_end_timestamp) {
            return (false, 0x1::string::utf8(b"Lock expired before epoch ended"))
        };
        (true, 0x1::string::utf8(b"Can claim"))
    }

    public fun check_specific_claim_status(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : bool {
        has_user_claimed_pool_epoch(arg0, arg1, arg2, arg3)
    }

    fun check_unlock_balance(arg0: &LockedTokenVault, arg1: u64) : bool {
        0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.locked_balance) >= arg1
    }

    public entry fun claim_pool_sui_rewards(arg0: &mut TokenLocker, arg1: &mut SUIRewardVault, arg2: u64, arg3: u64, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        validate_claim_allowed(arg4, arg5);
        assert!(epoch_exists(arg0, arg2), 5);
        let v2 = get_epoch(arg0, arg2);
        assert!(v1 >= v2.week_end_timestamp, 10);
        assert!(v2.allocations_finalized, 6);
        assert!(v2.is_claimable, 11);
        let v3 = v2.week_end_timestamp;
        let v4 = v2.pool_allocations;
        assert!(!has_user_claimed_pool_epoch(arg0, v0, arg2, arg3), 9);
        let (v5, v6) = find_user_lock_any_pool(arg0, v0, arg3);
        let v7 = *v5;
        validate_full_week_staking_with_timestamps(&v7, v2.week_start_timestamp, v3);
        let v8 = calculate_pool_based_sui_rewards_with_allocations(&v4, &v7, v6);
        assert!(v8 > 0, 16);
        mark_pool_epoch_claimed(arg0, v0, arg2, arg3, v6, v8, v1, arg6);
        let v9 = get_user_lock_mut(arg0, v0, arg3, v6);
        v9.last_sui_epoch_claimed = arg2;
        0x1::vector::push_back<u64>(&mut v9.claimed_sui_epochs, arg2);
        update_epoch_pool_claimed(arg0, arg2, v6, v8);
        distribute_sui_from_vault(arg1, v8, v0, arg6);
        let v10 = PoolSUIClaimed{
            user          : v0,
            epoch_id      : arg2,
            lock_id       : arg3,
            lock_period   : v6,
            pool_type     : get_pool_type_id(v6),
            amount_staked : v7.amount,
            sui_claimed   : v8,
            timestamp     : v1,
        };
        0x2::event::emit<PoolSUIClaimed>(v10);
    }

    public entry fun claim_victory_rewards(arg0: &mut TokenLocker, arg1: &mut VictoryRewardVault, arg2: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        validate_claim_allowed(arg2, arg5);
        let (v2, _) = find_user_lock_any_pool(arg0, v0, arg3);
        let v4 = get_emission_end_timestamp(arg2);
        let v5 = v2.lock_end;
        let v6 = v1;
        if (v1 > v4) {
            v6 = v4;
        };
        if (v6 > v5) {
            v6 = v5;
        };
        let (v7, _, v9) = validate_emission_state(arg2, arg5);
        assert!(v7, 22);
        assert!(!v9, 24);
        assert!(has_victory_position(arg0, v0, arg3), 4);
        let v10 = get_victory_position(arg0, v0, arg3);
        if (!(v1 > v2.lock_end)) {
            assert!(v6 >= v10.last_victory_claim_time + 10, 36);
        };
        assert!(v10.is_active, 4);
        assert!(v10.lock_period == arg4, 4);
        if (v7 && !v9) {
            update_victory_accumulator_for_period(arg0, arg4, arg2, arg5, v6);
        };
        let v11 = calculate_pending_victory_rewards_at_time(arg0, v0, arg3, arg4, arg2, v6);
        assert!(v11 > 0, 17);
        let v12 = get_victory_accumulator(arg0, arg4).acc_victory_per_share;
        let v13 = get_victory_position_mut(arg0, v0, arg3);
        v13.victory_reward_debt = safe_mul_div_u256((v13.stake_amount as u256), v12, 1000000000000000000);
        v13.last_victory_claim_time = v6;
        v13.total_victory_claimed = v13.total_victory_claimed + v11;
        update_global_victory_claim_record(arg0, v0, arg3, v11, v6, arg6);
        distribute_victory_from_vault(arg1, v11, v0, arg6);
        let v14 = VictoryRewardsClaimed{
            user                   : v0,
            lock_id                : arg3,
            amount                 : v11,
            timestamp              : v6,
            total_claimed_for_lock : get_victory_position(arg0, v0, arg3).total_victory_claimed,
        };
        0x2::event::emit<VictoryRewardsClaimed>(v14);
    }

    public entry fun configure_sui_allocations(arg0: &mut TokenLocker, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &0x2::clock::Clock) {
        assert!(arg1 <= 10000, 43);
        assert!(arg2 <= 10000, 43);
        assert!(arg3 <= 10000, 43);
        assert!(arg4 <= 10000, 43);
        let v0 = arg1 + arg2 + arg3 + arg4;
        assert!(v0 == 10000, 21);
        arg0.sui_week_allocation = arg1;
        arg0.sui_three_month_allocation = arg2;
        arg0.sui_year_allocation = arg3;
        arg0.sui_three_year_allocation = arg4;
        let v1 = SUIAllocationsUpdated{
            week_allocation        : arg1,
            three_month_allocation : arg2,
            year_allocation        : arg3,
            three_year_allocation  : arg4,
            total_check            : v0,
            timestamp              : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<SUIAllocationsUpdated>(v1);
    }

    public entry fun configure_victory_allocations(arg0: &mut TokenLocker, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &0x2::clock::Clock) {
        assert!(arg1 <= 10000, 43);
        assert!(arg2 <= 10000, 43);
        assert!(arg3 <= 10000, 43);
        assert!(arg4 <= 10000, 43);
        let v0 = arg1 + arg2 + arg3 + arg4;
        assert!(v0 == 10000, 20);
        arg0.victory_week_allocation = arg1;
        arg0.victory_three_month_allocation = arg2;
        arg0.victory_year_allocation = arg3;
        arg0.victory_three_year_allocation = arg4;
        let v1 = VictoryAllocationsUpdated{
            week_allocation        : arg1,
            three_month_allocation : arg2,
            year_allocation        : arg3,
            three_year_allocation  : arg4,
            total_check            : v0,
            timestamp              : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<VictoryAllocationsUpdated>(v1);
    }

    fun create_claim_key(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 < 4294967296, 37);
        assert!(arg1 < 4294967296, 38);
        (arg0 as u128) << 64 | (arg1 as u128)
    }

    public entry fun create_locked_token_vault(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedTokenVault{
            id                    : 0x2::object::new(arg2),
            locked_balance        : 0x2::balance::zero<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(),
            total_locked_amount   : 0,
            total_unlocked_amount : 0,
            lock_count            : 0,
            unlock_count          : 0,
        };
        0x2::transfer::share_object<LockedTokenVault>(v0);
        let v1 = LockedTokenVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0.id),
            admin     : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<LockedTokenVaultCreated>(v1);
    }

    fun create_new_epoch(arg0: &mut TokenLocker, arg1: u64) : u64 {
        let v0 = arg0.epoch_duration_seconds;
        let v1 = arg0.current_epoch_id + 1;
        let v2 = WeeklyPoolAllocations{
            epoch_id                      : v1,
            week_pool_allocation          : 0,
            three_month_pool_allocation   : 0,
            year_pool_allocation          : 0,
            three_year_pool_allocation    : 0,
            week_pool_sui                 : 0,
            three_month_pool_sui          : 0,
            year_pool_sui                 : 0,
            three_year_pool_sui           : 0,
            week_pool_total_staked        : 0,
            three_month_pool_total_staked : 0,
            year_pool_total_staked        : 0,
            three_year_pool_total_staked  : 0,
        };
        let v3 = WeeklyRevenueEpoch{
            epoch_id                 : v1,
            week_number              : v1,
            week_start_timestamp     : arg1,
            week_end_timestamp       : arg1 + v0,
            total_sui_revenue        : 0,
            pool_allocations         : v2,
            week_pool_claimed        : 0,
            three_month_pool_claimed : 0,
            year_pool_claimed        : 0,
            three_year_pool_claimed  : 0,
            is_claimable             : false,
            allocations_finalized    : false,
        };
        0x2::table::add<u64, WeeklyRevenueEpoch>(&mut arg0.weekly_epochs, v1, v3);
        arg0.current_epoch_id = v1;
        let v4 = EpochCreated{
            epoch_id    : v1,
            week_number : v1,
            week_start  : arg1,
            week_end    : arg1 + v0,
            timestamp   : arg1,
        };
        0x2::event::emit<EpochCreated>(v4);
        v1
    }

    public entry fun create_sui_reward_vault(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIRewardVault{
            id                : 0x2::object::new(arg2),
            sui_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_deposited   : 0,
            total_distributed : 0,
        };
        0x2::transfer::share_object<SUIRewardVault>(v0);
        let v1 = SUIRewardVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0.id),
            admin     : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<SUIRewardVaultCreated>(v1);
    }

    fun create_victory_position(arg0: &mut TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        update_victory_accumulator_for_period(arg0, arg4, arg7, arg8, arg6);
        let v0 = get_victory_accumulator(arg0, arg4).acc_victory_per_share;
        let v1 = get_victory_accumulator_mut(arg0, arg4);
        v1.total_staked = v1.total_staked + arg3;
        let v2 = VictoryUserPosition{
            stake_amount            : arg3,
            lock_start_time         : arg6,
            lock_end_time           : arg5,
            lock_period             : arg4,
            victory_reward_debt     : safe_mul_div_u256((arg3 as u256), v0, 1000000000000000000),
            total_victory_claimed   : 0,
            last_victory_claim_time : arg6,
            is_active               : true,
            position_id             : arg2,
        };
        if (!0x2::table::contains<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u64, VictoryUserPosition>>(&mut arg0.victory_user_positions, arg1, 0x2::table::new<u64, VictoryUserPosition>(arg9));
        };
        0x2::table::add<u64, VictoryUserPosition>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, VictoryUserPosition>>(&mut arg0.victory_user_positions, arg1), arg2, v2);
    }

    public entry fun create_victory_reward_vault(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VictoryRewardVault{
            id                : 0x2::object::new(arg2),
            victory_balance   : 0x2::balance::zero<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(),
            total_deposited   : 0,
            total_distributed : 0,
        };
        0x2::transfer::share_object<VictoryRewardVault>(v0);
        let v1 = VictoryRewardVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0.id),
            admin     : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<VictoryRewardVaultCreated>(v1);
    }

    public entry fun deposit_victory_tokens(arg0: &mut VictoryRewardVault, arg1: &mut TokenLocker, arg2: 0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance);
        assert!(v1 + v0 >= v1, 18);
        assert!(arg0.total_deposited + v0 >= arg0.total_deposited, 19);
        0x2::balance::join<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, 0x2::coin::into_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(arg2));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v2 = VaultDeposit{
            vault_type    : 0x1::string::utf8(b"Victory Rewards"),
            amount        : (v0 as u64),
            total_balance : (0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) as u64),
            timestamp     : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<VaultDeposit>(v2);
    }

    fun distribute_sui_from_vault(arg0: &mut SUIRewardVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg3), arg2);
        arg0.total_distributed = arg0.total_distributed + arg1;
    }

    fun distribute_victory_from_vault(arg0: &mut VictoryRewardVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) >= arg1, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>>(0x2::coin::from_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(0x2::balance::split<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, arg1), arg3), arg2);
        arg0.total_distributed = arg0.total_distributed + arg1;
    }

    fun epoch_exists(arg0: &TokenLocker, arg1: u64) : bool {
        0x2::table::contains<u64, WeeklyRevenueEpoch>(&arg0.weekly_epochs, arg1)
    }

    fun find_and_prepare_unlock(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig) : (Lock, u64) {
        let v0 = get_lock_table(arg0, arg3);
        assert!(0x2::table::contains<address, vector<Lock>>(v0, arg1), 4);
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        let v2 = get_emission_end_timestamp(arg5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Lock>(v1)) {
            let v4 = 0x1::vector::borrow<Lock>(v1, v3);
            if (v4.id == arg2) {
                let v5 = v2 > 0 && arg4 >= v2;
                assert!(arg4 >= v4.lock_end || v5, 2);
                return (*v4, v3)
            };
            v3 = v3 + 1;
        };
        abort 4
    }

    fun find_user_lock_any_pool(arg0: &TokenLocker, arg1: address, arg2: u64) : (&Lock, u64) {
        assert!(0x2::table::contains<u64, u64>(&arg0.lock_period_map, arg2), 4);
        let v0 = *0x2::table::borrow<u64, u64>(&arg0.lock_period_map, arg2);
        let v1 = get_lock_table(arg0, v0);
        assert!(0x2::table::contains<address, vector<Lock>>(v1, arg1), 4);
        let v2 = 0x2::table::borrow<address, vector<Lock>>(v1, arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Lock>(v2)) {
            let v4 = 0x1::vector::borrow<Lock>(v2, v3);
            if (v4.id == arg2) {
                return (v4, v0)
            };
            v3 = v3 + 1;
        };
        abort 4
    }

    fun find_user_lock_any_pool_safe(arg0: &TokenLocker, arg1: address, arg2: u64) : (bool, u64) {
        if (!0x2::table::contains<u64, u64>(&arg0.lock_period_map, arg2)) {
            return (false, 0)
        };
        let v0 = *0x2::table::borrow<u64, u64>(&arg0.lock_period_map, arg2);
        let v1 = if (v0 == 7) {
            &arg0.week_locks
        } else if (v0 == 90) {
            &arg0.three_month_locks
        } else if (v0 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        };
        if (!0x2::table::contains<address, vector<Lock>>(v1, arg1)) {
            return (false, 0)
        };
        let v2 = 0x2::table::borrow<address, vector<Lock>>(v1, arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Lock>(v2)) {
            if (0x1::vector::borrow<Lock>(v2, v3).id == arg2) {
                return (true, v0)
            };
            v3 = v3 + 1;
        };
        (false, 0)
    }

    public fun get_all_epochs_info(arg0: &TokenLocker) : (vector<u64>, vector<u64>, vector<bool>) {
        let v0 = get_current_epoch_id(arg0);
        let v1 = if (v0 > 200) {
            200
        } else {
            v0
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 1;
        while (v5 <= v1) {
            if (epoch_exists(arg0, v5)) {
                let v6 = get_epoch(arg0, v5);
                0x1::vector::push_back<u64>(&mut v2, v5);
                0x1::vector::push_back<u64>(&mut v3, v6.total_sui_revenue);
                0x1::vector::push_back<bool>(&mut v4, v6.is_claimable);
            };
            v5 = v5 + 1;
        };
        (v2, v3, v4)
    }

    public fun get_all_user_locks(arg0: &TokenLocker, arg1: address) : vector<Lock> {
        let v0 = 0x1::vector::empty<Lock>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 7);
        0x1::vector::push_back<u64>(v2, 90);
        0x1::vector::push_back<u64>(v2, 365);
        0x1::vector::push_back<u64>(v2, 1095);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = get_user_locks_for_period(arg0, arg1, *0x1::vector::borrow<u64>(&v1, v3));
            let v5 = 0;
            while (v5 < 0x1::vector::length<Lock>(&v4)) {
                0x1::vector::push_back<Lock>(&mut v0, *0x1::vector::borrow<Lock>(&v4, v5));
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        v0
    }

    public fun get_balance_overview(arg0: &TokenLocker, arg1: &LockedTokenVault, arg2: &VictoryRewardVault, arg3: &SUIRewardVault) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg1.locked_balance), get_total_locked(arg0), 0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2.victory_balance), get_total_reward_tokens_from_vault(arg2), 0x2::balance::value<0x2::sui::SUI>(&arg3.sui_balance), arg3.total_deposited, arg1.total_locked_amount, arg1.total_unlocked_amount)
    }

    public fun get_claimable_epochs_for_lock(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : (vector<u64>, vector<u64>, u64) {
        let (v0, v1) = find_user_lock_any_pool_safe(arg0, arg1, arg2);
        if (!v0) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0)
        };
        let v2 = get_lock_table(arg0, v1);
        if (!0x2::table::contains<address, vector<Lock>>(v2, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0)
        };
        let v3 = 0x2::table::borrow<address, vector<Lock>>(v2, arg1);
        let v4 = 0x1::option::none<Lock>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<Lock>(v3)) {
            let v6 = 0x1::vector::borrow<Lock>(v3, v5);
            if (v6.id == arg2) {
                v4 = 0x1::option::some<Lock>(*v6);
                break
            };
            v5 = v5 + 1;
        };
        if (0x1::option::is_none<Lock>(&v4)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0)
        };
        let v7 = 0x1::option::extract<Lock>(&mut v4);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0;
        let v11 = v10;
        let v12 = get_current_epoch_id(arg0);
        if (v12 == 0) {
            return (v8, v9, v10)
        };
        let v13 = 1;
        let v14 = 0;
        let v15 = 999999;
        while (v14 < 200 && epoch_exists(arg0, v13)) {
            if (v7.stake_timestamp < get_epoch(arg0, v13).week_start_timestamp) {
                v15 = v13;
                break
            };
            v13 = v13 + 1;
            v14 = v14 + 1;
        };
        let v16 = if (v7.last_sui_epoch_claimed == 0) {
            1
        } else {
            v7.last_sui_epoch_claimed + 1
        };
        let v17 = if (v15 > v16) {
            v15
        } else {
            v16
        };
        if (v17 <= v12 && v17 != 999999) {
            let v18 = v17;
            let v19 = 0;
            while (v18 <= v12 && v19 < 200) {
                if (epoch_exists(arg0, v18)) {
                    let v20 = get_epoch(arg0, v18);
                    let v21 = if (v20.is_claimable) {
                        if (0x2::clock::timestamp_ms(arg3) / 1000 >= v20.week_end_timestamp) {
                            if (v7.stake_timestamp < v20.week_start_timestamp) {
                                if (v7.lock_end >= v20.week_end_timestamp) {
                                    !has_user_claimed_pool_epoch(arg0, arg1, v18, arg2)
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v21) {
                        let v22 = calculate_pool_based_sui_rewards_with_allocations(&v20.pool_allocations, &v7, v1);
                        if (v22 > 0) {
                            0x1::vector::push_back<u64>(&mut v8, v18);
                            0x1::vector::push_back<u64>(&mut v9, v22);
                            v11 = v11 + v22;
                        };
                    };
                };
                v18 = v18 + 1;
                v19 = v19 + 1;
            };
        };
        (v8, v9, v11)
    }

    public fun get_claimable_summary_for_user(arg0: &TokenLocker, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = get_all_user_locks(arg0, arg1);
        let v1 = 0x1::vector::length<Lock>(&v0);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v1) {
            let (v6, _, v8) = get_claimable_epochs_for_lock(arg0, arg1, 0x1::vector::borrow<Lock>(&v0, v5).id, arg2);
            let v9 = v6;
            if (v8 > 0) {
                v2 = v2 + 1;
                v3 = v3 + 0x1::vector::length<u64>(&v9);
                v4 = v4 + v8;
            };
            v5 = v5 + 1;
        };
        (v2, v3, v4)
    }

    fun get_current_epoch_id(arg0: &TokenLocker) : u64 {
        arg0.current_epoch_id
    }

    public fun get_current_epoch_info(arg0: &TokenLocker) : (u64, u64, u64, bool, bool) {
        let v0 = get_current_epoch_id(arg0);
        if (v0 == 0 || !epoch_exists(arg0, v0)) {
            return (0, 0, 0, false, false)
        };
        let v1 = get_epoch(arg0, v0);
        (v0, v1.week_start_timestamp, v1.week_end_timestamp, v1.is_claimable, v1.allocations_finalized)
    }

    public fun get_detailed_claim_record(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : (bool, u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1)) {
            return (false, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1);
        let v1 = create_claim_key(arg2, arg3);
        if (!0x2::table::contains<u128, PoolClaimRecord>(v0, v1)) {
            return (false, 0, 0, 0, 0, 0)
        };
        let v2 = 0x2::table::borrow<u128, PoolClaimRecord>(v0, v1);
        (true, v2.sui_claimed, v2.claim_timestamp, v2.lock_period, (v2.pool_type as u64), v2.amount_staked)
    }

    fun get_dynamic_victory_allocation(arg0: &TokenLocker, arg1: u64) : u64 {
        if (arg1 == 7) {
            arg0.victory_week_allocation
        } else if (arg1 == 90) {
            arg0.victory_three_month_allocation
        } else if (arg1 == 365) {
            arg0.victory_year_allocation
        } else {
            arg0.victory_three_year_allocation
        }
    }

    fun get_emission_end_timestamp(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig) : u64 {
        let (v0, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg0);
        v0 + get_emission_end_week() * 86400 * 7
    }

    fun get_emission_end_week() : u64 {
        let (_, _, _, v3) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_emission_phase_parameters();
        v3
    }

    public fun get_emission_status_for_locker(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, bool, bool, u64, u8) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let (v3, v4, _, _, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_emission_status(arg0, arg1);
        (v0, v1, v2, v3, v4)
    }

    fun get_epoch(arg0: &TokenLocker, arg1: u64) : &WeeklyRevenueEpoch {
        assert!(epoch_exists(arg0, arg1), 12);
        0x2::table::borrow<u64, WeeklyRevenueEpoch>(&arg0.weekly_epochs, arg1)
    }

    public fun get_epoch_for_timestamp(arg0: &TokenLocker, arg1: u64) : u64 {
        if (arg1 < arg0.protocol_start_timestamp) {
            return 0
        };
        let v0 = (arg1 - arg0.protocol_start_timestamp) / arg0.epoch_duration_seconds + 1;
        if (v0 > 156) {
            156
        } else {
            v0
        }
    }

    public fun get_epoch_full_details(arg0: &TokenLocker, arg1: u64) : (u64, u64, u64, u64, u64, u64, u64, u64, bool, bool) {
        if (!epoch_exists(arg0, arg1)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, false, false)
        };
        let v0 = get_epoch(arg0, arg1);
        (v0.total_sui_revenue, v0.week_start_timestamp, v0.week_end_timestamp, v0.pool_allocations.year_pool_sui, v0.pool_allocations.year_pool_total_staked, v0.year_pool_claimed, arg1, v0.pool_allocations.year_pool_allocation, v0.is_claimable, v0.allocations_finalized)
    }

    public fun get_epoch_info_safe(arg0: &TokenLocker, arg1: u64) : (u64, u64, u64, u64, u64, bool) {
        if (!epoch_exists(arg0, arg1)) {
            return (0, 0, 0, 0, 0, false)
        };
        let v0 = get_epoch(arg0, arg1);
        (v0.total_sui_revenue, v0.week_start_timestamp, v0.week_end_timestamp, v0.pool_allocations.week_pool_sui + v0.pool_allocations.three_month_pool_sui + v0.pool_allocations.year_pool_sui + v0.pool_allocations.three_year_pool_sui, v0.week_pool_claimed + v0.three_month_pool_claimed + v0.year_pool_claimed + v0.three_year_pool_claimed, v0.is_claimable)
    }

    fun get_epoch_mut(arg0: &mut TokenLocker, arg1: u64) : &mut WeeklyRevenueEpoch {
        assert!(epoch_exists(arg0, arg1), 12);
        0x2::table::borrow_mut<u64, WeeklyRevenueEpoch>(&mut arg0.weekly_epochs, arg1)
    }

    public fun get_epoch_status_for_user(arg0: &TokenLocker, arg1: u64, arg2: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        if (!epoch_exists(arg0, arg1)) {
            return (false, 0x1::string::utf8(b"Admin hasn't created this epoch yet"))
        };
        let v0 = get_epoch(arg0, arg1);
        if (0x2::clock::timestamp_ms(arg2) / 1000 < v0.week_end_timestamp) {
            return (false, 0x1::string::utf8(b"Week still in progress"))
        };
        if (!v0.allocations_finalized) {
            return (false, 0x1::string::utf8(b"Week ended, waiting for admin to add revenue"))
        };
        if (!v0.is_claimable) {
            return (false, 0x1::string::utf8(b"Revenue added but not yet claimable"))
        };
        (true, 0x1::string::utf8(b"Ready to claim!"))
    }

    public fun get_epoch_window_timing(arg0: &TokenLocker, arg1: u64) : (u64, u64) {
        calculate_epoch_window(arg0, arg1)
    }

    public fun get_lock_by_id(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64, u64, bool) {
        let v0 = if (arg3 == 7) {
            &arg0.week_locks
        } else if (arg3 == 90) {
            &arg0.three_month_locks
        } else if (arg3 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        };
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            return (0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lock>(v1)) {
            let v3 = 0x1::vector::borrow<Lock>(v1, v2);
            if (v3.id == arg2) {
                return (v3.amount, v3.lock_period, v3.lock_end, v3.stake_timestamp, v3.last_victory_claim_timestamp, v3.last_sui_epoch_claimed, true)
            };
            v2 = v2 + 1;
        };
        (0, 0, 0, 0, 0, 0, false)
    }

    public fun get_lock_by_index(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = if (arg3 == 7) {
            &arg0.week_locks
        } else if (arg3 == 90) {
            &arg0.three_month_locks
        } else if (arg3 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        };
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            return (0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        if (arg2 >= 0x1::vector::length<Lock>(v1)) {
            return (0, 0, 0, 0, 0, 0, 0, false)
        };
        let v2 = 0x1::vector::borrow<Lock>(v1, arg2);
        (v2.id, v2.amount, v2.lock_period, v2.lock_end, v2.stake_timestamp, v2.last_victory_claim_timestamp, v2.last_sui_epoch_claimed, true)
    }

    public fun get_lock_claim_history(arg0: &TokenLocker, arg1: address, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, u64, u64) {
        let (v0, _) = find_user_lock_any_pool_safe(arg0, arg1, arg2);
        if (!v0) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0)
        };
        let (v2, _) = find_user_lock_any_pool(arg0, arg1, arg2);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        let v8 = v7;
        if (!0x2::table::contains<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1)) {
            return (v4, v5, v6, v7, v2.last_sui_epoch_claimed)
        };
        let v9 = 0x2::table::borrow<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1);
        let v10 = get_current_epoch_id(arg0);
        let v11 = if (v10 > 200) {
            200
        } else {
            v10
        };
        let v12 = 1;
        while (v12 <= v11) {
            let v13 = create_claim_key(v12, arg2);
            if (0x2::table::contains<u128, PoolClaimRecord>(v9, v13)) {
                let v14 = 0x2::table::borrow<u128, PoolClaimRecord>(v9, v13);
                0x1::vector::push_back<u64>(&mut v4, v12);
                0x1::vector::push_back<u64>(&mut v5, v14.sui_claimed);
                0x1::vector::push_back<u64>(&mut v6, v14.claim_timestamp);
                v8 = v8 + v14.sui_claimed;
            };
            v12 = v12 + 1;
        };
        (v4, v5, v6, v8, v2.last_sui_epoch_claimed)
    }

    public fun get_lock_detailed_info(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : (bool, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, _) = find_user_lock_any_pool_safe(arg0, arg1, arg2);
        if (!v0) {
            return (false, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        };
        let (v2, _) = find_user_lock_any_pool(arg0, arg1, arg2);
        let (v4, _, _, _, _) = get_lock_claim_history(arg0, arg1, arg2);
        let v9 = v4;
        let (_, _, v12) = get_claimable_epochs_for_lock(arg0, arg1, arg2, arg3);
        (true, v2.amount, v2.lock_period, v2.lock_end, v2.stake_timestamp, v2.last_victory_claim_timestamp, v2.total_victory_claimed, v2.last_sui_epoch_claimed, 0x1::vector::length<u64>(&v9), v12)
    }

    public fun get_lock_end_by_index(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 7) {
            &arg0.week_locks
        } else if (arg3 == 90) {
            &arg0.three_month_locks
        } else if (arg3 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        };
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        if (arg2 >= 0x1::vector::length<Lock>(v1)) {
            return 0
        };
        0x1::vector::borrow<Lock>(v1, arg2).lock_end
    }

    fun get_lock_table(arg0: &TokenLocker, arg1: u64) : &0x2::table::Table<address, vector<Lock>> {
        if (arg1 == 7) {
            &arg0.week_locks
        } else if (arg1 == 90) {
            &arg0.three_month_locks
        } else if (arg1 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        }
    }

    fun get_lock_table_mut(arg0: &mut TokenLocker, arg1: u64) : &mut 0x2::table::Table<address, vector<Lock>> {
        if (arg1 == 7) {
            &mut arg0.week_locks
        } else if (arg1 == 90) {
            &mut arg0.three_month_locks
        } else if (arg1 == 365) {
            &mut arg0.year_locks
        } else {
            &mut arg0.three_year_locks
        }
    }

    public fun get_locked_vault_statistics(arg0: &LockedTokenVault) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.locked_balance), arg0.total_locked_amount, arg0.total_unlocked_amount, arg0.lock_count, arg0.unlock_count)
    }

    public fun get_pool_statistics(arg0: &TokenLocker) : (u64, u64, u64, u64, u64) {
        (arg0.week_total_locked, arg0.three_month_total_locked, arg0.year_total_locked, arg0.three_year_total_locked, get_total_locked(arg0))
    }

    fun get_pool_total_locked(arg0: &TokenLocker, arg1: u64) : u64 {
        if (arg1 == 7) {
            arg0.week_total_locked
        } else if (arg1 == 90) {
            arg0.three_month_total_locked
        } else if (arg1 == 365) {
            arg0.year_total_locked
        } else {
            arg0.three_year_total_locked
        }
    }

    fun get_pool_type_id(arg0: u64) : u8 {
        if (arg0 == 7) {
            0
        } else if (arg0 == 90) {
            1
        } else if (arg0 == 365) {
            2
        } else {
            3
        }
    }

    public fun get_presale_recommended_lock_period() : u64 {
        90
    }

    public fun get_projected_current_epoch_rewards(arg0: &TokenLocker, arg1: address) : (u64, u64, u64, u64, u64) {
        let v0 = get_current_epoch_id(arg0);
        if (v0 == 0 || !epoch_exists(arg0, v0)) {
            return (0, 0, 0, 0, 0)
        };
        let v1 = get_epoch(arg0, v0);
        let (v2, v3, v4, v5, _) = get_user_total_staked(arg0, arg1);
        let v7 = if (v1.pool_allocations.week_pool_total_staked > 0 && v2 > 0) {
            safe_mul_div(v2, v1.pool_allocations.week_pool_sui, v1.pool_allocations.week_pool_total_staked)
        } else {
            0
        };
        let v8 = if (v1.pool_allocations.three_month_pool_total_staked > 0 && v3 > 0) {
            safe_mul_div(v3, v1.pool_allocations.three_month_pool_sui, v1.pool_allocations.three_month_pool_total_staked)
        } else {
            0
        };
        let v9 = if (v1.pool_allocations.year_pool_total_staked > 0 && v4 > 0) {
            safe_mul_div(v4, v1.pool_allocations.year_pool_sui, v1.pool_allocations.year_pool_total_staked)
        } else {
            0
        };
        let v10 = if (v1.pool_allocations.three_year_pool_total_staked > 0 && v5 > 0) {
            safe_mul_div(v5, v1.pool_allocations.three_year_pool_sui, v1.pool_allocations.three_year_pool_total_staked)
        } else {
            0
        };
        (v7, v8, v9, v10, v7 + v8 + v9 + v10)
    }

    public fun get_protocol_schedule(arg0: &TokenLocker) : (u64, u64, u64, u64) {
        (arg0.protocol_start_timestamp, arg0.epoch_duration_seconds, arg0.current_epoch_id, 156)
    }

    public fun get_reward_vault_statistics(arg0: &VictoryRewardVault) : (u64, u64, u64) {
        (0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg0.victory_balance), arg0.total_deposited, arg0.total_distributed)
    }

    public fun get_sui_allocations(arg0: &TokenLocker) : (u64, u64, u64, u64, u64) {
        (arg0.sui_week_allocation, arg0.sui_three_month_allocation, arg0.sui_year_allocation, arg0.sui_three_year_allocation, arg0.sui_week_allocation + arg0.sui_three_month_allocation + arg0.sui_year_allocation + arg0.sui_three_year_allocation)
    }

    public fun get_sui_vault_statistics(arg0: &SUIRewardVault) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.total_deposited, arg0.total_distributed)
    }

    fun get_total_locked(arg0: &TokenLocker) : u64 {
        arg0.week_total_locked + arg0.three_month_total_locked + arg0.year_total_locked + arg0.three_year_total_locked
    }

    fun get_total_reward_tokens_from_vault(arg0: &VictoryRewardVault) : u64 {
        arg0.total_deposited
    }

    public fun get_user_claim_history(arg0: &TokenLocker, arg1: address, arg2: u64) : (bool, u64, u64) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, VictoryClaimRecord>>(&arg0.user_victory_claims, arg1)) {
            return (false, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, VictoryClaimRecord>>(&arg0.user_victory_claims, arg1);
        if (!0x2::table::contains<u64, VictoryClaimRecord>(v0, arg2)) {
            return (false, 0, 0)
        };
        let v1 = 0x2::table::borrow<u64, VictoryClaimRecord>(v0, arg2);
        (true, v1.total_claimed, v1.last_claim_timestamp)
    }

    public fun get_user_claim_matrix(arg0: &TokenLocker, arg1: address) : (vector<u64>, vector<u64>, vector<vector<bool>>) {
        let v0 = get_all_user_locks(arg0, arg1);
        let v1 = 0x1::vector::length<Lock>(&v0);
        if (v1 == 0) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<vector<bool>>())
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::borrow<Lock>(&v0, v3).id);
            v3 = v3 + 1;
        };
        let v4 = get_current_epoch_id(arg0);
        let v5 = if (v4 > 200) {
            200
        } else {
            v4
        };
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 1;
        while (v7 <= v5) {
            if (epoch_exists(arg0, v7)) {
                0x1::vector::push_back<u64>(&mut v6, v7);
            };
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<vector<bool>>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v6)) {
            let v10 = 0x1::vector::empty<bool>();
            let v11 = 0;
            while (v11 < v1) {
                0x1::vector::push_back<bool>(&mut v10, has_user_claimed_pool_epoch(arg0, arg1, *0x1::vector::borrow<u64>(&v6, v9), *0x1::vector::borrow<u64>(&v2, v11)));
                v11 = v11 + 1;
            };
            0x1::vector::push_back<vector<bool>>(&mut v8, v10);
            v9 = v9 + 1;
        };
        (v6, v2, v8)
    }

    public fun get_user_comprehensive_claim_summary(arg0: &TokenLocker, arg1: address) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64) {
        let v0 = get_all_user_locks(arg0, arg1);
        let v1 = 0x1::vector::length<Lock>(&v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        let v7 = v6;
        let v8 = 0;
        let v9 = v8;
        if (v1 == 0) {
            return (v2, v3, v4, v5, v6, v8)
        };
        let v10 = 0;
        while (v10 < v1) {
            let v11 = 0x1::vector::borrow<Lock>(&v0, v10);
            let v12 = v11.id;
            let (v13, _, _, v16, _) = get_lock_claim_history(arg0, arg1, v12);
            let v18 = v13;
            let v19 = 0x1::vector::length<u64>(&v18);
            0x1::vector::push_back<u64>(&mut v2, v12);
            0x1::vector::push_back<u64>(&mut v3, v11.lock_period);
            0x1::vector::push_back<u64>(&mut v4, v19);
            0x1::vector::push_back<u64>(&mut v5, v16);
            v7 = v7 + v19;
            v9 = v9 + v16;
            v10 = v10 + 1;
        };
        (v2, v3, v4, v5, v7, v9)
    }

    public fun get_user_dashboard_data(arg0: &TokenLocker, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let (_, _, v2, _, v4, v5) = get_user_comprehensive_claim_summary(arg0, arg1);
        let v6 = v2;
        let (v7, v8, v9) = get_claimable_summary_for_user(arg0, arg1, arg2);
        let (_, _, _, _, v14) = get_user_total_staked(arg0, arg1);
        let v15 = get_user_locks_for_period(arg0, arg1, 7);
        let v16 = get_user_locks_for_period(arg0, arg1, 90);
        let v17 = get_user_locks_for_period(arg0, arg1, 365);
        let v18 = get_user_locks_for_period(arg0, arg1, 1095);
        (0x1::vector::length<u64>(&v6), v4, v5, v7, v8, v9, 0x1::vector::length<Lock>(&v15), 0x1::vector::length<Lock>(&v16), 0x1::vector::length<Lock>(&v17), 0x1::vector::length<Lock>(&v18), v14)
    }

    public fun get_user_epoch_breakdown(arg0: &TokenLocker, arg1: address) : (vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        if (!0x2::table::contains<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1)) {
            return (v1, v0, v2)
        };
        let v3 = 0x2::table::borrow<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1);
        let v4 = get_current_epoch_id(arg0);
        let v5 = if (v4 > 200) {
            200
        } else {
            v4
        };
        let v6 = 1;
        while (v6 <= v5) {
            let v7 = 0;
            let v8 = 0;
            let v9 = get_all_user_locks(arg0, arg1);
            let v10 = 0;
            while (v10 < 0x1::vector::length<Lock>(&v9)) {
                let v11 = create_claim_key(v6, 0x1::vector::borrow<Lock>(&v9, v10).id);
                if (0x2::table::contains<u128, PoolClaimRecord>(v3, v11)) {
                    v7 = v7 + 0x2::table::borrow<u128, PoolClaimRecord>(v3, v11).sui_claimed;
                    v8 = v8 + 1;
                };
                v10 = v10 + 1;
            };
            if (v7 > 0) {
                0x1::vector::push_back<u64>(&mut v1, v6);
                0x1::vector::push_back<u64>(&mut v0, v7);
                0x1::vector::push_back<u64>(&mut v2, v8);
            };
            v6 = v6 + 1;
        };
        (v1, v0, v2)
    }

    public fun get_user_lock_details(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64) {
        let v0 = if (arg2 == 7) {
            &arg0.week_locks
        } else if (arg2 == 90) {
            &arg0.three_month_locks
        } else if (arg2 == 365) {
            &arg0.year_locks
        } else {
            &arg0.three_year_locks
        };
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        if (arg3 >= 0x1::vector::length<Lock>(v1)) {
            return (0, 0, 0, 0, 0)
        };
        let v2 = 0x1::vector::borrow<Lock>(v1, arg3);
        (v2.amount, v2.lock_period, v2.id, v2.lock_end, v2.stake_timestamp)
    }

    public fun get_user_lock_ids_by_period(arg0: &TokenLocker, arg1: address, arg2: u64) : vector<u64> {
        let v0 = get_user_locks_for_period(arg0, arg1, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lock>(&v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Lock>(&v0, v2).id);
            v2 = v2 + 1;
        };
        v1
    }

    fun get_user_lock_mut(arg0: &mut TokenLocker, arg1: address, arg2: u64, arg3: u64) : &mut Lock {
        let v0 = get_lock_table_mut(arg0, arg3);
        assert!(0x2::table::contains<address, vector<Lock>>(v0, arg1), 4);
        let v1 = 0x2::table::borrow_mut<address, vector<Lock>>(v0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lock>(v1)) {
            let v3 = 0x1::vector::borrow_mut<Lock>(v1, v2);
            if (v3.id == arg2) {
                return v3
            };
            v2 = v2 + 1;
        };
        abort 4
    }

    public fun get_user_locks_for_period(arg0: &TokenLocker, arg1: address, arg2: u64) : vector<Lock> {
        let v0 = get_lock_table(arg0, arg2);
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            0x1::vector::empty<Lock>()
        } else {
            *0x2::table::borrow<address, vector<Lock>>(v0, arg1)
        }
    }

    fun get_user_period_total(arg0: &TokenLocker, arg1: address, arg2: u64) : u64 {
        let v0 = get_lock_table(arg0, arg2);
        if (!0x2::table::contains<address, vector<Lock>>(v0, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow<address, vector<Lock>>(v0, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Lock>(v1)) {
            v2 = v2 + 0x1::vector::borrow<Lock>(v1, v3).amount;
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_user_pool_positions(arg0: &TokenLocker, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, _) = get_user_total_staked(arg0, arg1);
        let (v5, v6, v7, v8, _) = get_pool_statistics(arg0);
        (v0, v5, v1, v6, v2, v7, v3, v8)
    }

    public fun get_user_total_staked(arg0: &TokenLocker, arg1: address) : (u64, u64, u64, u64, u64) {
        let v0 = get_user_period_total(arg0, arg1, 7);
        let v1 = get_user_period_total(arg0, arg1, 90);
        let v2 = get_user_period_total(arg0, arg1, 365);
        let v3 = get_user_period_total(arg0, arg1, 1095);
        (v0, v1, v2, v3, v0 + v1 + v2 + v3)
    }

    public fun get_user_victory_position_details(arg0: &TokenLocker, arg1: address, arg2: u64) : (u64, u64, u64, u64, u256, u64, u64, bool) {
        if (!has_victory_position(arg0, arg1, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, false)
        };
        let v0 = get_victory_position(arg0, arg1, arg2);
        (v0.stake_amount, v0.lock_start_time, v0.lock_end_time, v0.lock_period, v0.victory_reward_debt, v0.total_victory_claimed, v0.last_victory_claim_time, v0.is_active)
    }

    fun get_victory_accumulator(arg0: &TokenLocker, arg1: u64) : &VictoryPoolAccumulator {
        if (arg1 == 7) {
            &arg0.victory_week_accumulator
        } else if (arg1 == 90) {
            &arg0.victory_three_month_accumulator
        } else if (arg1 == 365) {
            &arg0.victory_year_accumulator
        } else {
            &arg0.victory_three_year_accumulator
        }
    }

    fun get_victory_accumulator_mut(arg0: &mut TokenLocker, arg1: u64) : &mut VictoryPoolAccumulator {
        if (arg1 == 7) {
            &mut arg0.victory_week_accumulator
        } else if (arg1 == 90) {
            &mut arg0.victory_three_month_accumulator
        } else if (arg1 == 365) {
            &mut arg0.victory_year_accumulator
        } else {
            &mut arg0.victory_three_year_accumulator
        }
    }

    public fun get_victory_accumulator_stats(arg0: &TokenLocker, arg1: u64) : (u256, u64, u64, u64) {
        let v0 = get_victory_accumulator(arg0, arg1);
        (v0.acc_victory_per_share, v0.last_reward_time, v0.total_staked, v0.total_victory_distributed)
    }

    fun get_victory_allocation_for_emission_week_precise(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: u64) : u256 {
        if (arg1 == 0 || arg1 > 156) {
            return 0
        };
        0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_victory_allocation_for_week(arg0, arg1)
    }

    fun get_victory_allocation_safe(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u256 {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let v3 = if (!v0) {
            true
        } else if (!v1) {
            true
        } else {
            v2
        };
        if (v3) {
            return 0
        };
        0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_victory_allocation(arg0, arg1)
    }

    public fun get_victory_allocation_with_status(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, bool, 0x1::string::String) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let v3 = if (!v0) {
            0x1::string::utf8(b"Not initialized")
        } else if (!v1) {
            0x1::string::utf8(b"Ended")
        } else if (v2) {
            0x1::string::utf8(b"Paused")
        } else {
            0x1::string::utf8(b"Active")
        };
        let v4 = if (v0) {
            if (v1) {
                !v2
            } else {
                false
            }
        } else {
            false
        };
        (get_victory_allocation_safe(arg0, arg1), v4, v3)
    }

    public fun get_victory_allocations(arg0: &TokenLocker) : (u64, u64, u64, u64, u64) {
        (arg0.victory_week_allocation, arg0.victory_three_month_allocation, arg0.victory_year_allocation, arg0.victory_three_year_allocation, arg0.victory_week_allocation + arg0.victory_three_month_allocation + arg0.victory_year_allocation + arg0.victory_three_year_allocation)
    }

    fun get_victory_position(arg0: &TokenLocker, arg1: address, arg2: u64) : &VictoryUserPosition {
        0x2::table::borrow<u64, VictoryUserPosition>(0x2::table::borrow<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1), arg2)
    }

    fun get_victory_position_mut(arg0: &mut TokenLocker, arg1: address, arg2: u64) : &mut VictoryUserPosition {
        0x2::table::borrow_mut<u64, VictoryUserPosition>(0x2::table::borrow_mut<address, 0x2::table::Table<u64, VictoryUserPosition>>(&mut arg0.victory_user_positions, arg1), arg2)
    }

    public fun get_weekly_epoch_info(arg0: &TokenLocker, arg1: u64) : (u64, u64, u64, u64, u64, bool) {
        if (!epoch_exists(arg0, arg1)) {
            return (0, 0, 0, 0, 0, false)
        };
        let v0 = get_epoch(arg0, arg1);
        (v0.total_sui_revenue, v0.week_start_timestamp, v0.week_end_timestamp, v0.pool_allocations.week_pool_sui + v0.pool_allocations.three_month_pool_sui + v0.pool_allocations.year_pool_sui + v0.pool_allocations.three_year_pool_sui, v0.week_pool_claimed + v0.three_month_pool_claimed + v0.year_pool_claimed + v0.three_year_pool_claimed, v0.is_claimable)
    }

    fun has_user_claimed_pool_epoch(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: u64) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1)) {
            return false
        };
        0x2::table::contains<u128, PoolClaimRecord>(0x2::table::borrow<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1), create_claim_key(arg2, arg3))
    }

    fun has_victory_position(arg0: &TokenLocker, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1)) {
            return false
        };
        0x2::table::contains<u64, VictoryUserPosition>(0x2::table::borrow<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VictoryPoolAccumulator{
            acc_victory_per_share     : 0,
            last_reward_time          : 0,
            total_staked              : 0,
            total_victory_distributed : 0,
            lock_period               : 7,
        };
        let v2 = VictoryPoolAccumulator{
            acc_victory_per_share     : 0,
            last_reward_time          : 0,
            total_staked              : 0,
            total_victory_distributed : 0,
            lock_period               : 90,
        };
        let v3 = VictoryPoolAccumulator{
            acc_victory_per_share     : 0,
            last_reward_time          : 0,
            total_staked              : 0,
            total_victory_distributed : 0,
            lock_period               : 365,
        };
        let v4 = VictoryPoolAccumulator{
            acc_victory_per_share     : 0,
            last_reward_time          : 0,
            total_staked              : 0,
            total_victory_distributed : 0,
            lock_period               : 1095,
        };
        let v5 = TokenLocker{
            id                              : 0x2::object::new(arg0),
            protocol_start_timestamp        : 0,
            epoch_duration_seconds          : 0,
            week_locks                      : 0x2::table::new<address, vector<Lock>>(arg0),
            three_month_locks               : 0x2::table::new<address, vector<Lock>>(arg0),
            year_locks                      : 0x2::table::new<address, vector<Lock>>(arg0),
            three_year_locks                : 0x2::table::new<address, vector<Lock>>(arg0),
            lock_period_map                 : 0x2::table::new<u64, u64>(arg0),
            week_total_locked               : 0,
            three_month_total_locked        : 0,
            year_total_locked               : 0,
            three_year_total_locked         : 0,
            victory_week_allocation         : 200,
            victory_three_month_allocation  : 800,
            victory_year_allocation         : 2500,
            victory_three_year_allocation   : 6500,
            sui_week_allocation             : 0,
            sui_three_month_allocation      : 3000,
            sui_year_allocation             : 3500,
            sui_three_year_allocation       : 3500,
            weekly_epochs                   : 0x2::table::new<u64, WeeklyRevenueEpoch>(arg0),
            current_epoch_id                : 0,
            user_epoch_claims               : 0x2::table::new<address, 0x2::table::Table<u128, PoolClaimRecord>>(arg0),
            user_victory_claims             : 0x2::table::new<address, 0x2::table::Table<u64, VictoryClaimRecord>>(arg0),
            next_lock_id                    : 0,
            victory_week_accumulator        : v1,
            victory_three_month_accumulator : v2,
            victory_year_accumulator        : v3,
            victory_three_year_accumulator  : v4,
            victory_user_positions          : 0x2::table::new<address, 0x2::table::Table<u64, VictoryUserPosition>>(arg0),
        };
        0x2::transfer::share_object<TokenLocker>(v5);
    }

    public entry fun initialize_protocol_timing(arg0: &mut TokenLocker, arg1: u64, arg2: u64, arg3: &AdminCap, arg4: &0x2::clock::Clock) {
        assert!(arg0.protocol_start_timestamp == 0, 29);
        assert!(arg1 > 0, 28);
        assert!(arg2 > 0, 28);
        arg0.protocol_start_timestamp = arg1;
        arg0.epoch_duration_seconds = arg2;
        let v0 = ProtocolTimingInitialized{
            protocol_start : arg1,
            epoch_duration : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<ProtocolTimingInitialized>(v0);
    }

    public entry fun lock_tokens(arg0: &mut TokenLocker, arg1: &mut LockedTokenVault, arg2: 0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>, arg3: u64, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2);
        assert!(v0 > 0, 3);
        validate_new_lock_allowed(arg4, arg5);
        assert!(v0 <= 100000000000000, 35);
        let v1 = if (arg3 == 7) {
            1000000
        } else if (arg3 == 90) {
            5000000
        } else if (arg3 == 365) {
            10000000
        } else {
            25000000
        };
        assert!(v0 >= v1, 33);
        let v2 = if (arg3 == 7) {
            true
        } else if (arg3 == 90) {
            true
        } else if (arg3 == 365) {
            true
        } else {
            arg3 == 1095
        };
        assert!(v2, 8);
        let v3 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = arg0.next_lock_id;
        let (v6, v7, v8) = validate_emission_state(arg4, arg5);
        assert!(v6, 22);
        assert!(v7, 23);
        assert!(!v8, 24);
        let v9 = calculate_intelligent_lock_end(arg4, v3, arg3);
        let v10 = Lock{
            id                           : v5,
            amount                       : v0,
            lock_period                  : arg3,
            lock_end                     : v9,
            stake_timestamp              : v3,
            last_victory_claim_timestamp : v3,
            total_victory_claimed        : 0,
            last_sui_epoch_claimed       : 0,
            claimed_sui_epochs           : 0x1::vector::empty<u64>(),
        };
        add_lock_to_pool(arg0, v4, v10, arg3, arg6);
        update_pool_totals(arg0, arg3, v0, true);
        arg0.next_lock_id = arg0.next_lock_id + 1;
        0x2::balance::join<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg1.locked_balance, 0x2::coin::into_balance<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(arg2));
        arg1.total_locked_amount = arg1.total_locked_amount + v0;
        arg1.lock_count = arg1.lock_count + 1;
        create_victory_position(arg0, v4, v5, v0, arg3, v9, v3, arg4, arg5, arg6);
        let v11 = TokensLocked{
            user        : v4,
            lock_id     : v5,
            amount      : v0,
            lock_period : arg3,
            lock_end    : v9,
        };
        0x2::event::emit<TokensLocked>(v11);
    }

    fun mark_pool_epoch_claimed(arg0: &mut TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<u128, PoolClaimRecord>>(&arg0.user_epoch_claims, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u128, PoolClaimRecord>>(&mut arg0.user_epoch_claims, arg1, 0x2::table::new<u128, PoolClaimRecord>(arg7));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u128, PoolClaimRecord>>(&mut arg0.user_epoch_claims, arg1);
        let v1 = create_claim_key(arg2, arg3);
        assert!(!0x2::table::contains<u128, PoolClaimRecord>(v0, v1), 9);
        let v2 = PoolClaimRecord{
            epoch_id        : arg2,
            lock_id         : arg3,
            lock_period     : arg4,
            pool_type       : get_pool_type_id(arg4),
            amount_staked   : arg5,
            sui_claimed     : arg5,
            claim_timestamp : arg6,
        };
        0x2::table::add<u128, PoolClaimRecord>(v0, v1, v2);
    }

    public fun preview_claim_for_all_user_locks(arg0: &TokenLocker, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>) {
        let (v0, v1, v2) = get_claimable_summary_for_user(arg0, arg1, arg2);
        if (v0 == 0) {
            return (false, 0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v3 = get_all_user_locks(arg0, arg1);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<Lock>(&v3)) {
            let v8 = 0x1::vector::borrow<Lock>(&v3, v7).id;
            let (_, _, v11) = get_claimable_epochs_for_lock(arg0, arg1, v8, arg2);
            if (v11 > 0) {
                let (v12, _, _) = get_claimable_epochs_for_lock(arg0, arg1, v8, arg2);
                let v15 = v12;
                0x1::vector::push_back<u64>(&mut v4, v8);
                0x1::vector::push_back<u64>(&mut v5, 0x1::vector::length<u64>(&v15));
                0x1::vector::push_back<u64>(&mut v6, v11);
            };
            v7 = v7 + 1;
        };
        (true, v0, v1, v2, v4, v5, v6)
    }

    public fun preview_claim_for_lock(arg0: &TokenLocker, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : (bool, u64, u64, u64, vector<u64>, vector<u64>) {
        let (v0, _) = find_user_lock_any_pool_safe(arg0, arg1, arg2);
        if (!v0) {
            return (false, 0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let (v2, _) = find_user_lock_any_pool(arg0, arg1, arg2);
        let (v4, v5, v6) = get_claimable_epochs_for_lock(arg0, arg1, arg2, arg3);
        let v7 = v4;
        let v8 = 0x1::vector::length<u64>(&v7);
        let v9 = v8 > 0 && v6 > 0;
        (v9, v8, v6, v2.amount, v7, v5)
    }

    fun remove_lock_from_pool(arg0: &mut TokenLocker, arg1: address, arg2: u64, arg3: u64) {
        let v0 = get_lock_table_mut(arg0, arg3);
        let v1 = 0x2::table::borrow_mut<address, vector<Lock>>(v0, arg1);
        0x1::vector::remove<Lock>(v1, arg2);
        if (0x1::vector::is_empty<Lock>(v1)) {
            0x2::table::remove<address, vector<Lock>>(v0, arg1);
        };
        0x2::table::remove<u64, u64>(&mut arg0.lock_period_map, 0x1::vector::borrow<Lock>(v1, arg2).id);
    }

    fun remove_victory_position(arg0: &mut TokenLocker, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u64, VictoryUserPosition>>(&arg0.victory_user_positions, arg1);
        if (!0x2::table::contains<u64, VictoryUserPosition>(v0, arg2)) {
            return
        };
        let v1 = 0x2::table::borrow<u64, VictoryUserPosition>(v0, arg2);
        let v2 = v1.stake_amount;
        let v3 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, VictoryUserPosition>>(&mut arg0.victory_user_positions, arg1);
        0x2::table::remove<u64, VictoryUserPosition>(v3, arg2);
        if (0x2::table::is_empty<u64, VictoryUserPosition>(v3)) {
            0x2::table::destroy_empty<u64, VictoryUserPosition>(0x2::table::remove<address, 0x2::table::Table<u64, VictoryUserPosition>>(&mut arg0.victory_user_positions, arg1));
        };
        let v4 = get_victory_accumulator_mut(arg0, v1.lock_period);
        if (v4.total_staked >= v2) {
            v4.total_staked = v4.total_staked - v2;
        };
    }

    fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun safe_mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0) {
            return 0
        };
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 * arg1 / arg2
    }

    fun safe_percentage_checked(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 42);
        safe_mul_div(arg0, arg1, 10000)
    }

    fun simulate_accumulator_update(arg0: &VictoryPoolAccumulator, arg1: &TokenLocker, arg2: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg3: u64) : u256 {
        if (arg0.total_staked == 0) {
            return arg0.acc_victory_per_share
        };
        let (v0, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg2);
        let v2 = get_emission_end_timestamp(arg2);
        let v3 = if (arg3 > v2) {
            v2
        } else {
            arg3
        };
        let v4 = if (v0 > 0 && arg0.last_reward_time < v0) {
            v0
        } else {
            arg0.last_reward_time
        };
        if (v0 > 0 && v3 < v0) {
            return arg0.acc_victory_per_share
        };
        if (v3 <= v4) {
            return arg0.acc_victory_per_share
        };
        arg0.acc_victory_per_share + safe_mul_div_u256(calculate_period_rewards_multi_week(arg2, get_dynamic_victory_allocation(arg1, arg0.lock_period), v4, v3), 1000000000000000000, (arg0.total_staked as u256))
    }

    public entry fun unlock_tokens(arg0: &mut TokenLocker, arg1: &mut LockedTokenVault, arg2: &mut VictoryRewardVault, arg3: &mut SUIRewardVault, arg4: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        validate_unlock_allowed(arg4, arg7);
        let (v2, v3) = find_and_prepare_unlock(arg0, v0, arg5, arg6, v1, arg4);
        let v4 = v2;
        assert!(check_unlock_balance(arg1, v4.amount), 25);
        let (v5, _, v7) = validate_emission_state(arg4, arg7);
        let v8 = get_emission_end_timestamp(arg4);
        let v9 = v4.lock_end;
        let v10 = v1;
        if (v1 > v8) {
            v10 = v8;
        };
        if (v10 > v9) {
            v10 = v9;
        };
        let v11 = if (has_victory_position(arg0, v0, v4.id)) {
            if (v5 && !v7) {
                update_victory_accumulator_for_period(arg0, arg6, arg4, arg7, v10);
            };
            let v12 = calculate_pending_victory_rewards_at_time(arg0, v0, v4.id, arg6, arg4, v10);
            remove_victory_position(arg0, v0, v4.id);
            v12
        } else {
            0
        };
        remove_lock_from_pool(arg0, v0, v3, arg6);
        update_pool_totals(arg0, arg6, v4.amount, false);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>>(0x2::coin::take<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&mut arg1.locked_balance, v4.amount, arg8), v0);
        arg1.total_unlocked_amount = arg1.total_unlocked_amount + v4.amount;
        arg1.unlock_count = arg1.unlock_count + 1;
        arg1.total_locked_amount = arg1.total_locked_amount - v4.amount;
        let v13 = if (v11 > 0) {
            let v14 = 0x2::balance::value<0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::victory_token::VICTORY_TOKEN>(&arg2.victory_balance);
            let v15 = if (v11 > v14) {
                v14
            } else {
                v11
            };
            if (v15 > 0) {
                distribute_victory_from_vault(arg2, v15, v0, arg8);
            };
            v15
        } else {
            0
        };
        let v16 = TokensUnlocked{
            user            : v0,
            lock_id         : v4.id,
            amount          : v4.amount,
            victory_rewards : v13,
            sui_rewards     : 0,
            timestamp       : v1,
        };
        0x2::event::emit<TokensUnlocked>(v16);
    }

    fun update_epoch_pool_claimed(arg0: &mut TokenLocker, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = get_epoch_mut(arg0, arg1);
        if (arg2 == 7) {
            assert!(arg3 <= v0.pool_allocations.week_pool_sui - v0.week_pool_claimed, 26);
            v0.week_pool_claimed = v0.week_pool_claimed + arg3;
        } else if (arg2 == 90) {
            assert!(arg3 <= v0.pool_allocations.three_month_pool_sui - v0.three_month_pool_claimed, 26);
            v0.three_month_pool_claimed = v0.three_month_pool_claimed + arg3;
        } else if (arg2 == 365) {
            assert!(arg3 <= v0.pool_allocations.year_pool_sui - v0.year_pool_claimed, 26);
            v0.year_pool_claimed = v0.year_pool_claimed + arg3;
        } else {
            assert!(arg3 <= v0.pool_allocations.three_year_pool_sui - v0.three_year_pool_claimed, 26);
            v0.three_year_pool_claimed = v0.three_year_pool_claimed + arg3;
        };
    }

    fun update_global_victory_claim_record(arg0: &mut TokenLocker, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, VictoryClaimRecord>>(&arg0.user_victory_claims, arg1)) {
            0x2::table::add<address, 0x2::table::Table<u64, VictoryClaimRecord>>(&mut arg0.user_victory_claims, arg1, 0x2::table::new<u64, VictoryClaimRecord>(arg5));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, VictoryClaimRecord>>(&mut arg0.user_victory_claims, arg1);
        if (!0x2::table::contains<u64, VictoryClaimRecord>(v0, arg2)) {
            let v1 = VictoryClaimRecord{
                lock_id              : arg2,
                last_claim_timestamp : arg4,
                total_claimed        : arg3,
                last_claim_amount    : arg3,
            };
            0x2::table::add<u64, VictoryClaimRecord>(v0, arg2, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<u64, VictoryClaimRecord>(v0, arg2);
            v2.last_claim_timestamp = arg4;
            v2.total_claimed = v2.total_claimed + arg3;
            v2.last_claim_amount = arg3;
        };
    }

    fun update_pool_totals(arg0: &mut TokenLocker, arg1: u64, arg2: u64, arg3: bool) {
        if (arg1 == 7) {
            if (arg3) {
                arg0.week_total_locked = arg0.week_total_locked + arg2;
            } else {
                arg0.week_total_locked = arg0.week_total_locked - arg2;
            };
        } else if (arg1 == 90) {
            if (arg3) {
                arg0.three_month_total_locked = arg0.three_month_total_locked + arg2;
            } else {
                arg0.three_month_total_locked = arg0.three_month_total_locked - arg2;
            };
        } else if (arg1 == 365) {
            if (arg3) {
                arg0.year_total_locked = arg0.year_total_locked + arg2;
            } else {
                arg0.year_total_locked = arg0.year_total_locked - arg2;
            };
        } else if (arg3) {
            arg0.three_year_total_locked = arg0.three_year_total_locked + arg2;
        } else {
            arg0.three_year_total_locked = arg0.three_year_total_locked - arg2;
        };
    }

    fun update_victory_accumulator_for_period(arg0: &mut TokenLocker, arg1: u64, arg2: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg3: &0x2::clock::Clock, arg4: u64) {
        let v0 = get_dynamic_victory_allocation(arg0, arg1);
        let v1 = get_victory_accumulator_mut(arg0, arg1);
        let (v2, _) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg2);
        let v4 = get_emission_end_timestamp(arg2);
        let v5 = if (arg4 > v4) {
            v4
        } else {
            arg4
        };
        if (v1.total_staked == 0) {
            v1.last_reward_time = v5;
            return
        };
        let v6 = if (v2 > 0 && v1.last_reward_time < v2) {
            v2
        } else {
            v1.last_reward_time
        };
        if (v2 > 0 && v5 < v2) {
            v1.last_reward_time = v5;
            return
        };
        if (v5 <= v6) {
            let v7 = if (v2 > 0) {
                if (v1.last_reward_time < v2) {
                    v5 >= v2
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                v1.last_reward_time = v2;
            };
            return
        };
        let v8 = calculate_period_rewards_multi_week(arg2, v0, v6, v5);
        v1.acc_victory_per_share = v1.acc_victory_per_share + safe_mul_div_u256(v8, 1000000000000000000, (v1.total_staked as u256));
        v1.last_reward_time = v5;
        if (v8 <= 18446744073709551615) {
            v1.total_victory_distributed = v1.total_victory_distributed + (v8 as u64);
        };
    }

    public fun user_has_locks(arg0: &TokenLocker, arg1: address) : bool {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 7);
        0x1::vector::push_back<u64>(v1, 90);
        0x1::vector::push_back<u64>(v1, 365);
        0x1::vector::push_back<u64>(v1, 1095);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            let v4 = if (v3 == 7) {
                &arg0.week_locks
            } else if (v3 == 90) {
                &arg0.three_month_locks
            } else if (v3 == 365) {
                &arg0.year_locks
            } else {
                &arg0.three_year_locks
            };
            if (0x2::table::contains<address, vector<Lock>>(v4, arg1)) {
                if (!0x1::vector::is_empty<Lock>(0x2::table::borrow<address, vector<Lock>>(v4, arg1))) {
                    return true
                };
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun validate_all_allocations(arg0: &TokenLocker) : (bool, bool, 0x1::string::String) {
        let v0 = arg0.victory_week_allocation + arg0.victory_three_month_allocation + arg0.victory_year_allocation + arg0.victory_three_year_allocation == 10000;
        let v1 = arg0.sui_week_allocation + arg0.sui_three_month_allocation + arg0.sui_year_allocation + arg0.sui_three_year_allocation == 10000;
        let v2 = if (v0 && v1) {
            0x1::string::utf8(b"All allocations valid (100% each)")
        } else if (!v0 && !v1) {
            0x1::string::utf8(b"Both Victory and SUI allocations invalid")
        } else if (!v0) {
            0x1::string::utf8(b"Victory allocations invalid")
        } else {
            0x1::string::utf8(b"SUI allocations invalid")
        };
        (v0, v1, v2)
    }

    fun validate_claim_allowed(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, _, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 22);
        assert!(!v2, 24);
    }

    fun validate_emission_state(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, bool, bool) {
        let (v0, v1) = 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::get_config_info(arg0);
        (v0 > 0, 0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::is_emissions_active(arg0, arg1), v1)
    }

    fun validate_full_week_staking_with_timestamps(arg0: &Lock, arg1: u64, arg2: u64) {
        assert!(arg0.lock_end >= arg2, 14);
        assert!(arg0.stake_timestamp < arg1, 15);
    }

    fun validate_new_lock_allowed(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 22);
        assert!(v1, 23);
        assert!(!v2, 24);
    }

    fun validate_unlock_allowed(arg0: &0x7535d5548012a8c43cfbcffe04658939f129ee3ce74b5ca104e75e22bb523733::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, _, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 22);
        assert!(!v2, 24);
    }

    // decompiled from Move bytecode v6
}

