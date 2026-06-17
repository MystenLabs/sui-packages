module 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ProcessorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AccountantCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AssetManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct PendingPrice has drop, store {
        price: u64,
        proposed_at: u64,
    }

    struct PendingRoles has drop, store {
        admin: address,
        manager: address,
        processor: address,
        oracle: address,
        accountant: address,
        asset_manager: address,
        guardian: address,
        proposed_at: u64,
    }

    struct PendingFees has drop, store {
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        management_fee_bps_per_year: u64,
        swap_fee_bps: u64,
        proposed_at: u64,
    }

    struct PendingLimits has drop, store {
        max_total_shares: u64,
        max_shares_per_user: u64,
        max_total_idle: u64,
        max_deviation_bps: u64,
        min_shares_to_mint: u64,
        proposed_at: u64,
    }

    struct PendingWhitelist has drop, store {
        deposit_whitelist_enabled: bool,
        withdrawal_whitelist_enabled: bool,
        proposed_at: u64,
    }

    struct PendingCooldowns has drop, store {
        price_update_cooldown_secs: u64,
        price_acceptance_cooldown_secs: u64,
        config_cooldown_secs: u64,
        role_change_cooldown_secs: u64,
        fee_change_cooldown_secs: u64,
        emergency_withdrawal_cooldown: u64,
        proposed_at: u64,
    }

    struct PendingWithdrawalParams has drop, store {
        downside_cap_bps: u64,
        withdrawal_ttl_secs: u64,
        system_penalty_bps: u64,
        proposed_at: u64,
    }

    struct WithdrawalRequest has drop, store {
        user: address,
        receiver: address,
        shares: u64,
        amount_due: u64,
        min_amount_out: u64,
        fee_shares: u64,
        price_at_request: u64,
        created_at: u64,
        status: u8,
        processed_at: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares: u64,
        fee: u64,
    }

    struct WithdrawRequestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        shares: u64,
        min_amount_out: u64,
    }

    struct WithdrawFulfilledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        amount: u64,
        fee: u64,
    }

    struct WithdrawCancelledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        request_id: u64,
        penalty_shares: u64,
    }

    struct PriceUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        auto_accepted: bool,
    }

    struct PricePendingEvent has copy, drop {
        vault_id: 0x2::object::ID,
        proposed_price: u64,
        current_price: u64,
    }

    struct PriceAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        price: u64,
    }

    struct PriceRejectedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        price: u64,
    }

    struct ManagementFeeAccruedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        fee_shares: u64,
        accountant: address,
    }

    struct VaultPausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultUnpausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct ProcessDepositsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct ReturnFundsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct FeesProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        management_fee_bps_per_year: u64,
        swap_fee_bps: u64,
    }

    struct FeesAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct RolesProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct RolesAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct LimitsProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct LimitsAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct CooldownsProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct CooldownsAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WhitelistProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WhitelistAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WithdrawalParamsProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WithdrawalParamsAcceptedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct EmergencyInitiatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        timelock_end: u64,
    }

    struct EmergencyExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct UnexpectedDepositsWithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct VaultPricing has store {
        price: u64,
        last_price_update_ts: u64,
        max_price_staleness_secs: u64,
        max_deviation_bps: u64,
    }

    struct VaultFees has store {
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        management_fee_bps_per_year: u64,
        swap_fee_bps: u64,
        last_mgmt_fee_ts: u64,
    }

    struct VaultLimits has store {
        max_total_shares: u64,
        max_shares_per_user: u64,
        max_total_idle: u64,
        min_shares_to_mint: u64,
    }

    struct VaultWithdrawalParams has store {
        downside_cap_bps: u64,
        withdrawal_ttl_secs: u64,
        system_penalty_bps: u64,
    }

    struct VaultCooldowns has store {
        price_update_cooldown_secs: u64,
        price_acceptance_cooldown_secs: u64,
        config_cooldown_secs: u64,
        role_change_cooldown_secs: u64,
        fee_change_cooldown_secs: u64,
        emergency_withdrawal_cooldown: u64,
    }

    struct VaultRoles has store {
        admin: address,
        manager: address,
        processor: address,
        oracle: address,
        accountant: address,
        asset_manager: address,
        guardian: address,
    }

    struct VaultEmergency has store {
        emergency_timelock_end: u64,
        emergency_withdrawal_amount: u64,
    }

    struct VaultPending has store {
        price: 0x1::option::Option<PendingPrice>,
        roles: 0x1::option::Option<PendingRoles>,
        fees: 0x1::option::Option<PendingFees>,
        limits: 0x1::option::Option<PendingLimits>,
        whitelist: 0x1::option::Option<PendingWhitelist>,
        cooldowns: 0x1::option::Option<PendingCooldowns>,
        withdrawal_params: 0x1::option::Option<PendingWithdrawalParams>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: 0x2::coin::TreasuryCap<T1>,
        locked_share_coins: 0x2::balance::Balance<T1>,
        underlying: 0x2::balance::Balance<T0>,
        total_shares: u64,
        shares_in_custody: u64,
        total_withdrawals_pending: u64,
        total_idle: u64,
        share_balances: 0x2::table::Table<address, u64>,
        pricing: VaultPricing,
        fees: VaultFees,
        limits: VaultLimits,
        underlying_decimals: u8,
        share_decimals: u8,
        wparams: VaultWithdrawalParams,
        next_withdrawal_id: u64,
        cooldowns: VaultCooldowns,
        deposit_whitelist_enabled: bool,
        withdrawal_whitelist_enabled: bool,
        paused: bool,
        roles: VaultRoles,
        created_at: u64,
        emergency: VaultEmergency,
        pending: VaultPending,
        withdrawal_requests: 0x2::table::Table<u64, WithdrawalRequest>,
        deposit_whitelist: 0x2::table::Table<address, bool>,
        withdrawal_whitelist: 0x2::table::Table<address, bool>,
        allowlist_mint: 0x2::table::Table<address, bool>,
    }

    public fun get_processor<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.processor
    }

    public fun accept_allowlist_mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        if (!0x2::table::contains<address, bool>(&arg0.allowlist_mint, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.allowlist_mint, arg2, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.allowlist_mint, arg2) = true;
        };
    }

    public fun accept_cooldowns<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingCooldowns>(&arg0.pending.cooldowns), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_cooldown_change());
        let v0 = 0x1::option::extract<PendingCooldowns>(&mut arg0.pending.cooldowns);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.config_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::cooldown_change_timelock_active());
        arg0.cooldowns.price_update_cooldown_secs = v0.price_update_cooldown_secs;
        arg0.cooldowns.price_acceptance_cooldown_secs = v0.price_acceptance_cooldown_secs;
        arg0.cooldowns.config_cooldown_secs = v0.config_cooldown_secs;
        arg0.cooldowns.role_change_cooldown_secs = v0.role_change_cooldown_secs;
        arg0.cooldowns.fee_change_cooldown_secs = v0.fee_change_cooldown_secs;
        arg0.cooldowns.emergency_withdrawal_cooldown = v0.emergency_withdrawal_cooldown;
        let v1 = CooldownsAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<CooldownsAcceptedEvent>(v1);
    }

    public fun accept_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingFees>(&arg0.pending.fees), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_fees_change());
        let v0 = 0x1::option::extract<PendingFees>(&mut arg0.pending.fees);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.fee_change_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::fee_change_timelock_active());
        arg0.fees.deposit_fee_bps = v0.deposit_fee_bps;
        arg0.fees.withdraw_fee_bps = v0.withdraw_fee_bps;
        arg0.fees.management_fee_bps_per_year = v0.management_fee_bps_per_year;
        arg0.fees.swap_fee_bps = v0.swap_fee_bps;
        let v1 = FeesAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<FeesAcceptedEvent>(v1);
    }

    public fun accept_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingLimits>(&arg0.pending.limits), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_config_changes_pending());
        let v0 = 0x1::option::extract<PendingLimits>(&mut arg0.pending.limits);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.config_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::config_cooldown_not_expired());
        arg0.limits.max_total_shares = v0.max_total_shares;
        arg0.limits.max_shares_per_user = v0.max_shares_per_user;
        arg0.limits.max_total_idle = v0.max_total_idle;
        arg0.pricing.max_deviation_bps = v0.max_deviation_bps;
        arg0.limits.min_shares_to_mint = v0.min_shares_to_mint;
        let v1 = LimitsAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<LimitsAcceptedEvent>(v1);
    }

    public fun accept_price<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg0.roles.manager) {
            true
        } else if (v0 == arg0.roles.processor) {
            true
        } else {
            v0 == arg0.roles.oracle
        };
        assert!(v1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<PendingPrice>(&arg0.pending.price), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_price());
        let v2 = 0x1::option::borrow<PendingPrice>(&arg0.pending.price);
        let v3 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::calculate_price_deviation(arg0.pricing.price, v2.price);
        let v4 = v0 == arg0.roles.manager;
        if (v3 > 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::max_manager_bypass_deviation_bps() && !v4) {
            abort 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized()
        };
        let v5 = v4 && v3 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::max_manager_bypass_deviation_bps();
        let v6 = now_secs(arg2);
        assert!(v5 || v6 >= v2.proposed_at + arg0.cooldowns.price_acceptance_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::price_cooldown_not_expired());
        let v7 = 0x1::option::extract<PendingPrice>(&mut arg0.pending.price);
        arg0.pricing.price = v7.price;
        arg0.pricing.last_price_update_ts = v6;
        let v8 = PriceAcceptedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            price    : v7.price,
        };
        0x2::event::emit<PriceAcceptedEvent>(v8);
    }

    public fun accept_roles<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingRoles>(&arg0.pending.roles), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_roles_change());
        let v0 = 0x1::option::extract<PendingRoles>(&mut arg0.pending.roles);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.role_change_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::role_change_timelock_active());
        arg0.roles.manager = v0.manager;
        arg0.roles.processor = v0.processor;
        arg0.roles.oracle = v0.oracle;
        arg0.roles.accountant = v0.accountant;
        arg0.roles.asset_manager = v0.asset_manager;
        arg0.roles.guardian = v0.guardian;
        let v1 = RolesAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<RolesAcceptedEvent>(v1);
    }

    public fun accept_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingWhitelist>(&arg0.pending.whitelist), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_whitelist_change());
        let v0 = 0x1::option::extract<PendingWhitelist>(&mut arg0.pending.whitelist);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.config_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::whitelist_change_timelock_active());
        arg0.deposit_whitelist_enabled = v0.deposit_whitelist_enabled;
        arg0.withdrawal_whitelist_enabled = v0.withdrawal_whitelist_enabled;
        let v1 = WhitelistAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<WhitelistAcceptedEvent>(v1);
    }

    public fun accept_withdrawal_params<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingWithdrawalParams>(&arg0.pending.withdrawal_params), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_config_changes_pending());
        let v0 = 0x1::option::extract<PendingWithdrawalParams>(&mut arg0.pending.withdrawal_params);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.cooldowns.config_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::config_cooldown_not_expired());
        arg0.wparams.downside_cap_bps = v0.downside_cap_bps;
        arg0.wparams.withdrawal_ttl_secs = v0.withdrawal_ttl_secs;
        arg0.wparams.system_penalty_bps = v0.system_penalty_bps;
        let v1 = WithdrawalParamsAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<WithdrawalParamsAcceptedEvent>(v1);
    }

    public fun accrue_management_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        let v0 = now_secs(arg1);
        let v1 = v0 - arg0.fees.last_mgmt_fee_ts;
        if (v1 == 0) {
            return
        };
        let v2 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::calculate_management_fee(arg0.total_shares, arg0.fees.management_fee_bps_per_year, v1);
        arg0.fees.last_mgmt_fee_ts = v0;
        if (v2 > 0) {
            let v3 = arg0.roles.accountant;
            add_user_shares<T0, T1>(arg0, v3, v2);
            arg0.total_shares = arg0.total_shares + v2;
            let v4 = ManagementFeeAccruedEvent{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                fee_shares : v2,
                accountant : v3,
            };
            0x2::event::emit<ManagementFeeAccruedEvent>(v4);
        };
    }

    public fun add_to_deposit_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg0.deposit_whitelist_enabled, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::whitelist_mode_not_enabled());
        let v0 = 0x2::table::contains<address, bool>(&arg0.deposit_whitelist, arg2) && *0x2::table::borrow<address, bool>(&arg0.deposit_whitelist, arg2);
        assert!(!v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        if (!0x2::table::contains<address, bool>(&arg0.deposit_whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.deposit_whitelist, arg2, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.deposit_whitelist, arg2) = true;
        };
    }

    public fun add_to_withdrawal_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdrawal_whitelist_enabled, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::whitelist_mode_not_enabled());
        let v0 = 0x2::table::contains<address, bool>(&arg0.withdrawal_whitelist, arg2) && *0x2::table::borrow<address, bool>(&arg0.withdrawal_whitelist, arg2);
        assert!(!v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        if (!0x2::table::contains<address, bool>(&arg0.withdrawal_whitelist, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.withdrawal_whitelist, arg2, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.withdrawal_whitelist, arg2) = true;
        };
    }

    fun add_user_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.share_balances, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.share_balances, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.share_balances, arg1, arg2);
        };
    }

    public fun allowlist_mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(is_mint_allowlisted<T0, T1>(arg0, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_paused());
        assert!(arg3 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_shares(arg0.total_shares, arg3, arg0.limits.max_total_shares);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_shares_per_user(get_user_shares<T0, T1>(arg0, arg2), arg3, arg0.limits.max_shares_per_user);
        add_user_shares<T0, T1>(arg0, arg2, arg3);
        arg0.total_shares = arg0.total_shares + arg3;
    }

    fun assert_accountant<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AccountantCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.accountant, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_admin<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.admin, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_asset_manager<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AssetManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.asset_manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_guardian<T0, T1>(arg0: &Vault<T0, T1>, arg1: &GuardianCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.guardian, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_manager<T0, T1>(arg0: &Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_not_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_paused());
    }

    fun assert_oracle<T0, T1>(arg0: &Vault<T0, T1>, arg1: &OracleCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.oracle, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_price_fresh<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) {
        if (arg0.pricing.last_price_update_ts == 0 || arg0.pricing.max_price_staleness_secs == 0) {
            return
        };
        assert!(arg1 <= arg0.pricing.last_price_update_ts + arg0.pricing.max_price_staleness_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::price_too_old());
    }

    fun assert_processor<T0, T1>(arg0: &Vault<T0, T1>, arg1: &ProcessorCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.roles.processor, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::wrong_version());
    }

    public fun attach_proxy_asset_manager<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap, arg2: &0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        let v0 = 0x2::object::id<0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        arg0.roles.asset_manager = 0x2::object::id_to_address(&v0);
    }

    public fun attach_treasury<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::TreasuryCap<T1>, arg3: &0x2::tx_context::TxContext) {
        abort 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::treasury_already_attached()
    }

    fun burn_locked_share_coins<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T1>(&mut arg0.treasury, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.locked_share_coins, arg1), arg2));
    }

    public fun cancel_allowlist_mint<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        if (0x2::table::contains<address, bool>(&arg0.allowlist_mint, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.allowlist_mint, arg2) = false;
        };
    }

    public fun cancel_withdrawal_after_ttl<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ProcessorCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_processor<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(0x2::table::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_request_not_found());
        let v0 = now_secs(arg3);
        let v1 = 0x2::table::borrow<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg2);
        assert!(is_withdrawal_pending(v1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v2 = v1.shares;
        let v3 = v1.fee_shares;
        let v4 = v1.amount_due;
        let v5 = v1.user;
        assert!(v0 >= v1.created_at + arg0.wparams.withdrawal_ttl_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_timestamp());
        let v6 = v2 + v3;
        let v7 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::apply_basis_points(v2, arg0.wparams.system_penalty_bps);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_shares(arg0.total_shares, v7, arg0.limits.max_total_shares);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_shares_per_user(get_user_shares<T0, T1>(arg0, v5), v6 + v7, arg0.limits.max_shares_per_user);
        add_user_shares<T0, T1>(arg0, v5, v6);
        if (v7 > 0) {
            add_user_shares<T0, T1>(arg0, v5, v7);
            arg0.total_shares = arg0.total_shares + v7;
        };
        transfer_locked_share_coins<T0, T1>(arg0, v5, v6, arg4);
        if (v7 > 0) {
            mint_share_coins<T0, T1>(arg0, v5, v7, arg4);
        };
        arg0.shares_in_custody = arg0.shares_in_custody - v2 + v3;
        assert!(arg0.total_withdrawals_pending >= v4, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::math_overflow());
        arg0.total_withdrawals_pending = arg0.total_withdrawals_pending - v4;
        let v8 = 0x2::table::borrow_mut<u64, WithdrawalRequest>(&mut arg0.withdrawal_requests, arg2);
        v8.status = 3;
        v8.processed_at = v0;
        let v9 = WithdrawCancelledEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            user           : v5,
            request_id     : arg2,
            penalty_shares : v7,
        };
        0x2::event::emit<WithdrawCancelledEvent>(v9);
    }

    public fun cancel_withdrawal_user<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(0x2::table::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_request_not_found());
        let v0 = now_secs(arg2);
        let v1 = 0x2::table::borrow<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1);
        assert!(is_withdrawal_pending(v1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v2 = v1.shares;
        let v3 = v1.fee_shares;
        let v4 = v1.amount_due;
        let v5 = v1.user;
        assert!(0x2::tx_context::sender(arg3) == v5, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        let v6 = 0;
        let v7 = 0;
        let v8 = if (!(v0 >= v1.created_at + arg0.wparams.withdrawal_ttl_secs)) {
            v6 = v3;
            v2
        } else {
            let v9 = v2 + v3;
            let v10 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::apply_basis_points(v2, arg0.wparams.system_penalty_bps);
            v7 = v10;
            0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_shares(arg0.total_shares, v10, arg0.limits.max_total_shares);
            0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_shares_per_user(get_user_shares<T0, T1>(arg0, v5), v9 + v10, arg0.limits.max_shares_per_user);
            v9
        };
        add_user_shares<T0, T1>(arg0, v5, v8);
        if (v7 > 0) {
            add_user_shares<T0, T1>(arg0, v5, v7);
            arg0.total_shares = arg0.total_shares + v7;
        };
        if (v6 > 0) {
            let v11 = arg0.roles.accountant;
            add_user_shares<T0, T1>(arg0, v11, v6);
        };
        let v12 = arg0.roles.accountant;
        transfer_locked_share_coins<T0, T1>(arg0, v5, v8, arg3);
        if (v6 > 0) {
            transfer_locked_share_coins<T0, T1>(arg0, v12, v6, arg3);
        };
        if (v7 > 0) {
            mint_share_coins<T0, T1>(arg0, v5, v7, arg3);
        };
        arg0.shares_in_custody = arg0.shares_in_custody - v2 + v3;
        assert!(arg0.total_withdrawals_pending >= v4, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::math_overflow());
        arg0.total_withdrawals_pending = arg0.total_withdrawals_pending - v4;
        let v13 = 0x2::table::borrow_mut<u64, WithdrawalRequest>(&mut arg0.withdrawal_requests, arg1);
        v13.status = 3;
        v13.processed_at = v0;
        let v14 = WithdrawCancelledEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            user           : v5,
            request_id     : arg1,
            penalty_shares : v7,
        };
        0x2::event::emit<WithdrawCancelledEvent>(v14);
    }

    public fun create_vault<T0, T1>(arg0: &mut 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::FactoryRegistry, arg1: &0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::FactoryAdminCap, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::assert_registry_matches_cap(arg0, arg1);
        create_vault_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    fun create_vault_impl<T0, T1>(arg0: &mut 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::FactoryRegistry, arg1: &0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::FactoryAdminCap, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::validate_fees(arg5, arg6, arg7);
        assert!(arg8 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_price());
        assert!(arg4 != 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg4 >= arg3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v0 = now_secs(arg15);
        let v1 = VaultPricing{
            price                    : arg8,
            last_price_update_ts     : 0,
            max_price_staleness_secs : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::default_max_price_staleness_secs(),
            max_deviation_bps        : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::default_max_deviation_bps(),
        };
        let v2 = VaultFees{
            deposit_fee_bps             : arg5,
            withdraw_fee_bps            : arg6,
            management_fee_bps_per_year : arg7,
            swap_fee_bps                : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::default_swap_fee_bps(),
            last_mgmt_fee_ts            : v0,
        };
        let v3 = VaultLimits{
            max_total_shares    : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::no_limit(),
            max_shares_per_user : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::no_limit(),
            max_total_idle      : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::no_limit(),
            min_shares_to_mint  : 0,
        };
        let v4 = VaultWithdrawalParams{
            downside_cap_bps    : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::default_downside_cap_bps(),
            withdrawal_ttl_secs : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::min_withdrawal_ttl_secs(),
            system_penalty_bps  : 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::default_system_penalty_bps(),
        };
        let v5 = VaultCooldowns{
            price_update_cooldown_secs     : 60,
            price_acceptance_cooldown_secs : 60,
            config_cooldown_secs           : 60,
            role_change_cooldown_secs      : 60,
            fee_change_cooldown_secs       : 60,
            emergency_withdrawal_cooldown  : 60,
        };
        let v6 = VaultRoles{
            admin         : arg9,
            manager       : arg10,
            processor     : arg11,
            oracle        : arg12,
            accountant    : arg13,
            asset_manager : arg14,
            guardian      : @0x0,
        };
        let v7 = VaultEmergency{
            emergency_timelock_end      : 0,
            emergency_withdrawal_amount : 0,
        };
        let v8 = VaultPending{
            price             : 0x1::option::none<PendingPrice>(),
            roles             : 0x1::option::none<PendingRoles>(),
            fees              : 0x1::option::none<PendingFees>(),
            limits            : 0x1::option::none<PendingLimits>(),
            whitelist         : 0x1::option::none<PendingWhitelist>(),
            cooldowns         : 0x1::option::none<PendingCooldowns>(),
            withdrawal_params : 0x1::option::none<PendingWithdrawalParams>(),
        };
        let v9 = Vault<T0, T1>{
            id                           : 0x2::object::new(arg16),
            version                      : 3,
            treasury                     : arg2,
            locked_share_coins           : 0x2::balance::zero<T1>(),
            underlying                   : 0x2::balance::zero<T0>(),
            total_shares                 : 0,
            shares_in_custody            : 0,
            total_withdrawals_pending    : 0,
            total_idle                   : 0,
            share_balances               : 0x2::table::new<address, u64>(arg16),
            pricing                      : v1,
            fees                         : v2,
            limits                       : v3,
            underlying_decimals          : arg3,
            share_decimals               : arg4,
            wparams                      : v4,
            next_withdrawal_id           : 1,
            cooldowns                    : v5,
            deposit_whitelist_enabled    : false,
            withdrawal_whitelist_enabled : false,
            paused                       : false,
            roles                        : v6,
            created_at                   : v0,
            emergency                    : v7,
            pending                      : v8,
            withdrawal_requests          : 0x2::table::new<u64, WithdrawalRequest>(arg16),
            deposit_whitelist            : 0x2::table::new<address, bool>(arg16),
            withdrawal_whitelist         : 0x2::table::new<address, bool>(arg16),
            allowlist_mint               : 0x2::table::new<address, bool>(arg16),
        };
        let v10 = 0x2::object::id<Vault<T0, T1>>(&v9);
        let v11 = AdminCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v12 = ManagerCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v13 = ProcessorCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v14 = OracleCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v15 = AccountantCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v16 = AssetManagerCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        let v17 = GuardianCap{
            id       : 0x2::object::new(arg16),
            vault_id : v10,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v9);
        0x2::transfer::public_transfer<AdminCap>(v11, arg9);
        0x2::transfer::public_transfer<ManagerCap>(v12, arg10);
        0x2::transfer::public_transfer<ProcessorCap>(v13, arg11);
        0x2::transfer::public_transfer<OracleCap>(v14, arg12);
        0x2::transfer::public_transfer<AccountantCap>(v15, arg13);
        0x2::transfer::public_transfer<AssetManagerCap>(v16, arg14);
        0x2::transfer::public_transfer<GuardianCap>(v17, arg10);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_factory::register_vault(arg0, arg1, v10, arg15);
        let v18 = VaultCreatedEvent{vault_id: v10};
        0x2::event::emit<VaultCreatedEvent>(v18);
    }

    public fun current_version() : u64 {
        3
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert_price_fresh<T0, T1>(arg0, now_secs(arg2));
        if (arg0.deposit_whitelist_enabled) {
            assert!(is_whitelisted(&arg0.deposit_whitelist, v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        };
        deposit_inner<T0, T1>(arg0, arg1, v0, 0, arg3);
    }

    public fun deposit_for<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert_price_fresh<T0, T1>(arg0, now_secs(arg4));
        assert!(arg2 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        if (arg0.deposit_whitelist_enabled) {
            assert!(is_whitelisted(&arg0.deposit_whitelist, 0x2::tx_context::sender(arg5)), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        };
        deposit_inner<T0, T1>(arg0, arg1, arg2, arg3, arg5);
    }

    fun deposit_inner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        let v1 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::amount_to_shares(v0, arg0.pricing.price, arg0.underlying_decimals, arg0.share_decimals);
        let v2 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::apply_basis_points(v1, arg0.fees.deposit_fee_bps);
        let v3 = v1 - v2;
        assert!(v3 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::zero_shares_calculated());
        if (arg3 > 0) {
            assert!(v3 >= arg3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::slippage_not_met());
        };
        let v4 = get_user_shares<T0, T1>(arg0, arg2);
        if (arg0.limits.min_shares_to_mint > 0) {
            let v5 = v4 + v3;
            if (v5 > 0 && v5 < arg0.limits.min_shares_to_mint) {
                abort 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::minimum_shares_not_met()
            };
        };
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_shares_per_user(v4, v3, arg0.limits.max_shares_per_user);
        let v6 = v3 + v2;
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_shares(arg0.total_shares, v6, arg0.limits.max_total_shares);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_idle(arg0.total_idle, v0, arg0.limits.max_total_idle);
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_idle = arg0.total_idle + v0;
        add_user_shares<T0, T1>(arg0, arg2, v3);
        if (v2 > 0) {
            let v7 = arg0.roles.accountant;
            add_user_shares<T0, T1>(arg0, v7, v2);
        };
        arg0.total_shares = arg0.total_shares + v6;
        let v8 = arg0.roles.accountant;
        mint_share_coins<T0, T1>(arg0, arg2, v3, arg4);
        if (v2 > 0) {
            mint_share_coins<T0, T1>(arg0, v8, v2, arg4);
        };
        let v9 = DepositEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            user     : arg2,
            amount   : v0,
            shares   : v3,
            fee      : v2,
        };
        0x2::event::emit<DepositEvent>(v9);
    }

    public fun deposit_underlying<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == @0x0) {
            0x2::tx_context::sender(arg5)
        } else {
            arg3
        };
        deposit_for<T0, T1>(arg0, arg1, v0, arg2, arg4, arg5);
    }

    public fun execute_emergency_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert!(arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_not_paused());
        assert!(arg0.emergency.emergency_withdrawal_amount > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        assert!(now_secs(arg3) >= arg0.emergency.emergency_timelock_end, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::emergency_withdrawal_timelock_active());
        let v0 = arg0.emergency.emergency_withdrawal_amount;
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        arg0.emergency.emergency_withdrawal_amount = 0;
        arg0.emergency.emergency_timelock_end = 0;
        if (v0 >= arg0.total_idle) {
            arg0.total_idle = 0;
        } else {
            arg0.total_idle = arg0.total_idle - v0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, v0), arg4), arg2);
        let v1 = EmergencyExecutedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : v0,
            to       : arg2,
        };
        0x2::event::emit<EmergencyExecutedEvent>(v1);
    }

    public fun fulfill_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ProcessorCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_processor<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(0x2::table::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_request_not_found());
        let v0 = 0x2::table::borrow<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg2);
        assert!(is_withdrawal_pending(v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v1 = v0.shares;
        let v2 = v0.fee_shares;
        let v3 = v0.amount_due;
        let v4 = v0.min_amount_out;
        let v5 = v0.price_at_request;
        let v6 = v0.user;
        let v7 = v0.receiver;
        let v8 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::shares_to_amount(v1, arg0.pricing.price, arg0.underlying_decimals, arg0.share_decimals);
        let v9 = if (v8 < v4) {
            v4
        } else if (arg0.pricing.price > v5) {
            v3
        } else {
            v8
        };
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= v9, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        assert!(v9 <= arg0.total_idle, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        arg0.total_idle = arg0.total_idle - v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, v9), arg4), v7);
        arg0.total_shares = arg0.total_shares - v1;
        arg0.shares_in_custody = arg0.shares_in_custody - v1 + v2;
        assert!(arg0.total_withdrawals_pending >= v3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::math_overflow());
        arg0.total_withdrawals_pending = arg0.total_withdrawals_pending - v3;
        if (v2 > 0) {
            let v10 = arg0.roles.accountant;
            transfer_locked_share_coins<T0, T1>(arg0, v10, v2, arg4);
        };
        burn_locked_share_coins<T0, T1>(arg0, v1, arg4);
        let v11 = 0x2::table::borrow_mut<u64, WithdrawalRequest>(&mut arg0.withdrawal_requests, arg2);
        v11.status = 2;
        v11.processed_at = now_secs(arg3);
        let v12 = WithdrawFulfilledEvent{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
            user       : v6,
            request_id : arg2,
            amount     : v9,
            fee        : v2,
        };
        0x2::event::emit<WithdrawFulfilledEvent>(v12);
    }

    public fun get_accountant<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.accountant
    }

    public fun get_admin<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.admin
    }

    public fun get_asset_manager<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.asset_manager
    }

    public fun get_created_at<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.created_at
    }

    public fun get_deposit_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fees.deposit_fee_bps
    }

    public fun get_guardian<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.guardian
    }

    public fun get_last_price_update_ts<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pricing.last_price_update_ts
    }

    public fun get_management_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fees.management_fee_bps_per_year
    }

    public fun get_manager<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.manager
    }

    public fun get_max_deviation_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pricing.max_deviation_bps
    }

    public fun get_max_price_staleness<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pricing.max_price_staleness_secs
    }

    public fun get_max_shares_per_user<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.limits.max_shares_per_user
    }

    public fun get_max_total_idle<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.limits.max_total_idle
    }

    public fun get_max_total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.limits.max_total_shares
    }

    public fun get_min_shares_to_mint<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.limits.min_shares_to_mint
    }

    public fun get_next_withdrawal_id<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.next_withdrawal_id
    }

    public fun get_oracle<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.roles.oracle
    }

    public fun get_price<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.pricing.price
    }

    public fun get_share_decimals<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.share_decimals
    }

    public fun get_swap_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fees.swap_fee_bps
    }

    public fun get_underlying_decimals<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.underlying_decimals
    }

    fun get_user_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.share_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.share_balances, arg1)
        } else {
            0
        }
    }

    public fun get_withdraw_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fees.withdraw_fee_bps
    }

    public fun get_withdrawal_request<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (address, address, u64, u64, u64, u64, u64, u64, u8, u64) {
        assert!(0x2::table::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_request_not_found());
        let v0 = 0x2::table::borrow<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1);
        (v0.user, v0.receiver, v0.shares, v0.amount_due, v0.min_amount_out, v0.fee_shares, v0.price_at_request, v0.created_at, v0.status, v0.processed_at)
    }

    public fun has_pending_fees<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<PendingFees>(&arg0.pending.fees)
    }

    public fun has_pending_limits<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<PendingLimits>(&arg0.pending.limits)
    }

    public fun has_pending_price<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<PendingPrice>(&arg0.pending.price)
    }

    public fun has_pending_roles<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<PendingRoles>(&arg0.pending.roles)
    }

    public fun has_treasury<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        true
    }

    public fun initiate_emergency_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert!(arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_not_paused());
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        arg0.emergency.emergency_timelock_end = now_secs(arg3) + arg0.cooldowns.emergency_withdrawal_cooldown;
        arg0.emergency.emergency_withdrawal_amount = arg2;
        let v0 = EmergencyInitiatedEvent{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount       : arg2,
            timelock_end : arg0.emergency.emergency_timelock_end,
        };
        0x2::event::emit<EmergencyInitiatedEvent>(v0);
    }

    public fun is_deposit_whitelisted<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        is_whitelisted(&arg0.deposit_whitelist, arg1)
    }

    public fun is_mint_allowlisted<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowlist_mint, arg1) && *0x2::table::borrow<address, bool>(&arg0.allowlist_mint, arg1)
    }

    public fun is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    fun is_whitelisted(arg0: &0x2::table::Table<address, bool>, arg1: address) : bool {
        0x2::table::contains<address, bool>(arg0, arg1) && *0x2::table::borrow<address, bool>(arg0, arg1)
    }

    fun is_withdrawal_pending(arg0: &WithdrawalRequest) : bool {
        arg0.status == 1
    }

    public fun is_withdrawal_whitelisted<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        is_whitelisted(&arg0.withdrawal_whitelist, arg1)
    }

    fun lock_share_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.locked_share_coins, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun manager_cap_matches_vault<T0, T1>(arg0: &ManagerCap, arg1: &Vault<T0, T1>) : bool {
        arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1)
    }

    public fun migrate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg2);
        assert!(arg0.version < 3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::not_upgrade());
        arg0.version = 3;
    }

    fun mint_share_coins<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg0.treasury, arg2, arg3), arg1);
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun pause_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &GuardianCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(arg2.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.roles.manager || v0 == arg0.roles.guardian, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_paused());
        arg0.paused = true;
        let v1 = VaultPausedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<VaultPausedEvent>(v1);
    }

    public fun process_deposits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ProcessorCap, arg2: &mut 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_processor<T0, T1>(arg0, arg1, arg5);
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::get_vault_id<T0>(arg2) == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        let v0 = 0x2::object::id<0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>>(arg2);
        assert!(0x2::object::id_to_address(&v0) == arg0.roles.asset_manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(arg3 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        assert!(arg3 <= arg0.total_idle, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        arg0.total_idle = arg0.total_idle - arg3;
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::accept_underlying<T0>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg3), arg5));
        let v1 = ProcessDepositsEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : arg3,
            to       : arg0.roles.asset_manager,
        };
        0x2::event::emit<ProcessDepositsEvent>(v1);
    }

    public fun propose_cooldowns<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg9);
        assert_version<T0, T1>(arg0);
        let v0 = if (0x1::option::is_none<PendingFees>(&arg0.pending.fees)) {
            if (0x1::option::is_none<PendingLimits>(&arg0.pending.limits)) {
                if (0x1::option::is_none<PendingWhitelist>(&arg0.pending.whitelist)) {
                    0x1::option::is_none<PendingRoles>(&arg0.pending.roles)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::cooldown_change_timelock_active());
        let v1 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::min_cooldown_secs();
        let v2 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::max_cooldown_secs();
        assert!(arg2 >= v1 && arg2 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg3 >= v1 && arg3 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg4 >= v1 && arg4 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg5 >= v1 && arg5 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg6 >= v1 && arg6 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg7 >= v1 && arg7 <= v2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v3 = if (arg2 != arg0.cooldowns.price_update_cooldown_secs) {
            true
        } else if (arg3 != arg0.cooldowns.price_acceptance_cooldown_secs) {
            true
        } else if (arg4 != arg0.cooldowns.config_cooldown_secs) {
            true
        } else if (arg5 != arg0.cooldowns.role_change_cooldown_secs) {
            true
        } else if (arg6 != arg0.cooldowns.fee_change_cooldown_secs) {
            true
        } else {
            arg7 != arg0.cooldowns.emergency_withdrawal_cooldown
        };
        assert!(v3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        let v4 = PendingCooldowns{
            price_update_cooldown_secs     : arg2,
            price_acceptance_cooldown_secs : arg3,
            config_cooldown_secs           : arg4,
            role_change_cooldown_secs      : arg5,
            fee_change_cooldown_secs       : arg6,
            emergency_withdrawal_cooldown  : arg7,
            proposed_at                    : now_secs(arg8),
        };
        arg0.pending.cooldowns = 0x1::option::some<PendingCooldowns>(v4);
        let v5 = CooldownsProposedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<CooldownsProposedEvent>(v5);
    }

    public fun propose_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg7);
        assert_version<T0, T1>(arg0);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::validate_fees(arg2, arg3, arg4);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::validate_swap_fee(arg5);
        let v0 = if (arg2 != arg0.fees.deposit_fee_bps) {
            true
        } else if (arg3 != arg0.fees.withdraw_fee_bps) {
            true
        } else if (arg4 != arg0.fees.management_fee_bps_per_year) {
            true
        } else {
            arg5 != arg0.fees.swap_fee_bps
        };
        assert!(v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        let v1 = PendingFees{
            deposit_fee_bps             : arg2,
            withdraw_fee_bps            : arg3,
            management_fee_bps_per_year : arg4,
            swap_fee_bps                : arg5,
            proposed_at                 : now_secs(arg6),
        };
        arg0.pending.fees = 0x1::option::some<PendingFees>(v1);
        let v2 = FeesProposedEvent{
            vault_id                    : 0x2::object::id<Vault<T0, T1>>(arg0),
            deposit_fee_bps             : arg2,
            withdraw_fee_bps            : arg3,
            management_fee_bps_per_year : arg4,
            swap_fee_bps                : arg5,
        };
        0x2::event::emit<FeesProposedEvent>(v2);
    }

    public fun propose_limits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg8);
        assert_version<T0, T1>(arg0);
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::validate_new_limits(arg2, arg3, arg4, arg6);
        assert!(arg5 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::max_allowed_deviation_bps(), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v0 = if (arg2 != arg0.limits.max_total_shares) {
            true
        } else if (arg3 != arg0.limits.max_shares_per_user) {
            true
        } else if (arg4 != arg0.limits.max_total_idle) {
            true
        } else if (arg5 != arg0.pricing.max_deviation_bps) {
            true
        } else {
            arg6 != arg0.limits.min_shares_to_mint
        };
        assert!(v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        let v1 = PendingLimits{
            max_total_shares    : arg2,
            max_shares_per_user : arg3,
            max_total_idle      : arg4,
            max_deviation_bps   : arg5,
            min_shares_to_mint  : arg6,
            proposed_at         : now_secs(arg7),
        };
        arg0.pending.limits = 0x1::option::some<PendingLimits>(v1);
        let v2 = LimitsProposedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<LimitsProposedEvent>(v2);
    }

    public fun propose_roles<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg9);
        assert_version<T0, T1>(arg0);
        let v0 = if (arg2 != arg0.roles.manager) {
            true
        } else if (arg3 != arg0.roles.processor) {
            true
        } else if (arg4 != arg0.roles.oracle) {
            true
        } else if (arg5 != arg0.roles.accountant) {
            true
        } else if (arg6 != arg0.roles.asset_manager) {
            true
        } else {
            arg7 != arg0.roles.guardian
        };
        assert!(v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        let v1 = PendingRoles{
            admin         : arg0.roles.admin,
            manager       : arg2,
            processor     : arg3,
            oracle        : arg4,
            accountant    : arg5,
            asset_manager : arg6,
            guardian      : arg7,
            proposed_at   : now_secs(arg8),
        };
        arg0.pending.roles = 0x1::option::some<PendingRoles>(v1);
        let v2 = RolesProposedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<RolesProposedEvent>(v2);
    }

    public fun propose_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg5);
        assert_version<T0, T1>(arg0);
        assert!(arg2 != arg0.deposit_whitelist_enabled || arg3 != arg0.withdrawal_whitelist_enabled, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        let v0 = PendingWhitelist{
            deposit_whitelist_enabled    : arg2,
            withdrawal_whitelist_enabled : arg3,
            proposed_at                  : now_secs(arg4),
        };
        arg0.pending.whitelist = 0x1::option::some<PendingWhitelist>(v0);
        let v1 = WhitelistProposedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<WhitelistProposedEvent>(v1);
    }

    public fun propose_withdrawal_params<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg6);
        assert_version<T0, T1>(arg0);
        assert!(arg3 >= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::min_withdrawal_ttl_secs() && arg3 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::max_withdrawal_ttl_secs(), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg2 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::bps_precision(), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg4 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::bps_precision(), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v0 = PendingWithdrawalParams{
            downside_cap_bps    : arg2,
            withdrawal_ttl_secs : arg3,
            system_penalty_bps  : arg4,
            proposed_at         : now_secs(arg5),
        };
        arg0.pending.withdrawal_params = 0x1::option::some<PendingWithdrawalParams>(v0);
        let v1 = WithdrawalParamsProposedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<WithdrawalParamsProposedEvent>(v1);
    }

    public fun reject_price<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg2);
        assert_version<T0, T1>(arg0);
        assert!(0x1::option::is_some<PendingPrice>(&arg0.pending.price), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::no_pending_price());
        let v0 = 0x1::option::extract<PendingPrice>(&mut arg0.pending.price);
        let v1 = PriceRejectedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            price    : v0.price,
        };
        0x2::event::emit<PriceRejectedEvent>(v1);
    }

    public fun remove_from_deposit_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg0.deposit_whitelist_enabled, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::whitelist_mode_not_enabled());
        assert!(0x2::table::contains<address, bool>(&arg0.deposit_whitelist, arg2) && *0x2::table::borrow<address, bool>(&arg0.deposit_whitelist, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        *0x2::table::borrow_mut<address, bool>(&mut arg0.deposit_whitelist, arg2) = false;
    }

    public fun remove_from_withdrawal_whitelist<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdrawal_whitelist_enabled, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::whitelist_mode_not_enabled());
        assert!(0x2::table::contains<address, bool>(&arg0.withdrawal_whitelist, arg2) && *0x2::table::borrow<address, bool>(&arg0.withdrawal_whitelist, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        *0x2::table::borrow_mut<address, bool>(&mut arg0.withdrawal_whitelist, arg2) = false;
    }

    public fun return_funds<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AssetManagerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_asset_manager<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_idle = arg0.total_idle + v0;
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg0.total_idle, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        let v1 = ReturnFundsEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<ReturnFundsEvent>(v1);
    }

    public fun return_funds_from_proxy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>, arg2: &0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyProcessorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::get_processor_cap_proxy_id(arg2) == 0x2::object::id<0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>>(arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::get_vault_id<T0>(arg1) == 0x2::object::id<Vault<T0, T1>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        let v0 = 0x2::object::id<0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::ProxyAssetManager<T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == arg0.roles.asset_manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg5) == 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_proxy::get_processor<T0>(arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg3));
        arg0.total_idle = arg0.total_idle + v1;
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg0.total_idle, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        let v2 = ReturnFundsEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : v1,
        };
        0x2::event::emit<ReturnFundsEvent>(v2);
    }

    public fun share_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        get_user_shares<T0, T1>(arg0, arg1)
    }

    public fun shares_in_custody<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.shares_in_custody
    }

    fun sub_user_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.share_balances, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_shares());
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.share_balances, arg1);
        assert!(*v0 >= arg2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_shares());
        *v0 = *v0 - arg2;
    }

    public fun swap_tokens<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &mut Vault<T0, T2>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) != 0x2::object::id<Vault<T0, T2>>(arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_swap_same_vault());
        assert!(arg0.roles.asset_manager == arg1.roles.asset_manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::asset_manager_mismatch());
        assert_version<T0, T1>(arg0);
        assert_version<T0, T2>(arg1);
        assert!(arg0.share_decimals == arg1.share_decimals, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert_not_paused<T0, T1>(arg0);
        assert_not_paused<T0, T2>(arg1);
        let v1 = now_secs(arg4);
        assert_price_fresh<T0, T1>(arg0, v1);
        assert_price_fresh<T0, T2>(arg1, v1);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        let v2 = 0x2::object::id<Vault<T0, T2>>(arg1);
        assert!(is_mint_allowlisted<T0, T1>(arg0, 0x2::object::id_to_address(&v2)), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::destination_not_allowlisted());
        if (arg0.withdrawal_whitelist_enabled) {
            assert!(is_whitelisted(&arg0.withdrawal_whitelist, v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        };
        if (arg1.deposit_whitelist_enabled) {
            assert!(is_whitelisted(&arg1.deposit_whitelist, v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        };
        sub_user_shares<T0, T1>(arg0, v0, arg2);
        arg0.total_shares = arg0.total_shares - arg2;
        let v3 = get_user_shares<T0, T1>(arg0, v0);
        if (arg0.limits.min_shares_to_mint > 0 && v3 > 0) {
            assert!(v3 >= arg0.limits.min_shares_to_mint, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::minimum_shares_not_met());
        };
        let v4 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::shares_to_amount(arg2, arg0.pricing.price, arg0.underlying_decimals, arg0.share_decimals);
        let v5 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::apply_basis_points(v4, arg0.fees.swap_fee_bps);
        let v6 = v5 / 2;
        let v7 = v5 - v6;
        let v8 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::amount_to_shares(v4 - v5, arg1.pricing.price, arg1.underlying_decimals, arg1.share_decimals);
        assert!(v8 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::zero_shares_calculated());
        assert!(v8 >= arg3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::slippage_not_met());
        let v9 = if (v7 > 0) {
            0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::amount_to_shares(v7, arg1.pricing.price, arg1.underlying_decimals, arg1.share_decimals)
        } else {
            0
        };
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_total_shares(arg1.total_shares, v8 + v9, arg1.limits.max_total_shares);
        let v10 = get_user_shares<T0, T2>(arg1, v0);
        let v11 = v10 + v8;
        if (arg1.limits.min_shares_to_mint > 0 && v11 > 0) {
            assert!(v11 >= arg1.limits.min_shares_to_mint, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::minimum_shares_not_met());
        };
        0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::check_max_shares_per_user(v10, v8, arg1.limits.max_shares_per_user);
        add_user_shares<T0, T2>(arg1, v0, v8);
        arg1.total_shares = arg1.total_shares + v8;
        if (v6 > 0) {
            let v12 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::amount_to_shares(v6, arg0.pricing.price, arg0.underlying_decimals, arg0.share_decimals);
            if (v12 > 0) {
                let v13 = arg0.roles.accountant;
                add_user_shares<T0, T1>(arg0, v13, v12);
                arg0.total_shares = arg0.total_shares + v12;
            };
        };
        if (v9 > 0) {
            let v14 = arg1.roles.accountant;
            add_user_shares<T0, T2>(arg1, v14, v9);
            arg1.total_shares = arg1.total_shares + v9;
        };
    }

    public fun total_idle<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_idle
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun total_withdrawals_pending<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_withdrawals_pending
    }

    public fun transfer_admin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg2 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg2 != arg0.roles.admin, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::governance_no_op());
        arg0.roles.admin = arg2;
        let v0 = RolesAcceptedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<RolesAcceptedEvent>(v0);
    }

    fun transfer_locked_share_coins<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.locked_share_coins, arg2), arg3), arg1);
    }

    public fun transfer_share_coins<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        sub_user_shares<T0, T1>(arg0, 0x2::tx_context::sender(arg3), v0);
        add_user_shares<T0, T1>(arg0, arg2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg2);
    }

    public fun underlying_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.underlying)
    }

    public fun unpause_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg3);
        assert_version<T0, T1>(arg0);
        assert!(arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_not_paused());
        arg0.paused = false;
        arg0.emergency.emergency_timelock_end = 0;
        arg0.emergency.emergency_withdrawal_amount = 0;
        let v0 = VaultUnpausedEvent{vault_id: 0x2::object::id<Vault<T0, T1>>(arg0)};
        0x2::event::emit<VaultUnpausedEvent>(v0);
    }

    public fun unwrap_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        0x2::coin::burn<T1>(&mut arg0.treasury, arg1);
        add_user_shares<T0, T1>(arg0, 0x2::tx_context::sender(arg2), v0);
    }

    public fun update_price<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &OracleCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_oracle<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_price());
        let v0 = now_secs(arg3);
        assert!(v0 >= arg0.pricing.last_price_update_ts + arg0.cooldowns.price_update_cooldown_secs, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::price_update_too_frequent());
        if (arg0.pricing.max_deviation_bps == 0 || arg0.cooldowns.price_acceptance_cooldown_secs == 0) {
            arg0.pricing.price = arg2;
            arg0.pricing.last_price_update_ts = v0;
            arg0.pending.price = 0x1::option::none<PendingPrice>();
            let v1 = PriceUpdatedEvent{
                vault_id      : 0x2::object::id<Vault<T0, T1>>(arg0),
                old_price     : arg0.pricing.price,
                new_price     : arg2,
                auto_accepted : true,
            };
            0x2::event::emit<PriceUpdatedEvent>(v1);
            return
        };
        if (0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::calculate_price_deviation(arg0.pricing.price, arg2) <= arg0.pricing.max_deviation_bps) {
            arg0.pricing.price = arg2;
            arg0.pricing.last_price_update_ts = v0;
            arg0.pending.price = 0x1::option::none<PendingPrice>();
            let v2 = PriceUpdatedEvent{
                vault_id      : 0x2::object::id<Vault<T0, T1>>(arg0),
                old_price     : arg0.pricing.price,
                new_price     : arg2,
                auto_accepted : true,
            };
            0x2::event::emit<PriceUpdatedEvent>(v2);
        } else {
            let v3 = PendingPrice{
                price       : arg2,
                proposed_at : v0,
            };
            arg0.pending.price = 0x1::option::some<PendingPrice>(v3);
            let v4 = PricePendingEvent{
                vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
                proposed_price : arg2,
                current_price  : arg0.pricing.price,
            };
            0x2::event::emit<PricePendingEvent>(v4);
        };
    }

    public fun update_withdrawal_minimum<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(0x2::table::contains<u64, WithdrawalRequest>(&arg0.withdrawal_requests, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_request_not_found());
        let v0 = 0x2::table::borrow_mut<u64, WithdrawalRequest>(&mut arg0.withdrawal_requests, arg1);
        assert!(is_withdrawal_pending(v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(v0.user == 0x2::tx_context::sender(arg4), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(arg2 <= v0.min_amount_out, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        v0.min_amount_out = arg2;
    }

    public fun withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::treasury_attached_use_coin_withdraw()
    }

    fun withdraw_request_inner<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        let v0 = now_secs(arg3);
        assert_price_fresh<T0, T1>(arg0, v0);
        let v1 = 0x2::tx_context::sender(arg4);
        if (arg0.withdrawal_whitelist_enabled) {
            assert!(is_whitelisted(&arg0.withdrawal_whitelist, v1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::user_not_whitelisted());
        };
        assert!(arg1 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        let v2 = get_user_shares<T0, T1>(arg0, v1) - arg1;
        if (arg0.limits.min_shares_to_mint > 0 && v2 > 0) {
            assert!(arg1 >= arg0.limits.min_shares_to_mint, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::withdrawal_amount_too_low());
            assert!(v2 >= arg0.limits.min_shares_to_mint, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::minimum_shares_not_met());
        };
        let (v3, v4) = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::apply_fee(arg1, arg0.fees.withdraw_fee_bps);
        let v5 = 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::shares_to_amount(v3, arg0.pricing.price, arg0.underlying_decimals, arg0.share_decimals);
        assert!(arg2 <= v5, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        if (arg2 > 0) {
            assert!(arg2 <= 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::mul_div(v5, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::bps_precision() - arg0.wparams.downside_cap_bps, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_math::bps_precision()), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        };
        sub_user_shares<T0, T1>(arg0, v1, arg1);
        arg0.shares_in_custody = arg0.shares_in_custody + arg1;
        arg0.total_withdrawals_pending = arg0.total_withdrawals_pending + v5;
        let v6 = arg0.next_withdrawal_id;
        arg0.next_withdrawal_id = arg0.next_withdrawal_id + 1;
        let v7 = WithdrawalRequest{
            user             : v1,
            receiver         : v1,
            shares           : v3,
            amount_due       : v5,
            min_amount_out   : arg2,
            fee_shares       : v4,
            price_at_request : arg0.pricing.price,
            created_at       : v0,
            status           : 1,
            processed_at     : 0,
        };
        0x2::table::add<u64, WithdrawalRequest>(&mut arg0.withdrawal_requests, v6, v7);
        let v8 = WithdrawRequestEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            user           : v1,
            request_id     : v6,
            shares         : v3,
            min_amount_out : arg2,
        };
        0x2::event::emit<WithdrawRequestEvent>(v8);
    }

    public fun withdraw_request_with_share_coin<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        lock_share_coin<T0, T1>(arg0, arg1);
        withdraw_request_inner<T0, T1>(arg0, v0, arg2, arg3, arg4);
    }

    public fun withdraw_unexpected_deposits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &ManagerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0, T1>(arg0, arg1, arg4);
        assert_version<T0, T1>(arg0);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        let v0 = 0x2::balance::value<T0>(&arg0.underlying);
        let v1 = if (v0 > arg0.total_idle) {
            v0 - arg0.total_idle
        } else {
            0
        };
        assert!(arg2 <= v1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::insufficient_vault_funds());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg4), arg3);
        let v2 = UnexpectedDepositsWithdrawnEvent{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : arg2,
            to       : arg3,
        };
        0x2::event::emit<UnexpectedDepositsWithdrawnEvent>(v2);
    }

    public fun wrap_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
        assert!(arg1 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_amount());
        sub_user_shares<T0, T1>(arg0, 0x2::tx_context::sender(arg2), arg1);
        0x2::coin::mint<T1>(&mut arg0.treasury, arg1, arg2)
    }

    public fun wrapped_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury)
    }

    public fun write_vault_total_shares<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(is_mint_allowlisted<T0, T1>(arg0, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_paused());
        arg0.total_shares = arg2;
    }

    // decompiled from Move bytecode v7
}

