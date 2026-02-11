module 0x302a07fee2847fd203aaaac779b7a5a9454a028b515f288fc27a5fe83cce11f9::cycling_vault {
    struct VaultConfig has key {
        id: 0x2::object::UID,
        executor: address,
        admin: address,
        total_vaults: u64,
        total_cycles_executed: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        fees_x: 0x2::balance::Balance<T0>,
        fees_y: 0x2::balance::Balance<T1>,
        rewards_collected: 0x2::table::Table<0x1::string::String, u64>,
        initial_deposit_x: u64,
        initial_deposit_y: u64,
        total_fees_earned_x: u64,
        total_fees_earned_y: u64,
        total_rewards_earned: 0x2::table::Table<0x1::string::String, u64>,
        created_at: u64,
        position_opened_at: u64,
        range_bps: u64,
        timer_duration_ms: u64,
        next_execution_at: u64,
        max_cycles: u64,
        cycles_completed: u64,
        is_active: bool,
        has_position: bool,
        auto_rebalance: bool,
        use_zap: bool,
        auto_compound: bool,
        rebalance_delay_ms: u64,
        out_of_range_since: u64,
        rebalance_pending: bool,
        rebalance_count: u64,
        fee_recipient: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
        pool_id: 0x2::object::ID,
        range_bps: u64,
        timer_duration_ms: u64,
        max_cycles: u64,
    }

    struct VaultDeposit has copy, drop {
        vault_id: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct CycleExecuted has copy, drop {
        vault_id: address,
        cycle_number: u64,
        removed_x: u64,
        removed_y: u64,
        fees_x: u64,
        fees_y: u64,
    }

    struct PositionOpened has copy, drop {
        vault_id: address,
        position_id: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: address,
        owner: address,
        total_x: u64,
        total_y: u64,
    }

    struct VaultPaused has copy, drop {
        vault_id: address,
    }

    struct VaultResumed has copy, drop {
        vault_id: address,
        next_execution_at: u64,
    }

    struct FeesCompounded has copy, drop {
        vault_id: address,
        compounded_x: u64,
        compounded_y: u64,
    }

    struct LeftoverDeposited has copy, drop {
        vault_id: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct RewardsCollected has copy, drop {
        vault_id: address,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct OutOfRangeDetected has copy, drop {
        vault_id: address,
        detected_at: u64,
        rebalance_at: u64,
    }

    struct RebalanceDelayCleared has copy, drop {
        vault_id: address,
        reason: vector<u8>,
    }

    struct RebalanceExecuted has copy, drop {
        vault_id: address,
        rebalance_count: u64,
        used_zap: bool,
        amount_in: u64,
        amount_out: u64,
        swap_x_to_y: bool,
    }

    struct RebalanceSettingsUpdated has copy, drop {
        vault_id: address,
        auto_rebalance: bool,
        use_zap: bool,
        auto_compound: bool,
        rebalance_delay_ms: u64,
    }

    struct FeeRecipientUpdated has copy, drop {
        vault_id: address,
        old_recipient: address,
        new_recipient: address,
    }

    struct FeesWithdrawn has copy, drop {
        vault_id: address,
        recipient: address,
        amount_x: u64,
        amount_y: u64,
    }

    public fun auto_compound<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.auto_compound
    }

    public fun auto_rebalance<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.auto_rebalance
    }

    public fun can_rebalance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active || !arg0.auto_rebalance) {
            return false
        };
        if (!arg0.rebalance_pending) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.out_of_range_since + arg0.rebalance_delay_ms
    }

    public entry fun clear_out_of_range<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        if (arg1.rebalance_pending) {
            arg1.rebalance_pending = false;
            arg1.out_of_range_since = 0;
            let v1 = RebalanceDelayCleared{
                vault_id : 0x2::object::id_address<Vault<T0, T1>>(arg1),
                reason   : b"price_returned",
            };
            0x2::event::emit<RebalanceDelayCleared>(v1);
        };
    }

    public fun compound_fees<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        let v1 = 0x2::balance::value<T0>(&arg1.fees_x);
        let v2 = 0x2::balance::value<T1>(&arg1.fees_y);
        if (v1 > 0 || v2 > 0) {
            0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::balance::withdraw_all<T0>(&mut arg1.fees_x));
            0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::balance::withdraw_all<T1>(&mut arg1.fees_y));
            let v3 = FeesCompounded{
                vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg1),
                compounded_x : v1,
                compounded_y : v2,
            };
            0x2::event::emit<FeesCompounded>(v3);
        };
    }

    public entry fun create_and_share_vault<T0, T1>(arg0: &mut VaultConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0, T1>>(create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    public fun create_vault<T0, T1>(arg0: &mut VaultConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        assert!(arg5 > 0 || arg7, 6);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        let v3 = 0x2::clock::timestamp_ms(arg11);
        let v4 = if (arg5 > 0) {
            v3 + arg5
        } else {
            0
        };
        let v5 = Vault<T0, T1>{
            id                   : 0x2::object::new(arg12),
            owner                : v0,
            pool_id              : arg3,
            balance_x            : 0x2::coin::into_balance<T0>(arg1),
            balance_y            : 0x2::coin::into_balance<T1>(arg2),
            fees_x               : 0x2::balance::zero<T0>(),
            fees_y               : 0x2::balance::zero<T1>(),
            rewards_collected    : 0x2::table::new<0x1::string::String, u64>(arg12),
            initial_deposit_x    : v1,
            initial_deposit_y    : v2,
            total_fees_earned_x  : 0,
            total_fees_earned_y  : 0,
            total_rewards_earned : 0x2::table::new<0x1::string::String, u64>(arg12),
            created_at           : v3,
            position_opened_at   : 0,
            range_bps            : arg4,
            timer_duration_ms    : arg5,
            next_execution_at    : v4,
            max_cycles           : arg6,
            cycles_completed     : 0,
            is_active            : true,
            has_position         : false,
            auto_rebalance       : arg7,
            use_zap              : arg8,
            auto_compound        : arg9,
            rebalance_delay_ms   : arg10,
            out_of_range_since   : 0,
            rebalance_pending    : false,
            rebalance_count      : 0,
            fee_recipient        : @0x0,
        };
        let v6 = 0x2::object::id_address<Vault<T0, T1>>(&v5);
        arg0.total_vaults = arg0.total_vaults + 1;
        let v7 = VaultCreated{
            vault_id          : v6,
            owner             : v0,
            pool_id           : arg3,
            range_bps         : arg4,
            timer_duration_ms : arg5,
            max_cycles        : arg6,
        };
        0x2::event::emit<VaultCreated>(v7);
        let v8 = VaultDeposit{
            vault_id : v6,
            amount_x : v1,
            amount_y : v2,
        };
        0x2::event::emit<VaultDeposit>(v8);
        v5
    }

    public fun created_at<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.created_at
    }

    public fun cycles_completed<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.cycles_completed
    }

    public entry fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg2));
        arg0.initial_deposit_x = arg0.initial_deposit_x + v0;
        arg0.initial_deposit_y = arg0.initial_deposit_y + v1;
        let v2 = VaultDeposit{
            vault_id : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<VaultDeposit>(v2);
    }

    public fun deposit_leftover<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(arg3));
        let v1 = LeftoverDeposited{
            vault_id : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            amount_x : 0x2::coin::value<T0>(&arg2),
            amount_y : 0x2::coin::value<T1>(&arg3),
        };
        0x2::event::emit<LeftoverDeposited>(v1);
    }

    public fun deposit_proceeds<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::coin::into_balance<T1>(arg3));
        let v1 = 0x2::coin::value<T0>(&arg4);
        let v2 = 0x2::coin::value<T1>(&arg5);
        0x2::balance::join<T0>(&mut arg1.fees_x, 0x2::coin::into_balance<T0>(arg4));
        0x2::balance::join<T1>(&mut arg1.fees_y, 0x2::coin::into_balance<T1>(arg5));
        arg1.total_fees_earned_x = arg1.total_fees_earned_x + v1;
        arg1.total_fees_earned_y = arg1.total_fees_earned_y + v2;
        arg1.cycles_completed = arg1.cycles_completed + 1;
        if (arg1.is_active && (arg1.max_cycles == 0 || arg1.cycles_completed < arg1.max_cycles)) {
            arg1.next_execution_at = 0x2::clock::timestamp_ms(arg6) + arg1.timer_duration_ms;
        } else {
            arg1.is_active = false;
        };
        let v3 = CycleExecuted{
            vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            cycle_number : arg1.cycles_completed,
            removed_x    : 0x2::balance::value<T0>(&arg1.balance_x),
            removed_y    : 0x2::balance::value<T1>(&arg1.balance_y),
            fees_x       : v1,
            fees_y       : v2,
        };
        0x2::event::emit<CycleExecuted>(v3);
    }

    public entry fun deposit_reward<T0, T1, T2>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        let v1 = 0x2::coin::value<T2>(&arg2);
        let v2 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>()));
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.rewards_collected, v2)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.rewards_collected, v2, 0x2::table::remove<0x1::string::String, u64>(&mut arg1.rewards_collected, v2) + v1);
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.rewards_collected, v2, v1);
        };
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.total_rewards_earned, v2)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v2, 0x2::table::remove<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v2) + v1);
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v2, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg2, arg1.owner);
        let v3 = RewardsCollected{
            vault_id  : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            coin_type : v2,
            amount    : v1,
        };
        0x2::event::emit<RewardsCollected>(v3);
    }

    public fun fee_recipient<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun get_config_info(arg0: &VaultConfig) : (address, address, u64, u64) {
        (arg0.executor, arg0.admin, arg0.total_vaults, arg0.total_cycles_executed)
    }

    public fun get_rebalance_settings<T0, T1>(arg0: &Vault<T0, T1>) : (bool, bool, bool, u64, u64, address) {
        (arg0.auto_rebalance, arg0.use_zap, arg0.auto_compound, arg0.rebalance_delay_ms, arg0.rebalance_count, arg0.fee_recipient)
    }

    public fun get_rebalance_status<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = if (arg0.rebalance_pending) {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            let v2 = arg0.out_of_range_since + arg0.rebalance_delay_ms;
            if (v1 >= v2) {
                0
            } else {
                v2 - v1
            }
        } else {
            0
        };
        (arg0.rebalance_pending, arg0.out_of_range_since, v0)
    }

    public fun get_reward_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.rewards_collected, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.rewards_collected, arg1)
        } else {
            0
        }
    }

    public fun get_total_reward_earned<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.total_rewards_earned, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.total_rewards_earned, arg1)
        } else {
            0
        }
    }

    public fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (address, 0x2::object::ID, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool, bool) {
        (arg0.owner, arg0.pool_id, 0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), 0x2::balance::value<T0>(&arg0.fees_x), 0x2::balance::value<T1>(&arg0.fees_y), arg0.range_bps, arg0.timer_duration_ms, arg0.next_execution_at, arg0.max_cycles, arg0.cycles_completed, arg0.is_active, arg0.has_position)
    }

    public fun get_vault_stats<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.initial_deposit_x, arg0.initial_deposit_y, arg0.total_fees_earned_x, arg0.total_fees_earned_y, arg0.created_at, arg0.position_opened_at)
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.has_position
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = VaultConfig{
            id                    : 0x2::object::new(arg0),
            executor              : v0,
            admin                 : v0,
            total_vaults          : 0,
            total_cycles_executed : 0,
        };
        0x2::transfer::share_object<VaultConfig>(v1);
    }

    public fun initial_deposit_x<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.initial_deposit_x
    }

    public fun initial_deposit_y<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.initial_deposit_y
    }

    public fun is_active<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_active
    }

    public fun is_ready_for_cycle<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.timer_duration_ms == 0) {
            return false
        };
        if (arg0.max_cycles != 0 && arg0.cycles_completed >= arg0.max_cycles) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.next_execution_at
    }

    public entry fun mark_out_of_range<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        assert!(arg1.is_active, 4);
        assert!(arg1.auto_rebalance, 10);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!arg1.rebalance_pending) {
            arg1.out_of_range_since = v1;
            arg1.rebalance_pending = true;
            let v2 = OutOfRangeDetected{
                vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg1),
                detected_at  : v1,
                rebalance_at : v1 + arg1.rebalance_delay_ms,
            };
            0x2::event::emit<OutOfRangeDetected>(v2);
        };
    }

    public fun max_cycles<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.max_cycles
    }

    public fun next_execution_at<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.next_execution_at
    }

    public fun owner<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.owner
    }

    public entry fun pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        arg0.is_active = false;
        let v0 = VaultPaused{vault_id: 0x2::object::id_address<Vault<T0, T1>>(arg0)};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_opened_at<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.position_opened_at
    }

    public fun range_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.range_bps
    }

    public fun rebalance_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    public fun rebalance_delay_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_delay_ms
    }

    public fun rebalance_pending<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.rebalance_pending
    }

    public fun record_rebalance<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        arg1.rebalance_pending = false;
        arg1.out_of_range_since = 0;
        arg1.rebalance_count = arg1.rebalance_count + 1;
        if (arg1.auto_compound) {
            let v1 = 0x2::balance::value<T0>(&arg1.fees_x);
            let v2 = 0x2::balance::value<T1>(&arg1.fees_y);
            if (v1 > 0 || v2 > 0) {
                0x2::balance::join<T0>(&mut arg1.balance_x, 0x2::balance::withdraw_all<T0>(&mut arg1.fees_x));
                0x2::balance::join<T1>(&mut arg1.balance_y, 0x2::balance::withdraw_all<T1>(&mut arg1.fees_y));
                let v3 = FeesCompounded{
                    vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg1),
                    compounded_x : v1,
                    compounded_y : v2,
                };
                0x2::event::emit<FeesCompounded>(v3);
            };
        };
        let v4 = RebalanceExecuted{
            vault_id        : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            rebalance_count : arg1.rebalance_count,
            used_zap        : arg1.use_zap,
            amount_in       : arg2,
            amount_out      : arg3,
            swap_x_to_y     : arg4,
        };
        0x2::event::emit<RebalanceExecuted>(v4);
    }

    public entry fun request_rebalance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg0.is_active, 4);
        assert!(arg0.auto_rebalance, 10);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.out_of_range_since = v0;
        arg0.rebalance_pending = true;
        let v1 = OutOfRangeDetected{
            vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            detected_at  : v0,
            rebalance_at : v0 + arg0.rebalance_delay_ms,
        };
        0x2::event::emit<OutOfRangeDetected>(v1);
    }

    public entry fun resume<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.is_active = true;
        arg0.next_execution_at = 0x2::clock::timestamp_ms(arg1) + arg0.timer_duration_ms;
        let v0 = VaultResumed{
            vault_id          : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            next_execution_at : arg0.next_execution_at,
        };
        0x2::event::emit<VaultResumed>(v0);
    }

    public fun retrieve_position<T0, T1, T2: store + key>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : T2 {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (v0 == arg0.executor) {
            true
        } else if (v0 == arg0.admin) {
            true
        } else {
            v0 == arg1.owner
        };
        assert!(v1, 1);
        assert!(arg1.has_position, 9);
        arg1.has_position = false;
        0x2::dynamic_object_field::remove<vector<u8>, T2>(&mut arg1.id, b"position")
    }

    public entry fun set_executor(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.executor = arg1;
    }

    public entry fun set_fee_recipient<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientUpdated{
            vault_id      : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            old_recipient : arg0.fee_recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun store_position<T0, T1, T2: store + key>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: T2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        assert!(!arg1.has_position, 8);
        0x2::dynamic_object_field::add<vector<u8>, T2>(&mut arg1.id, b"position", arg2);
        arg1.has_position = true;
        arg1.position_opened_at = 0x2::clock::timestamp_ms(arg3);
        let v1 = PositionOpened{
            vault_id    : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            position_id : 0x2::object::id_address<T2>(&arg2),
            amount_x    : 0,
            amount_y    : 0,
        };
        0x2::event::emit<PositionOpened>(v1);
    }

    public fun take_for_position<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        assert!(arg1.is_active, 4);
        assert!(!arg1.has_position, 8);
        0x2::balance::value<T0>(&arg1.balance_x);
        0x2::balance::value<T1>(&arg1.balance_y);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance_x), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.balance_y), arg2))
    }

    public fun total_fees_earned_x<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_fees_earned_x
    }

    public fun total_fees_earned_y<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_fees_earned_y
    }

    public fun track_fees<T0, T1>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        arg1.total_fees_earned_x = arg1.total_fees_earned_x + arg2;
        arg1.total_fees_earned_y = arg1.total_fees_earned_y + arg3;
    }

    public fun track_reward<T0, T1, T2>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        if (arg2 == 0) {
            return
        };
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>()));
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.total_rewards_earned, v1)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v1, 0x2::table::remove<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v1) + arg2);
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.total_rewards_earned, v1, arg2);
        };
        let v2 = RewardsCollected{
            vault_id  : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            coin_type : v1,
            amount    : arg2,
        };
        0x2::event::emit<RewardsCollected>(v2);
    }

    public entry fun transfer_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public entry fun update_rebalance_settings<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 2);
        assert!(arg4 <= 86400000, 6);
        arg0.auto_rebalance = arg1;
        arg0.use_zap = arg2;
        arg0.auto_compound = arg3;
        arg0.rebalance_delay_ms = arg4;
        let v0 = RebalanceSettingsUpdated{
            vault_id           : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            auto_rebalance     : arg1,
            use_zap            : arg2,
            auto_compound      : arg3,
            rebalance_delay_ms : arg4,
        };
        0x2::event::emit<RebalanceSettingsUpdated>(v0);
    }

    public entry fun update_settings<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        assert!(arg2 > 0 || arg0.auto_rebalance, 6);
        arg0.range_bps = arg1;
        arg0.timer_duration_ms = arg2;
        arg0.max_cycles = arg3;
    }

    public fun use_zap<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.use_zap
    }

    public fun withdraw<T0, T1>(arg0: &mut VaultConfig, arg1: Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 2);
        assert!(!arg1.has_position, 8);
        let Vault {
            id                   : v0,
            owner                : v1,
            pool_id              : _,
            balance_x            : v3,
            balance_y            : v4,
            fees_x               : v5,
            fees_y               : v6,
            rewards_collected    : v7,
            initial_deposit_x    : _,
            initial_deposit_y    : _,
            total_fees_earned_x  : _,
            total_fees_earned_y  : _,
            total_rewards_earned : v12,
            created_at           : _,
            position_opened_at   : _,
            range_bps            : _,
            timer_duration_ms    : _,
            next_execution_at    : _,
            max_cycles           : _,
            cycles_completed     : _,
            is_active            : _,
            has_position         : _,
            auto_rebalance       : _,
            use_zap              : _,
            auto_compound        : _,
            rebalance_delay_ms   : _,
            out_of_range_since   : _,
            rebalance_pending    : _,
            rebalance_count      : _,
            fee_recipient        : _,
        } = arg1;
        let v30 = v0;
        0x2::table::drop<0x1::string::String, u64>(v7);
        0x2::table::drop<0x1::string::String, u64>(v12);
        let v31 = v3;
        let v32 = v4;
        0x2::balance::join<T0>(&mut v31, v5);
        0x2::balance::join<T1>(&mut v32, v6);
        let v33 = VaultWithdrawn{
            vault_id : 0x2::object::uid_to_address(&v30),
            owner    : v1,
            total_x  : 0x2::balance::value<T0>(&v31),
            total_y  : 0x2::balance::value<T1>(&v32),
        };
        0x2::event::emit<VaultWithdrawn>(v33);
        0x2::object::delete(v30);
        (0x2::coin::from_balance<T0>(v31, arg2), 0x2::coin::from_balance<T1>(v32, arg2))
    }

    public entry fun withdraw_and_transfer<T0, T1>(arg0: &mut VaultConfig, arg1: Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.owner;
        let (v1, v2) = withdraw<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun withdraw_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.fees_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fees_y);
        if (v0 > 0 || v1 > 0) {
            let v2 = if (arg0.fee_recipient == @0x0) {
                arg0.owner
            } else {
                arg0.fee_recipient
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fees_x), arg1), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.fees_y), arg1), v2);
            let v3 = FeesWithdrawn{
                vault_id  : 0x2::object::id_address<Vault<T0, T1>>(arg0),
                recipient : v2,
                amount_x  : v0,
                amount_y  : v1,
            };
            0x2::event::emit<FeesWithdrawn>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

