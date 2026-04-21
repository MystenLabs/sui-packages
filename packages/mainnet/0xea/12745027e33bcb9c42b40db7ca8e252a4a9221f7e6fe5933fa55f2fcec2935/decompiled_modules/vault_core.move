module 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core {
    struct Vault has key {
        id: 0x2::object::UID,
        balances: 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::UserPool,
        fee_balances: 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool,
        operator_gas_pool: 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::GasPool,
        positions: 0x2::table::Table<0x2::object::ID, PositionRecord>,
        accounts: 0x2::table::Table<address, UserAccount>,
        operators: 0x2::vec_set::VecSet<address>,
        allowed_targets: 0x2::vec_set::VecSet<address>,
        config: VaultConfig,
        pending_actions: 0x2::table::Table<u64, PendingAction>,
        action_nonce: u64,
        timelock_duration_secs: u64,
        rate_window_start: u64,
        rate_ops_in_window: u64,
        rate_value_in_window: u64,
        paused: bool,
        paused_at: u64,
        version: u64,
    }

    struct UserAccount has store {
        deposits: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        locked: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        max_lock: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        gas_escrow: u64,
        gas_reserved: u64,
        position_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        active_limit_orders: u8,
        navi_shares: 0x2::vec_map::VecMap<u8, u64>,
        suilend_shares: 0x2::vec_map::VecMap<u64, u64>,
        total_fees_paid: u64,
        last_deposit_at: u64,
        last_order_created_at: u64,
    }

    struct PositionRecord has drop, store {
        owner: address,
        position_type: u8,
        protocol: u8,
        token_a: 0x1::type_name::TypeName,
        token_b: 0x1::option::Option<0x1::type_name::TypeName>,
        amount_a: u64,
        amount_b: u64,
        target_bin_id: 0x1::option::Option<u32>,
        limit_side: 0x1::option::Option<u8>,
        reserved_gas: u64,
        created_at: u64,
        status: u8,
    }

    struct VaultConfig has drop, store {
        yield_fee_bps: u64,
        limit_order_fee_bps: u64,
        deposit_fee_bps: u64,
        gas_cost_open_position: u64,
        gas_cost_close_position: u64,
        gas_cost_rebalance: u64,
        gas_cost_collect_fees: u64,
        gas_cost_open_limit_order: u64,
        gas_cost_close_limit_order: u64,
        gas_cost_lending_deposit: u64,
        gas_cost_lending_withdraw: u64,
        min_gas_escrow: u64,
        max_positions_per_user: u64,
        max_limit_orders_per_user: u8,
        max_operators: u8,
        order_cooldown_ms: u64,
        withdrawal_cooldown_secs: u64,
        force_unlock_delay_secs: u64,
        fee_recipient: address,
        emergency_withdrawal: bool,
        rate_limits: OperatorRateLimits,
    }

    struct OperatorRateLimits has drop, store {
        max_ops_per_window: u64,
        max_value_per_window: u64,
        window_duration_secs: u64,
    }

    struct PendingAction has drop, store {
        action_type: u8,
        payload: vector<u8>,
        created_at: u64,
        executable_at: u64,
    }

    struct UserReceipt has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        nonce: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct TreasurerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        label: 0x1::ascii::String,
    }

    struct ProtocolShares has drop, store {
        total_shares: u64,
        total_deposited: u64,
    }

    public fun account_active_limit_orders(arg0: &UserAccount) : u8 {
        arg0.active_limit_orders
    }

    public fun account_deposits(arg0: &UserAccount) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.deposits
    }

    public(friend) fun account_deposits_mut(arg0: &mut UserAccount) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.deposits
    }

    public fun account_gas_escrow(arg0: &UserAccount) : u64 {
        arg0.gas_escrow
    }

    public fun account_gas_reserved(arg0: &UserAccount) : u64 {
        arg0.gas_reserved
    }

    public fun account_last_deposit_at(arg0: &UserAccount) : u64 {
        arg0.last_deposit_at
    }

    public fun account_last_order_created_at(arg0: &UserAccount) : u64 {
        arg0.last_order_created_at
    }

    public fun account_locked(arg0: &UserAccount) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.locked
    }

    public(friend) fun account_locked_mut(arg0: &mut UserAccount) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.locked
    }

    public fun account_max_lock(arg0: &UserAccount) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.max_lock
    }

    public(friend) fun account_max_lock_mut(arg0: &mut UserAccount) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &mut arg0.max_lock
    }

    public fun account_navi_shares(arg0: &UserAccount) : &0x2::vec_map::VecMap<u8, u64> {
        &arg0.navi_shares
    }

    public(friend) fun account_navi_shares_mut(arg0: &mut UserAccount) : &mut 0x2::vec_map::VecMap<u8, u64> {
        &mut arg0.navi_shares
    }

    public fun account_position_ids(arg0: &UserAccount) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.position_ids
    }

    public fun account_suilend_shares(arg0: &UserAccount) : &0x2::vec_map::VecMap<u64, u64> {
        &arg0.suilend_shares
    }

    public(friend) fun account_suilend_shares_mut(arg0: &mut UserAccount) : &mut 0x2::vec_map::VecMap<u64, u64> {
        &mut arg0.suilend_shares
    }

    public fun account_total_fees_paid(arg0: &UserAccount) : u64 {
        arg0.total_fees_paid
    }

    public(friend) fun add_allowed_target(arg0: &mut Vault, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.allowed_targets, arg1);
    }

    public(friend) fun add_operator(arg0: &mut Vault, arg1: address) {
        0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
    }

    public(friend) fun add_pending_action(arg0: &mut Vault, arg1: u64, arg2: PendingAction) {
        0x2::table::add<u64, PendingAction>(&mut arg0.pending_actions, arg1, arg2);
    }

    public(friend) fun add_position(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: PositionRecord) {
        0x2::table::add<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1, arg2);
    }

    public(friend) fun add_position_id(arg0: &mut UserAccount, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.position_ids, arg1);
    }

    public fun admin_cap_vault_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun assert_not_paused(arg0: &Vault) {
        assert!(!arg0.paused, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::vault_paused());
    }

    public(friend) fun assert_paused(arg0: &Vault) {
        assert!(arg0.paused, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::vault_not_paused());
    }

    public(friend) fun assert_version(arg0: &Vault) {
        assert!(arg0.version == 3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::version_mismatch());
    }

    public(friend) fun borrow_account(arg0: &Vault, arg1: address) : &UserAccount {
        assert!(0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::account_not_found());
        0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1)
    }

    public(friend) fun borrow_account_mut(arg0: &mut Vault, arg1: address) : &mut UserAccount {
        assert!(0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::account_not_found());
        0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, arg1)
    }

    public(friend) fun borrow_fee_pool(arg0: &Vault) : &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool {
        &arg0.fee_balances
    }

    public(friend) fun borrow_fee_pool_mut(arg0: &mut Vault) : &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::FeePool {
        &mut arg0.fee_balances
    }

    public(friend) fun borrow_gas_pool(arg0: &Vault) : &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::GasPool {
        &arg0.operator_gas_pool
    }

    public(friend) fun borrow_gas_pool_mut(arg0: &mut Vault) : &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::GasPool {
        &mut arg0.operator_gas_pool
    }

    public(friend) fun borrow_pending_action(arg0: &Vault, arg1: u64) : &PendingAction {
        0x2::table::borrow<u64, PendingAction>(&arg0.pending_actions, arg1)
    }

    public(friend) fun borrow_position(arg0: &Vault, arg1: 0x2::object::ID) : &PositionRecord {
        assert!(0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::position_not_found());
        0x2::table::borrow<0x2::object::ID, PositionRecord>(&arg0.positions, arg1)
    }

    public(friend) fun borrow_position_mut(arg0: &mut Vault, arg1: 0x2::object::ID) : &mut PositionRecord {
        assert!(0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::position_not_found());
        0x2::table::borrow_mut<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1)
    }

    public(friend) fun borrow_user_pool(arg0: &Vault) : &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::UserPool {
        &arg0.balances
    }

    public(friend) fun borrow_user_pool_mut(arg0: &mut Vault) : &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::UserPool {
        &mut arg0.balances
    }

    public fun cfg_deposit_fee_bps(arg0: &VaultConfig) : u64 {
        arg0.deposit_fee_bps
    }

    public fun cfg_emergency_withdrawal(arg0: &VaultConfig) : bool {
        arg0.emergency_withdrawal
    }

    public fun cfg_fee_recipient(arg0: &VaultConfig) : address {
        arg0.fee_recipient
    }

    public fun cfg_force_unlock_delay_secs(arg0: &VaultConfig) : u64 {
        arg0.force_unlock_delay_secs
    }

    public fun cfg_gas_cost(arg0: &VaultConfig, arg1: u8) : u64 {
        if (arg1 == 0 || arg1 == 2) {
            arg0.gas_cost_open_position
        } else if (arg1 == 1) {
            arg0.gas_cost_close_position
        } else if (arg1 == 4 || arg1 == 3) {
            arg0.gas_cost_collect_fees
        } else if (arg1 == 5) {
            arg0.gas_cost_open_limit_order
        } else if (arg1 == 6) {
            arg0.gas_cost_close_limit_order
        } else if (arg1 == 7) {
            arg0.gas_cost_lending_deposit
        } else if (arg1 == 8) {
            arg0.gas_cost_lending_withdraw
        } else {
            0
        }
    }

    public fun cfg_gas_cost_close_limit_order(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_close_limit_order
    }

    public fun cfg_gas_cost_close_position(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_close_position
    }

    public fun cfg_gas_cost_collect_fees(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_collect_fees
    }

    public fun cfg_gas_cost_lending_deposit(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_lending_deposit
    }

    public fun cfg_gas_cost_lending_withdraw(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_lending_withdraw
    }

    public fun cfg_gas_cost_open_limit_order(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_open_limit_order
    }

    public fun cfg_gas_cost_open_position(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_open_position
    }

    public fun cfg_gas_cost_rebalance(arg0: &VaultConfig) : u64 {
        arg0.gas_cost_rebalance
    }

    public fun cfg_limit_order_fee_bps(arg0: &VaultConfig) : u64 {
        arg0.limit_order_fee_bps
    }

    public fun cfg_max_limit_orders_per_user(arg0: &VaultConfig) : u8 {
        arg0.max_limit_orders_per_user
    }

    public fun cfg_max_operators(arg0: &VaultConfig) : u8 {
        arg0.max_operators
    }

    public fun cfg_max_positions_per_user(arg0: &VaultConfig) : u64 {
        arg0.max_positions_per_user
    }

    public fun cfg_min_gas_escrow(arg0: &VaultConfig) : u64 {
        arg0.min_gas_escrow
    }

    public fun cfg_order_cooldown_ms(arg0: &VaultConfig) : u64 {
        arg0.order_cooldown_ms
    }

    public fun cfg_rate_limits(arg0: &VaultConfig) : &OperatorRateLimits {
        &arg0.rate_limits
    }

    public fun cfg_withdrawal_cooldown_secs(arg0: &VaultConfig) : u64 {
        arg0.withdrawal_cooldown_secs
    }

    public fun cfg_yield_fee_bps(arg0: &VaultConfig) : u64 {
        arg0.yield_fee_bps
    }

    public(friend) fun config(arg0: &Vault) : &VaultConfig {
        &arg0.config
    }

    public(friend) fun config_mut(arg0: &mut Vault) : &mut VaultConfig {
        &mut arg0.config
    }

    public(friend) fun create_account(arg0: &mut Vault, arg1: address) {
        let v0 = UserAccount{
            deposits              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            locked                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            max_lock              : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            gas_escrow            : 0,
            gas_reserved          : 0,
            position_ids          : 0x2::vec_set::empty<0x2::object::ID>(),
            active_limit_orders   : 0,
            navi_shares           : 0x2::vec_map::empty<u8, u64>(),
            suilend_shares        : 0x2::vec_map::empty<u64, u64>(),
            total_fees_paid       : 0,
            last_deposit_at       : 0,
            last_order_created_at : 0,
        };
        0x2::table::add<address, UserAccount>(&mut arg0.accounts, arg1, v0);
    }

    public fun create_vault(arg0: u64, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Vault, AdminCap, TreasurerCap) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v3 = Vault{
            id                     : v0,
            balances               : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::new_user_pool(arg3),
            fee_balances           : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::new_fee_pool(arg3),
            operator_gas_pool      : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::new_gas_pool(),
            positions              : 0x2::table::new<0x2::object::ID, PositionRecord>(arg3),
            accounts               : 0x2::table::new<address, UserAccount>(arg3),
            operators              : 0x2::vec_set::empty<address>(),
            allowed_targets        : 0x2::vec_set::empty<address>(),
            config                 : default_config(arg1),
            pending_actions        : 0x2::table::new<u64, PendingAction>(arg3),
            action_nonce           : 0,
            timelock_duration_secs : arg0,
            rate_window_start      : v2,
            rate_ops_in_window     : 0,
            rate_value_in_window   : 0,
            paused                 : false,
            paused_at              : 0,
            version                : 3,
        };
        let v4 = AdminCap{
            id       : 0x2::object::new(arg3),
            vault_id : v1,
        };
        let v5 = TreasurerCap{
            id       : 0x2::object::new(arg3),
            vault_id : v1,
        };
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::events::emit_vault_created(v1, 0x2::tx_context::sender(arg3), arg0, v2);
        (v3, v4, v5)
    }

    fun default_config(arg0: address) : VaultConfig {
        let v0 = OperatorRateLimits{
            max_ops_per_window   : 50,
            max_value_per_window : 50000000000,
            window_duration_secs : 3600,
        };
        VaultConfig{
            yield_fee_bps              : 100,
            limit_order_fee_bps        : 50,
            deposit_fee_bps            : 5,
            gas_cost_open_position     : 60000000,
            gas_cost_close_position    : 30000000,
            gas_cost_rebalance         : 80000000,
            gas_cost_collect_fees      : 15000000,
            gas_cost_open_limit_order  : 60000000,
            gas_cost_close_limit_order : 40000000,
            gas_cost_lending_deposit   : 40000000,
            gas_cost_lending_withdraw  : 40000000,
            min_gas_escrow             : 200000000,
            max_positions_per_user     : 3,
            max_limit_orders_per_user  : 2,
            max_operators              : 2,
            order_cooldown_ms          : 60000,
            withdrawal_cooldown_secs   : 0,
            force_unlock_delay_secs    : 86400,
            fee_recipient              : arg0,
            emergency_withdrawal       : false,
            rate_limits                : v0,
        }
    }

    public(friend) fun has_account(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)
    }

    public(friend) fun has_pending_action(arg0: &Vault, arg1: u64) : bool {
        0x2::table::contains<u64, PendingAction>(&arg0.pending_actions, arg1)
    }

    public(friend) fun has_position(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1)
    }

    public(friend) fun increment_rate(arg0: &mut Vault, arg1: u64) {
        arg0.rate_ops_in_window = arg0.rate_ops_in_window + 1;
        arg0.rate_value_in_window = arg0.rate_value_in_window + arg1;
    }

    public fun init_vault(arg0: u64, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create_vault(arg0, arg1, arg2, arg3);
        0x2::transfer::share_object<Vault>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<TreasurerCap>(v2, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun is_allowed_target(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowed_targets, &arg1)
    }

    public(friend) fun is_operator(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public(friend) fun new_operator_cap(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{
            id       : 0x2::object::new(arg2),
            vault_id : arg0,
            label    : arg1,
        }
    }

    public fun new_operator_rate_limits(arg0: u64, arg1: u64, arg2: u64) : OperatorRateLimits {
        OperatorRateLimits{
            max_ops_per_window   : arg0,
            max_value_per_window : arg1,
            window_duration_secs : arg2,
        }
    }

    public(friend) fun new_pending_action(arg0: u8, arg1: vector<u8>, arg2: u64, arg3: u64) : PendingAction {
        PendingAction{
            action_type   : arg0,
            payload       : arg1,
            created_at    : arg2,
            executable_at : arg3,
        }
    }

    public(friend) fun new_position_record(arg0: address, arg1: u8, arg2: u8, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x1::type_name::TypeName>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: 0x1::option::Option<u8>, arg9: u64, arg10: u64) : PositionRecord {
        PositionRecord{
            owner         : arg0,
            position_type : arg1,
            protocol      : arg2,
            token_a       : arg3,
            token_b       : arg4,
            amount_a      : arg5,
            amount_b      : arg6,
            target_bin_id : arg7,
            limit_side    : arg8,
            reserved_gas  : arg9,
            created_at    : arg10,
            status        : 0,
        }
    }

    public(friend) fun new_receipt(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : UserReceipt {
        UserReceipt{
            id       : 0x2::object::new(arg3),
            vault_id : arg0,
            owner    : arg1,
            nonce    : arg2,
        }
    }

    public fun new_vault_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: address, arg19: bool, arg20: OperatorRateLimits) : VaultConfig {
        VaultConfig{
            yield_fee_bps              : arg0,
            limit_order_fee_bps        : arg1,
            deposit_fee_bps            : arg2,
            gas_cost_open_position     : arg3,
            gas_cost_close_position    : arg4,
            gas_cost_rebalance         : arg5,
            gas_cost_collect_fees      : arg6,
            gas_cost_open_limit_order  : arg7,
            gas_cost_close_limit_order : arg8,
            gas_cost_lending_deposit   : arg9,
            gas_cost_lending_withdraw  : arg10,
            min_gas_escrow             : arg11,
            max_positions_per_user     : arg12,
            max_limit_orders_per_user  : arg13,
            max_operators              : arg14,
            order_cooldown_ms          : arg15,
            withdrawal_cooldown_secs   : arg16,
            force_unlock_delay_secs    : arg17,
            fee_recipient              : arg18,
            emergency_withdrawal       : arg19,
            rate_limits                : arg20,
        }
    }

    public(friend) fun next_action_nonce(arg0: &mut Vault) : u64 {
        let v0 = arg0.action_nonce;
        arg0.action_nonce = v0 + 1;
        v0
    }

    public fun op_add_liquidity() : u8 {
        2
    }

    public fun op_close_limit() : u8 {
        6
    }

    public fun op_close_lp() : u8 {
        1
    }

    public fun op_collect_fees() : u8 {
        4
    }

    public fun op_lending_deposit() : u8 {
        7
    }

    public fun op_lending_withdraw() : u8 {
        8
    }

    public fun op_open_limit() : u8 {
        5
    }

    public fun op_open_lp() : u8 {
        0
    }

    public fun op_remove_liquidity() : u8 {
        3
    }

    public fun operator_cap_vault_id(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun operators_count(arg0: &Vault) : u64 {
        0x2::vec_set::length<address>(&arg0.operators)
    }

    public fun paused_at(arg0: &Vault) : u64 {
        arg0.paused_at
    }

    public fun pending_action_executable_at(arg0: &PendingAction) : u64 {
        arg0.executable_at
    }

    public fun pending_action_payload(arg0: &PendingAction) : &vector<u8> {
        &arg0.payload
    }

    public fun pending_action_type(arg0: &PendingAction) : u8 {
        arg0.action_type
    }

    public fun position_amount_a(arg0: &PositionRecord) : u64 {
        arg0.amount_a
    }

    public fun position_amount_b(arg0: &PositionRecord) : u64 {
        arg0.amount_b
    }

    public fun position_created_at(arg0: &PositionRecord) : u64 {
        arg0.created_at
    }

    public fun position_limit_side(arg0: &PositionRecord) : &0x1::option::Option<u8> {
        &arg0.limit_side
    }

    public fun position_owner(arg0: &PositionRecord) : address {
        arg0.owner
    }

    public fun position_protocol(arg0: &PositionRecord) : u8 {
        arg0.protocol
    }

    public fun position_reserved_gas(arg0: &PositionRecord) : u64 {
        arg0.reserved_gas
    }

    public fun position_status(arg0: &PositionRecord) : u8 {
        arg0.status
    }

    public fun position_target_bin_id(arg0: &PositionRecord) : &0x1::option::Option<u32> {
        &arg0.target_bin_id
    }

    public fun position_token_a(arg0: &PositionRecord) : 0x1::type_name::TypeName {
        arg0.token_a
    }

    public fun position_token_b(arg0: &PositionRecord) : &0x1::option::Option<0x1::type_name::TypeName> {
        &arg0.token_b
    }

    public fun position_type(arg0: &PositionRecord) : u8 {
        arg0.position_type
    }

    public fun position_type_lending() : u8 {
        2
    }

    public fun position_type_limit_order() : u8 {
        1
    }

    public fun position_type_lp() : u8 {
        0
    }

    public fun protocol_alphalend() : u8 {
        3
    }

    public fun protocol_cetus_dlmm() : u8 {
        0
    }

    public fun protocol_navi() : u8 {
        2
    }

    public fun protocol_suilend() : u8 {
        1
    }

    public(friend) fun rate_ops_in_window(arg0: &Vault) : u64 {
        arg0.rate_ops_in_window
    }

    public(friend) fun rate_value_in_window(arg0: &Vault) : u64 {
        arg0.rate_value_in_window
    }

    public(friend) fun rate_window_start(arg0: &Vault) : u64 {
        arg0.rate_window_start
    }

    public fun receipt_owner(arg0: &UserReceipt) : address {
        arg0.owner
    }

    public fun receipt_vault_id(arg0: &UserReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun remove_allowed_target(arg0: &mut Vault, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.allowed_targets, &arg1);
    }

    public(friend) fun remove_operator(arg0: &mut Vault, arg1: address) {
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
    }

    public(friend) fun remove_pending_action(arg0: &mut Vault, arg1: u64) : PendingAction {
        0x2::table::remove<u64, PendingAction>(&mut arg0.pending_actions, arg1)
    }

    public(friend) fun remove_position(arg0: &mut Vault, arg1: 0x2::object::ID) : PositionRecord {
        0x2::table::remove<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1)
    }

    public(friend) fun remove_position_id(arg0: &mut UserAccount, arg1: &0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.position_ids, arg1);
    }

    public(friend) fun replace_config(arg0: &mut Vault, arg1: VaultConfig) {
        arg0.config = arg1;
    }

    public(friend) fun reset_rate_window(arg0: &mut Vault, arg1: u64) {
        arg0.rate_window_start = arg1;
        arg0.rate_ops_in_window = 0;
        arg0.rate_value_in_window = 0;
    }

    public fun rl_max_ops_per_window(arg0: &OperatorRateLimits) : u64 {
        arg0.max_ops_per_window
    }

    public fun rl_max_value_per_window(arg0: &OperatorRateLimits) : u64 {
        arg0.max_value_per_window
    }

    public fun rl_window_duration_secs(arg0: &OperatorRateLimits) : u64 {
        arg0.window_duration_secs
    }

    public(friend) fun set_active_limit_orders(arg0: &mut UserAccount, arg1: u8) {
        arg0.active_limit_orders = arg1;
    }

    public(friend) fun set_gas_escrow(arg0: &mut UserAccount, arg1: u64) {
        arg0.gas_escrow = arg1;
    }

    public(friend) fun set_gas_reserved(arg0: &mut UserAccount, arg1: u64) {
        arg0.gas_reserved = arg1;
    }

    public(friend) fun set_last_deposit_at(arg0: &mut UserAccount, arg1: u64) {
        arg0.last_deposit_at = arg1;
    }

    public(friend) fun set_last_order_created_at(arg0: &mut UserAccount, arg1: u64) {
        arg0.last_order_created_at = arg1;
    }

    public(friend) fun set_paused(arg0: &mut Vault, arg1: bool, arg2: u64) {
        arg0.paused = arg1;
        if (arg1) {
            arg0.paused_at = arg2;
        };
    }

    public(friend) fun set_position_amounts(arg0: &mut PositionRecord, arg1: u64, arg2: u64) {
        arg0.amount_a = arg1;
        arg0.amount_b = arg2;
    }

    public(friend) fun set_position_status(arg0: &mut PositionRecord, arg1: u8) {
        arg0.status = arg1;
    }

    public(friend) fun set_total_fees_paid(arg0: &mut UserAccount, arg1: u64) {
        arg0.total_fees_paid = arg1;
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_closed() : u8 {
        2
    }

    public fun status_filled() : u8 {
        1
    }

    public fun status_force_closed() : u8 {
        3
    }

    public(friend) fun timelock_duration(arg0: &Vault) : u64 {
        arg0.timelock_duration_secs
    }

    public fun treasurer_cap_vault_id(arg0: &TreasurerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun vault_id(arg0: &Vault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun vault_uid(arg0: &Vault) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun vault_uid_mut(arg0: &mut Vault) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

