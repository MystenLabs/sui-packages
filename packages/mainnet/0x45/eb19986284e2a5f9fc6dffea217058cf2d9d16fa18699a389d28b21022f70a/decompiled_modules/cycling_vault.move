module 0x45eb19986284e2a5f9fc6dffea217058cf2d9d16fa18699a389d28b21022f70a::cycling_vault {
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
        range_bps: u64,
        timer_duration_ms: u64,
        next_execution_at: u64,
        max_cycles: u64,
        cycles_completed: u64,
        is_active: bool,
        has_position: bool,
        rebalance_on_out_of_range: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
        pool_id: 0x2::object::ID,
        range_bps: u64,
        timer_duration_ms: u64,
        max_cycles: u64,
        rebalance_on_out_of_range: bool,
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

    public entry fun create_and_share_vault<T0, T1>(arg0: &mut VaultConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0, T1>>(create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun create_vault<T0, T1>(arg0: &mut VaultConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        assert!(arg5 > 0 || arg7, 6);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = if (arg5 > 0) {
            0x2::clock::timestamp_ms(arg8) + arg5
        } else {
            18446744073709551615
        };
        let v2 = Vault<T0, T1>{
            id                        : 0x2::object::new(arg9),
            owner                     : v0,
            pool_id                   : arg3,
            balance_x                 : 0x2::coin::into_balance<T0>(arg1),
            balance_y                 : 0x2::coin::into_balance<T1>(arg2),
            fees_x                    : 0x2::balance::zero<T0>(),
            fees_y                    : 0x2::balance::zero<T1>(),
            rewards_collected         : 0x2::table::new<0x1::string::String, u64>(arg9),
            range_bps                 : arg4,
            timer_duration_ms         : arg5,
            next_execution_at         : v1,
            max_cycles                : arg6,
            cycles_completed          : 0,
            is_active                 : true,
            has_position              : false,
            rebalance_on_out_of_range : arg7,
        };
        let v3 = 0x2::object::id_address<Vault<T0, T1>>(&v2);
        arg0.total_vaults = arg0.total_vaults + 1;
        let v4 = VaultCreated{
            vault_id                  : v3,
            owner                     : v0,
            pool_id                   : arg3,
            range_bps                 : arg4,
            timer_duration_ms         : arg5,
            max_cycles                : arg6,
            rebalance_on_out_of_range : arg7,
        };
        0x2::event::emit<VaultCreated>(v4);
        let v5 = VaultDeposit{
            vault_id : v3,
            amount_x : 0x2::coin::value<T0>(&arg1),
            amount_y : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<VaultDeposit>(v5);
        v2
    }

    public fun cycles_completed<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.cycles_completed
    }

    public entry fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg2));
        let v0 = VaultDeposit{
            vault_id : 0x2::object::id_address<Vault<T0, T1>>(arg0),
            amount_x : 0x2::coin::value<T0>(&arg1),
            amount_y : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<VaultDeposit>(v0);
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
        0x2::balance::join<T0>(&mut arg1.fees_x, 0x2::coin::into_balance<T0>(arg4));
        0x2::balance::join<T1>(&mut arg1.fees_y, 0x2::coin::into_balance<T1>(arg5));
        arg1.cycles_completed = arg1.cycles_completed + 1;
        if (arg1.is_active && (arg1.max_cycles == 0 || arg1.cycles_completed < arg1.max_cycles)) {
            arg1.next_execution_at = 0x2::clock::timestamp_ms(arg6) + arg1.timer_duration_ms;
        } else {
            arg1.is_active = false;
        };
        let v1 = CycleExecuted{
            vault_id     : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            cycle_number : arg1.cycles_completed,
            removed_x    : 0x2::balance::value<T0>(&arg1.balance_x),
            removed_y    : 0x2::balance::value<T1>(&arg1.balance_y),
            fees_x       : 0x2::coin::value<T0>(&arg4),
            fees_y       : 0x2::coin::value<T1>(&arg5),
        };
        0x2::event::emit<CycleExecuted>(v1);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg2, arg1.owner);
        let v3 = RewardsCollected{
            vault_id  : 0x2::object::id_address<Vault<T0, T1>>(arg1),
            coin_type : v2,
            amount    : v1,
        };
        0x2::event::emit<RewardsCollected>(v3);
    }

    public fun get_config_info(arg0: &VaultConfig) : (address, address, u64, u64) {
        (arg0.executor, arg0.admin, arg0.total_vaults, arg0.total_cycles_executed)
    }

    public fun get_reward_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.rewards_collected, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.rewards_collected, arg1)
        } else {
            0
        }
    }

    public fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (address, 0x2::object::ID, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool, bool, bool) {
        (arg0.owner, arg0.pool_id, 0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), 0x2::balance::value<T0>(&arg0.fees_x), 0x2::balance::value<T1>(&arg0.fees_y), arg0.range_bps, arg0.timer_duration_ms, arg0.next_execution_at, arg0.max_cycles, arg0.cycles_completed, arg0.is_active, arg0.has_position, arg0.rebalance_on_out_of_range)
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

    public fun is_active<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_active
    }

    public fun is_ready_for_cycle<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.max_cycles != 0 && arg0.cycles_completed >= arg0.max_cycles) {
            return false
        };
        if (arg0.timer_duration_ms == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.next_execution_at
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

    public fun range_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.range_bps
    }

    public fun rebalance_on_out_of_range<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.rebalance_on_out_of_range
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

    public fun should_rebalance_on_out_of_range<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.max_cycles != 0 && arg0.cycles_completed >= arg0.max_cycles) {
            return false
        };
        arg0.rebalance_on_out_of_range
    }

    public fun store_position<T0, T1, T2: store + key>(arg0: &VaultConfig, arg1: &mut Vault<T0, T1>, arg2: T2, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.executor || v0 == arg0.admin, 1);
        assert!(!arg1.has_position, 8);
        0x2::dynamic_object_field::add<vector<u8>, T2>(&mut arg1.id, b"position", arg2);
        arg1.has_position = true;
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

    public entry fun transfer_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public entry fun update_settings<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 2);
        assert!(arg2 > 0 || arg4, 6);
        arg0.range_bps = arg1;
        arg0.timer_duration_ms = arg2;
        arg0.max_cycles = arg3;
        arg0.rebalance_on_out_of_range = arg4;
    }

    public fun withdraw<T0, T1>(arg0: &mut VaultConfig, arg1: Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 2);
        assert!(!arg1.has_position, 8);
        let Vault {
            id                        : v0,
            owner                     : v1,
            pool_id                   : _,
            balance_x                 : v3,
            balance_y                 : v4,
            fees_x                    : v5,
            fees_y                    : v6,
            rewards_collected         : v7,
            range_bps                 : _,
            timer_duration_ms         : _,
            next_execution_at         : _,
            max_cycles                : _,
            cycles_completed          : _,
            is_active                 : _,
            has_position              : _,
            rebalance_on_out_of_range : _,
        } = arg1;
        let v16 = v0;
        0x2::table::drop<0x1::string::String, u64>(v7);
        let v17 = v3;
        let v18 = v4;
        0x2::balance::join<T0>(&mut v17, v5);
        0x2::balance::join<T1>(&mut v18, v6);
        let v19 = VaultWithdrawn{
            vault_id : 0x2::object::uid_to_address(&v16),
            owner    : v1,
            total_x  : 0x2::balance::value<T0>(&v17),
            total_y  : 0x2::balance::value<T1>(&v18),
        };
        0x2::event::emit<VaultWithdrawn>(v19);
        0x2::object::delete(v16);
        (0x2::coin::from_balance<T0>(v17, arg2), 0x2::coin::from_balance<T1>(v18, arg2))
    }

    public entry fun withdraw_and_transfer<T0, T1>(arg0: &mut VaultConfig, arg1: Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.owner;
        let (v1, v2) = withdraw<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

