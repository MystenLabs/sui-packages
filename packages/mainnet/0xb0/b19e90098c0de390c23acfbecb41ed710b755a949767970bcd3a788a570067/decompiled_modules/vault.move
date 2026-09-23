module 0xb0b19e90098c0de390c23acfbecb41ed710b755a949767970bcd3a788a570067::vault {
    struct VaultPairKey has copy, drop, store {
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<VaultPairKey, vector<0x2::object::ID>>,
        share_types: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        extra: 0x2::bag::Bag,
        version: u64,
        paused: bool,
    }

    struct RegistryPausedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        paused: bool,
    }

    struct VaultAdminCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct PendingVaultAdminTransfer has key {
        id: 0x2::object::UID,
        vault_admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
        accept_after_ms: u64,
    }

    struct StrategyConfig has copy, drop, store {
        num_bins: u32,
        rebalance_trigger_bins: u32,
        rebalance_cooldown_secs: u64,
        max_center_drift: u32,
        calm_zone_bins: u32,
        twap_seconds: u64,
    }

    struct PendingKeeper has copy, drop, store {
        keeper: address,
        eta_ms: u64,
    }

    struct PendingStrategyConfig has copy, drop, store {
        config: StrategyConfig,
        eta_ms: u64,
    }

    struct PendingDepositCap has copy, drop, store {
        deposit_cap: u64,
        eta_ms: u64,
    }

    struct PendingEmergencyGuardian has copy, drop, store {
        guardian: address,
        eta_ms: u64,
    }

    struct VaultConfigState has drop, store {
        strategy_config: StrategyConfig,
        pending_strategy_config: 0x1::option::Option<PendingStrategyConfig>,
        deposit_cap: u64,
        pending_deposit_cap: 0x1::option::Option<PendingDepositCap>,
    }

    struct VaultPauseState has drop, store {
        op_state: u8,
    }

    struct VaultMetrics has drop, store {
        last_rebalance_ts: u64,
        total_rebalances: u64,
    }

    struct VaultAdminState has drop, store {
        authorized_keeper: address,
        pending_keeper: 0x1::option::Option<PendingKeeper>,
        keeper_initialized: bool,
        bootstrapper: address,
        emergency_guardian: address,
        pending_emergency_guardian: 0x1::option::Option<PendingEmergencyGuardian>,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        pool_id: 0x2::object::ID,
        share_supply: 0x2::balance::Supply<T2>,
        position: 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        config: VaultConfigState,
        pause: VaultPauseState,
        metrics: VaultMetrics,
        admin_state: VaultAdminState,
        seq_no: u64,
        extra: 0x2::bag::Bag,
    }

    struct RedeemPlan has drop {
        shares: u64,
        supply: u64,
        idle_x: u64,
        idle_y: u64,
        bin_ids: vector<u32>,
        bin_shares: vector<u128>,
        bins_closed: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        coin_type_share: 0x1::type_name::TypeName,
        num_bins: u32,
        rebalance_trigger_bins: u32,
    }

    struct VaultRegistryMigratedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct VaultMigratedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount_x: u64,
        amount_y: u64,
        shares_minted: u64,
        total_supply_after: u64,
        total_x_after: u64,
        total_y_after: u64,
        seq: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        amount_x: u64,
        amount_y: u64,
        bins_closed: u64,
        total_supply_after: u64,
        total_x_after: u64,
        total_y_after: u64,
        seq: u64,
    }

    struct VaultAdminTransferProposedEvent has copy, drop {
        pending_transfer_id: 0x2::object::ID,
        vault_admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
        accept_after_ms: u64,
    }

    struct VaultAdminTransferAcceptedEvent has copy, drop {
        vault_admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        recipient: address,
    }

    struct VaultAdminTransferCancelledEvent has copy, drop {
        vault_admin_cap_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        proposer: address,
    }

    struct StrategyConfigProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        eta_ms: u64,
        num_bins: u32,
        rebalance_trigger_bins: u32,
        rebalance_cooldown_secs: u64,
        max_center_drift: u32,
        calm_zone_bins: u32,
        twap_seconds: u64,
    }

    struct StrategyConfigAppliedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        num_bins: u32,
        rebalance_trigger_bins: u32,
        rebalance_cooldown_secs: u64,
        max_center_drift: u32,
        calm_zone_bins: u32,
        twap_seconds: u64,
    }

    struct VaultPauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
        is_paused: bool,
    }

    struct VaultStateChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        op_state: u8,
    }

    struct DepositCapProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_cap: u64,
        eta_ms: u64,
    }

    struct DepositCapAppliedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_cap: u64,
    }

    struct EmergencyGuardianProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        guardian: address,
        eta_ms: u64,
    }

    struct EmergencyGuardianAppliedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        guardian: address,
    }

    struct EmergencyGuardianCancelledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        guardian: address,
    }

    struct KeeperProposedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
        eta_ms: u64,
    }

    struct KeeperAppliedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
    }

    struct KeeperCancelledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
    }

    struct BootstrapperUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_bootstrapper: address,
        new_bootstrapper: address,
    }

    public fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<T2>(&arg0.share_supply)
    }

    public fun is_paused<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        !is_normal_state<T0, T1, T2>(arg0)
    }

    public fun accept_vault_admin(arg0: PendingVaultAdminTransfer, arg1: 0x2::transfer::Receiving<VaultAdminCap>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let PendingVaultAdminTransfer {
            id                 : v0,
            vault_admin_cap_id : v1,
            vault_id           : v2,
            proposer           : _,
            recipient          : v4,
            accept_after_ms    : v5,
        } = arg0;
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg3) == v4, 29);
        assert!(0x2::clock::timestamp_ms(arg2) >= v5, 35);
        assert!(0x2::transfer::receiving_object_id<VaultAdminCap>(&arg1) == v1, 31);
        0x2::object::delete(v6);
        let v7 = VaultAdminTransferAcceptedEvent{
            vault_admin_cap_id : v1,
            vault_id           : v2,
            recipient          : v4,
        };
        0x2::event::emit<VaultAdminTransferAcceptedEvent>(v7);
        0x2::transfer::transfer<VaultAdminCap>(0x2::transfer::receive<VaultAdminCap>(&mut v6, arg1), v4);
    }

    public fun apply_authorized_keeper<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(0x1::option::is_some<PendingKeeper>(&arg1.admin_state.pending_keeper), 34);
        let PendingKeeper {
            keeper : v0,
            eta_ms : v1,
        } = 0x1::option::extract<PendingKeeper>(&mut arg1.admin_state.pending_keeper);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 32);
        arg1.admin_state.authorized_keeper = v0;
        arg1.admin_state.keeper_initialized = true;
        let v2 = KeeperAppliedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            keeper   : v0,
        };
        0x2::event::emit<KeeperAppliedEvent>(v2);
    }

    public fun apply_deposit_cap<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(0x1::option::is_some<PendingDepositCap>(&arg1.config.pending_deposit_cap), 37);
        let PendingDepositCap {
            deposit_cap : v0,
            eta_ms      : v1,
        } = 0x1::option::extract<PendingDepositCap>(&mut arg1.config.pending_deposit_cap);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 32);
        arg1.config.deposit_cap = v0;
        let v2 = DepositCapAppliedEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            deposit_cap : v0,
        };
        0x2::event::emit<DepositCapAppliedEvent>(v2);
    }

    public fun apply_emergency_guardian<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(0x1::option::is_some<PendingEmergencyGuardian>(&arg1.admin_state.pending_emergency_guardian), 40);
        let PendingEmergencyGuardian {
            guardian : v0,
            eta_ms   : v1,
        } = 0x1::option::extract<PendingEmergencyGuardian>(&mut arg1.admin_state.pending_emergency_guardian);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 32);
        arg1.admin_state.emergency_guardian = v0;
        let v2 = EmergencyGuardianAppliedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            guardian : v0,
        };
        0x2::event::emit<EmergencyGuardianAppliedEvent>(v2);
    }

    public fun apply_strategy_config<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert_pool_matches<T0, T1, T2>(arg1, arg2);
        assert!(0x1::option::is_some<PendingStrategyConfig>(&arg1.config.pending_strategy_config), 36);
        let PendingStrategyConfig {
            config : v0,
            eta_ms : v1,
        } = 0x1::option::extract<PendingStrategyConfig>(&mut arg1.config.pending_strategy_config);
        let v2 = v0;
        assert!(0x2::clock::timestamp_ms(arg3) >= v1, 32);
        let v3 = checked_strategy_config(v2.num_bins, v2.rebalance_trigger_bins, v2.rebalance_cooldown_secs, v2.max_center_drift, v2.calm_zone_bins, v2.twap_seconds);
        let v4 = arg1.config.strategy_config.calm_zone_bins > 0 && v3.calm_zone_bins == 0;
        assert!(!v4, 42);
        assert_calm_price_limit<T0, T1>(arg2, v3.calm_zone_bins);
        arg1.config.strategy_config = v3;
        let v5 = StrategyConfigAppliedEvent{
            vault_id                : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            num_bins                : v3.num_bins,
            rebalance_trigger_bins  : v3.rebalance_trigger_bins,
            rebalance_cooldown_secs : v3.rebalance_cooldown_secs,
            max_center_drift        : v3.max_center_drift,
            calm_zone_bins          : v3.calm_zone_bins,
            twap_seconds            : v3.twap_seconds,
        };
        0x2::event::emit<StrategyConfigAppliedEvent>(v5);
    }

    public(friend) fun assert_admin<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &Vault<T0, T1, T2>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg1), 4);
    }

    public(friend) fun assert_admin_versioned<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &Vault<T0, T1, T2>) {
        assert_admin<T0, T1, T2>(arg0, arg1);
        assert!(arg1.version == 3, 18);
    }

    fun assert_calm_price_limit<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: u32) {
        let v0 = 1000000000000000000;
        let v1 = v0;
        let v2 = 0;
        while (v2 < arg1) {
            v1 = 0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_ceil(v1, (10000 as u128) + (0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::bin_step_val<T0, T1>(arg0) as u128), (10000 as u128));
            assert!(v1 <= v0 * ((10000 + 500) as u128) / (10000 as u128), 42);
            v2 = v2 + 1;
        };
    }

    public(friend) fun assert_guardian<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin_state.emergency_guardian != @0x0, 39);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin_state.emergency_guardian, 39);
    }

    public(friend) fun assert_keeper<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin_state.authorized_keeper != @0x0, 15);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin_state.authorized_keeper, 15);
    }

    public fun assert_pool_matches<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) {
        0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::assert_pool_version<T0, T1>(arg1);
        assert!(0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 43);
    }

    public fun assert_registry_not_paused(arg0: &VaultRegistry) {
        assert_registry_version(arg0);
        assert!(!arg0.paused, 50);
    }

    public fun assert_registry_version(arg0: &VaultRegistry) {
        assert!(arg0.version == 3, 18);
    }

    fun assert_sui_not_y<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 41);
    }

    public(friend) fun assert_version<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) {
        assert!(arg0.version == 3, 18);
    }

    public fun authorized_keeper<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : address {
        arg0.admin_state.authorized_keeper
    }

    fun begin_redeem<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : RedeemPlan {
        assert!(arg0.version == 3, 18);
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::flash_active<T0, T1>(arg1), 58);
        plan_redeem<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun bootstrapper<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : address {
        arg0.admin_state.bootstrapper
    }

    public(friend) fun borrow_balance_x_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance_x
    }

    public(friend) fun borrow_balance_y_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.balance_y
    }

    public(friend) fun borrow_position<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position {
        &arg0.position
    }

    public(friend) fun borrow_position_mut<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position {
        &mut arg0.position
    }

    public fun bps_denom() : u64 {
        10000
    }

    fun bump_seq<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : u64 {
        arg0.seq_no = arg0.seq_no + 1;
        arg0.seq_no
    }

    public fun cancel_authorized_keeper<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(0x1::option::is_some<PendingKeeper>(&arg1.admin_state.pending_keeper), 34);
        let PendingKeeper {
            keeper : v0,
            eta_ms : _,
        } = 0x1::option::extract<PendingKeeper>(&mut arg1.admin_state.pending_keeper);
        let v2 = KeeperCancelledEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            keeper   : v0,
        };
        0x2::event::emit<KeeperCancelledEvent>(v2);
    }

    public fun cancel_emergency_guardian<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(0x1::option::is_some<PendingEmergencyGuardian>(&arg1.admin_state.pending_emergency_guardian), 40);
        let PendingEmergencyGuardian {
            guardian : v0,
            eta_ms   : _,
        } = 0x1::option::extract<PendingEmergencyGuardian>(&mut arg1.admin_state.pending_emergency_guardian);
        let v2 = EmergencyGuardianCancelledEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            guardian : v0,
        };
        0x2::event::emit<EmergencyGuardianCancelledEvent>(v2);
    }

    public fun cancel_vault_admin_transfer(arg0: PendingVaultAdminTransfer, arg1: 0x2::transfer::Receiving<VaultAdminCap>, arg2: &0x2::tx_context::TxContext) {
        let PendingVaultAdminTransfer {
            id                 : v0,
            vault_admin_cap_id : v1,
            vault_id           : v2,
            proposer           : v3,
            recipient          : v4,
            accept_after_ms    : _,
        } = arg0;
        let v6 = v0;
        let v7 = 0x2::tx_context::sender(arg2);
        assert!(v7 == v3 || v7 == v4, 30);
        assert!(0x2::transfer::receiving_object_id<VaultAdminCap>(&arg1) == v1, 31);
        0x2::object::delete(v6);
        let v8 = VaultAdminTransferCancelledEvent{
            vault_admin_cap_id : v1,
            vault_id           : v2,
            proposer           : v3,
        };
        0x2::event::emit<VaultAdminTransferCancelledEvent>(v8);
        0x2::transfer::transfer<VaultAdminCap>(0x2::transfer::receive<VaultAdminCap>(&mut v6, arg1), v3);
    }

    fun checked_strategy_config(arg0: u32, arg1: u32, arg2: u64, arg3: u32, arg4: u32, arg5: u64) : StrategyConfig {
        assert!(arg0 > 0, 42);
        assert!(arg0 <= 200, 42);
        assert!(arg1 > 0 && arg1 <= arg0, 42);
        assert!(arg3 <= 200, 42);
        assert!(arg4 <= 50, 42);
        assert!(arg4 <= arg0, 42);
        assert!(arg2 <= 604800, 42);
        assert!(arg5 <= 3600, 42);
        assert!(!(arg4 > 0 != arg5 > 0), 42);
        let v0 = arg4 > 0 && arg5 > 0;
        assert!(arg3 > 0 || v0, 27);
        StrategyConfig{
            num_bins                : arg0,
            rebalance_trigger_bins  : arg1,
            rebalance_cooldown_secs : arg2,
            max_center_drift        : arg3,
            calm_zone_bins          : arg4,
            twap_seconds            : arg5,
        }
    }

    public fun clear_emergency_guardian<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        arg1.admin_state.emergency_guardian = @0x0;
        arg1.admin_state.pending_emergency_guardian = 0x1::option::none<PendingEmergencyGuardian>();
        let v0 = EmergencyGuardianAppliedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            guardian : @0x0,
        };
        0x2::event::emit<EmergencyGuardianAppliedEvent>(v0);
    }

    public fun clear_exit_only<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        set_op_state<T0, T1, T2>(arg1, 0);
    }

    fun combined_claim(arg0: u64, arg1: &vector<u64>, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::mul_div_floor(v0, (arg2 as u128), (arg3 as u128)) as u64)
    }

    public fun compute_share_price<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) : u64 {
        let v0 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        if (v0 == 0) {
            return 1000000000
        };
        let (v1, v2) = total_value_live<T0, T1, T2>(arg0, arg1);
        let v3 = (total_value_y_units<T0, T1>(arg1, v1, v2) as u256) * (1000000000 as u256) / (v0 as u256);
        let v4 = 18446744073709551615;
        if (v3 > v4) {
            (v4 as u64)
        } else {
            (v3 as u64)
        }
    }

    public(friend) fun create_vault<T0, T1, T2>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: u32, arg3: u32, arg4: u64, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_sui_not_y<T1>();
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 60);
        assert!(arg5 > 0 && arg6 > 0, 27);
        assert_calm_price_limit<T0, T1>(arg0, arg5);
        assert!(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::lazer_feeds_configured<T0, T1>(arg0) && 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_verified<T0, T1>(arg0), 44);
        let v0 = VaultConfigState{
            strategy_config         : checked_strategy_config(arg2, arg3, 600, 50, arg5, arg6),
            pending_strategy_config : 0x1::option::none<PendingStrategyConfig>(),
            deposit_cap             : arg4,
            pending_deposit_cap     : 0x1::option::none<PendingDepositCap>(),
        };
        let v1 = VaultPauseState{op_state: 0};
        let v2 = VaultMetrics{
            last_rebalance_ts : 0x2::clock::timestamp_ms(arg7),
            total_rebalances  : 0,
        };
        let v3 = VaultAdminState{
            authorized_keeper          : @0x0,
            pending_keeper             : 0x1::option::none<PendingKeeper>(),
            keeper_initialized         : false,
            bootstrapper               : 0x2::tx_context::sender(arg8),
            emergency_guardian         : @0x0,
            pending_emergency_guardian : 0x1::option::none<PendingEmergencyGuardian>(),
        };
        let v4 = Vault<T0, T1, T2>{
            id           : 0x2::object::new(arg8),
            version      : 3,
            pool_id      : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>>(arg0),
            share_supply : 0x2::coin::treasury_into_supply<T2>(arg1),
            position     : 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::create_position<T0, T1>(arg0, arg8),
            balance_x    : 0x2::balance::zero<T0>(),
            balance_y    : 0x2::balance::zero<T1>(),
            config       : v0,
            pause        : v1,
            metrics      : v2,
            admin_state  : v3,
            seq_no       : 0,
            extra        : 0x2::bag::new(arg8),
        };
        let v5 = 0x2::object::id<Vault<T0, T1, T2>>(&v4);
        let v6 = VaultAdminCap{
            id       : 0x2::object::new(arg8),
            vault_id : v5,
        };
        let v7 = VaultCreatedEvent{
            vault_id               : v5,
            pool_id                : 0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>>(arg0),
            coin_type_x            : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_y            : 0x1::type_name::with_defining_ids<T1>(),
            coin_type_share        : 0x1::type_name::with_defining_ids<T2>(),
            num_bins               : arg2,
            rebalance_trigger_bins : arg3,
        };
        0x2::event::emit<VaultCreatedEvent>(v7);
        0x2::transfer::share_object<Vault<T0, T1, T2>>(v4);
        0x2::transfer::transfer<VaultAdminCap>(v6, 0x2::tx_context::sender(arg8));
        v5
    }

    public fun current_version() : u64 {
        3
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 3, 18);
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        assert!(is_normal_state<T0, T1, T2>(arg0), 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 || v1 > 0, 0);
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::is_paused<T0, T1>(arg1), 51);
        let v2 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::pool_permissions<T0, T1>(arg1);
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::perms_bypass_venue(&v2), 59);
        let v3 = if (!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::perms_disable_add(&v2)) {
            if (!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::perms_disable_remove(&v2)) {
                !0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::perms_disable_lending_recall(&v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 62);
        assert!(in_calm_zone<T0, T1, T2>(arg0, arg1, arg5), 23);
        let v4 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        let (v5, v6) = deposit_backing<T0, T1, T2>(arg0, arg1);
        let (v7, v8, v9) = if (v4 == 0) {
            let v10 = if (arg0.admin_state.bootstrapper == @0x0) {
                true
            } else if (0x2::tx_context::sender(arg6) == arg0.admin_state.bootstrapper) {
                if (v0 > 0) {
                    v1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v10, 63);
            let v11 = total_value_y_units<T0, T1>(arg1, v0, v1);
            assert!(v11 > 0, 0);
            assert!(0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::fits_u64(v11), 24);
            ((v11 as u64), v0, v1)
        } else {
            deposit_terms_for_nonzero_supply(v0, v1, v4, v5, v6)
        };
        assert!((v8 as u128) + (v9 as u128) >= (1000 as u128), 45);
        assert!(v7 >= arg4, 8);
        if (arg0.config.deposit_cap > 0) {
            assert!(total_value_y_units<T0, T1>(arg1, v5, v6) + total_value_y_units<T0, T1>(arg1, v8, v9) <= (arg0.config.deposit_cap as u128), 14);
        };
        finish_deposit<T0, T1, T2>(arg0, arg2, arg3, v8, v9, v7, arg6)
    }

    fun deposit_backing<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) : (u64, u64) {
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::flash_active<T0, T1>(arg1), 58);
        let (v0, v1) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::get_position_value_upper_bound<T0, T1>(arg1, &arg0.position);
        let (v2, v3) = vault_balances<T0, T1, T2>(arg0);
        ((0x1::u128::min((v0 as u128) + (v2 as u128), 18446744073709551615) as u64), (0x1::u128::min((v1 as u128) + (v3 as u128), 18446744073709551615) as u64))
    }

    public fun deposit_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.config.deposit_cap
    }

    public fun deposit_cap_timelock_ms() : u64 {
        3600000
    }

    public(friend) fun deposit_no_lending<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::lending_initialized<T0, T1>(arg1), 61);
        assert!(!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::flash_active<T0, T1>(arg1), 58);
        deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun deposit_ratio_error_code() : u64 {
        24
    }

    fun deposit_shares_for_nonzero_supply(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = quote_deposit_shares(arg0, arg1, arg2, arg3, arg4);
        assert!(v0 > 0, 24);
        v0
    }

    fun deposit_terms_for_nonzero_supply(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let v0 = deposit_shares_for_nonzero_supply(arg0, arg1, arg2, arg3, arg4);
        let v1 = (arg2 as u128);
        (v0, ((((v0 as u128) * (arg3 as u128) + v1 - 1) / v1) as u64), ((((v0 as u128) * (arg4 as u128) + v1 - 1) / v1) as u64))
    }

    public fun deposits_paused<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        !is_normal_state<T0, T1, T2>(arg0)
    }

    public fun emergency_guardian<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : address {
        arg0.admin_state.emergency_guardian
    }

    public fun emergency_guardian_timelock_ms() : u64 {
        3600000
    }

    fun finish_deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(arg3 <= v0 && arg4 <= v1, 24);
        let v2 = if (v0 > arg3) {
            0x2::coin::split<T0>(&mut arg1, v0 - arg3, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        let v3 = if (v1 > arg4) {
            0x2::coin::split<T1>(&mut arg2, v1 - arg4, arg6)
        } else {
            0x2::coin::zero<T1>(arg6)
        };
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg2));
        let v4 = 0x2::coin::from_balance<T2>(0x2::balance::increase_supply<T2>(&mut arg0.share_supply, arg5), arg6);
        let v5 = 0x2::object::id<Vault<T0, T1, T2>>(arg0);
        let (v6, v7) = vault_balances<T0, T1, T2>(arg0);
        let v8 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        let v9 = DepositEvent{
            vault_id           : v5,
            depositor          : 0x2::tx_context::sender(arg6),
            amount_x           : arg3,
            amount_y           : arg4,
            shares_minted      : 0x2::coin::value<T2>(&v4),
            total_supply_after : v8,
            total_x_after      : v6,
            total_y_after      : v7,
            seq                : bump_seq<T0, T1, T2>(arg0),
        };
        0x2::event::emit<DepositEvent>(v9);
        (v4, v2, v3)
    }

    fun finish_redeem<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: RedeemPlan, arg2: 0x2::coin::Coin<T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let RedeemPlan {
            shares      : v0,
            supply      : v1,
            idle_x      : v2,
            idle_y      : v3,
            bin_ids     : v4,
            bin_shares  : _,
            bins_closed : _,
        } = arg1;
        let v7 = v4;
        let v8 = if (v0 < v1) {
            0x1::vector::length<u32>(&v7) - 0x1::vector::length<u32>(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(&arg0.position))
        } else {
            0
        };
        assert!(0x2::coin::value<T2>(&arg2) == v0, 57);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg4));
        let v9 = 0x1::u64::min(combined_claim(v2, &arg5, v0, v1), 0x2::balance::value<T0>(&arg0.balance_x));
        let v10 = 0x1::u64::min(combined_claim(v3, &arg6, v0, v1), 0x2::balance::value<T1>(&arg0.balance_y));
        assert!(v9 >= arg7 && v10 >= arg8, 8);
        let v11 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_x, v9), arg9);
        let v12 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_y, v10), arg9);
        0x2::balance::decrease_supply<T2>(&mut arg0.share_supply, 0x2::coin::into_balance<T2>(arg2));
        let v13 = 0x2::object::id<Vault<T0, T1, T2>>(arg0);
        let (v14, v15) = vault_balances<T0, T1, T2>(arg0);
        let v16 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        let v17 = WithdrawEvent{
            vault_id           : v13,
            withdrawer         : 0x2::tx_context::sender(arg9),
            shares_burned      : v0,
            amount_x           : v9,
            amount_y           : v10,
            bins_closed        : v8,
            total_supply_after : v16,
            total_x_after      : v14,
            total_y_after      : v15,
            seq                : bump_seq<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v17);
        (v11, v12)
    }

    public fun guardian_pause<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert_guardian<T0, T1, T2>(arg0, arg1);
        assert!(arg0.version == 3, 18);
        set_op_state<T0, T1, T2>(arg0, 1);
    }

    public fun has_pending_deposit_cap<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        0x1::option::is_some<PendingDepositCap>(&arg0.config.pending_deposit_cap)
    }

    public fun has_pending_emergency_guardian<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        0x1::option::is_some<PendingEmergencyGuardian>(&arg0.admin_state.pending_emergency_guardian)
    }

    public fun has_pending_keeper<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        0x1::option::is_some<PendingKeeper>(&arg0.admin_state.pending_keeper)
    }

    public fun has_pending_strategy_config<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        0x1::option::is_some<PendingStrategyConfig>(&arg0.config.pending_strategy_config)
    }

    public fun has_registered_share_type<T0>(arg0: &VaultRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.share_types, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun has_registered_vault<T0, T1>(arg0: &VaultRegistry) : bool {
        0x2::table::contains<VaultPairKey, vector<0x2::object::ID>>(&arg0.vaults, pair_key<T0, T1>())
    }

    public(friend) fun in_calm_zone<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) : bool {
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        let v0 = arg0.config.strategy_config.calm_zone_bins;
        if (v0 == 0) {
            return true
        };
        let v1 = arg0.config.strategy_config.twap_seconds;
        if (v1 == 0) {
            return true
        };
        let v2 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_bin_id<T0, T1>(arg1);
        if (!0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::lazer_feeds_configured<T0, T1>(arg1) || !0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_verified<T0, T1>(arg1)) {
            return false
        };
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_last_updated<T0, T1>(arg1);
        if (v3 < v4) {
            return false
        };
        let v5 = v3 - v4;
        if (v5 > v1 * 1000 || v5 >= 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::oracle_max_age_ms<T0, T1>(arg1)) {
            return false
        };
        let v6 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::active_bin_id<T0, T1>(arg1);
        let v7 = if (v6 > v2) {
            v6 - v2
        } else {
            v2 - v6
        };
        v7 <= v0
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        initialize_registry(arg1);
    }

    fun initialize_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id          : 0x2::object::new(arg0),
            vaults      : 0x2::table::new<VaultPairKey, vector<0x2::object::ID>>(arg0),
            share_types : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            extra       : 0x2::bag::new(arg0),
            version     : 3,
            paused      : false,
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun is_exit_only<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        is_halted_state<T0, T1, T2>(arg0)
    }

    fun is_halted_state<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        arg0.pause.op_state == 1
    }

    fun is_normal_state<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        arg0.pause.op_state == 0
    }

    public fun is_registry_paused(arg0: &VaultRegistry) : bool {
        arg0.paused
    }

    public fun keeper_initialized<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        arg0.admin_state.keeper_initialized
    }

    public fun keeper_ops_paused<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : bool {
        !is_normal_state<T0, T1, T2>(arg0)
    }

    public fun keeper_rotation_delay_ms() : u64 {
        3600000
    }

    public fun last_rebalance_ts<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.metrics.last_rebalance_ts
    }

    entry fun migrate<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1, T2>>(arg1), 4);
        assert!(arg1.version < 3, 18);
        arg1.version = 3;
        let v0 = VaultMigratedEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            old_version : arg1.version,
            new_version : 3,
        };
        0x2::event::emit<VaultMigratedEvent>(v0);
    }

    entry fun migrate_registry(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut VaultRegistry) {
        assert!(arg1.version < 3, 18);
        arg1.version = 3;
        let v0 = VaultRegistryMigratedEvent{
            registry_id : 0x2::object::id<VaultRegistry>(arg1),
            old_version : arg1.version,
            new_version : 3,
        };
        0x2::event::emit<VaultRegistryMigratedEvent>(v0);
    }

    public fun min_deposit_units() : u64 {
        1000
    }

    public fun op_state<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u8 {
        arg0.pause.op_state
    }

    public fun op_state_halted() : u8 {
        1
    }

    public fun op_state_normal() : u8 {
        0
    }

    fun pair_key<T0, T1>() : VaultPairKey {
        VaultPairKey{
            coin_x : 0x1::type_name::with_defining_ids<T0>(),
            coin_y : 0x1::type_name::with_defining_ids<T1>(),
        }
    }

    public fun pause<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        set_op_state<T0, T1, T2>(arg1, 1);
    }

    public fun pending_deposit_cap_eta_ms<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        assert!(0x1::option::is_some<PendingDepositCap>(&arg0.config.pending_deposit_cap), 37);
        0x1::option::borrow<PendingDepositCap>(&arg0.config.pending_deposit_cap).eta_ms
    }

    public fun pending_emergency_guardian_address<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : address {
        assert!(0x1::option::is_some<PendingEmergencyGuardian>(&arg0.admin_state.pending_emergency_guardian), 40);
        0x1::option::borrow<PendingEmergencyGuardian>(&arg0.admin_state.pending_emergency_guardian).guardian
    }

    public fun pending_emergency_guardian_eta_ms<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        assert!(0x1::option::is_some<PendingEmergencyGuardian>(&arg0.admin_state.pending_emergency_guardian), 40);
        0x1::option::borrow<PendingEmergencyGuardian>(&arg0.admin_state.pending_emergency_guardian).eta_ms
    }

    public fun pending_keeper_address<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : address {
        assert!(0x1::option::is_some<PendingKeeper>(&arg0.admin_state.pending_keeper), 34);
        0x1::option::borrow<PendingKeeper>(&arg0.admin_state.pending_keeper).keeper
    }

    public fun pending_keeper_eta_ms<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        assert!(0x1::option::is_some<PendingKeeper>(&arg0.admin_state.pending_keeper), 34);
        0x1::option::borrow<PendingKeeper>(&arg0.admin_state.pending_keeper).eta_ms
    }

    public fun pending_strategy_eta_ms<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        assert!(0x1::option::is_some<PendingStrategyConfig>(&arg0.config.pending_strategy_config), 36);
        0x1::option::borrow<PendingStrategyConfig>(&arg0.config.pending_strategy_config).eta_ms
    }

    public fun pending_vault_admin_cap_id(arg0: &PendingVaultAdminTransfer) : 0x2::object::ID {
        arg0.vault_admin_cap_id
    }

    fun plan_redeem<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : RedeemPlan {
        let v0 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        assert!(arg2 > 0, 1);
        assert!(v0 > 0, 13);
        assert!(arg2 <= v0, 57);
        let (v1, v2) = vault_balances<T0, T1, T2>(arg0);
        let v3 = &arg0.position;
        let v4 = *0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(v3);
        0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::vec_sort::sort_u32(&mut v4);
        let v5 = if (arg3) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::quote_remove_liquidity_for_claim<T0, T1>(arg1, v3, &v4, arg2, v0, v1, v2)
        } else {
            vector[]
        };
        let v6 = v5;
        let v7 = 0;
        if (arg3) {
            let (_, _, v10) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::quote_remove_liquidity<T0, T1>(arg1, v3, &v4, &v6);
            let v11 = v10;
            let v12 = 0;
            while (v12 < 0x1::vector::length<u32>(&v4)) {
                let v13 = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::shares_in_bin(v3, *0x1::vector::borrow<u32>(&v4, v12));
                if (!*0x1::vector::borrow<bool>(&v11, v12)) {
                    *0x1::vector::borrow_mut<u128>(&mut v6, v12) = v13;
                };
                if (*0x1::vector::borrow<u128>(&v6, v12) == v13 && arg2 < v0) {
                    v7 = v7 + 1;
                };
                v12 = v12 + 1;
            };
        };
        RedeemPlan{
            shares      : arg2,
            supply      : v0,
            idle_x      : v1,
            idle_y      : v2,
            bin_ids     : v4,
            bin_shares  : v6,
            bins_closed : v7,
        }
    }

    public fun pool_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_bin_count<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x1::vector::length<u32>(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::bin_ids(&arg0.position))
    }

    public(friend) fun position_id<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::position::Position>(&arg0.position)
    }

    public fun preview_deposit<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: u64, arg3: u64) : u64 {
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        let (v1, v2) = deposit_backing<T0, T1, T2>(arg0, arg1);
        if (v0 == 0) {
            if (arg2 == 0 || arg3 == 0) {
                return 0
            };
            return (total_value_y_units<T0, T1>(arg1, arg2, arg3) as u64)
        };
        quote_deposit_shares(arg2, arg3, v0, v1, v2)
    }

    public fun preview_withdraw<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: u64) : (u64, u64, u64) {
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::balance::supply_value<T2>(&arg0.share_supply);
        let v1 = if (v0 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg2 > v0
        };
        if (v1) {
            return (0, 0, 0)
        };
        let v2 = plan_redeem<T0, T1, T2>(arg0, arg1, arg2, true);
        let (v3, v4) = total_value_live<T0, T1, T2>(arg0, arg1);
        (pro_rata_floor(v3, arg2, v0), pro_rata_floor(v4, arg2, v0), v2.bins_closed)
    }

    fun pro_rata_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun propose_authorized_keeper<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: address, arg3: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        let v0 = if (arg1.admin_state.keeper_initialized) {
            3600000
        } else {
            0
        };
        let v1 = 0x2::clock::timestamp_ms(arg3) + v0;
        let v2 = PendingKeeper{
            keeper : arg2,
            eta_ms : v1,
        };
        arg1.admin_state.pending_keeper = 0x1::option::some<PendingKeeper>(v2);
        let v3 = KeeperProposedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            keeper   : arg2,
            eta_ms   : v1,
        };
        0x2::event::emit<KeeperProposedEvent>(v3);
    }

    public fun propose_deposit_cap<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v1 = PendingDepositCap{
            deposit_cap : arg2,
            eta_ms      : v0,
        };
        arg1.config.pending_deposit_cap = 0x1::option::some<PendingDepositCap>(v1);
        let v2 = DepositCapProposedEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            deposit_cap : arg2,
            eta_ms      : v0,
        };
        0x2::event::emit<DepositCapProposedEvent>(v2);
    }

    public fun propose_emergency_guardian<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: address, arg3: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v1 = PendingEmergencyGuardian{
            guardian : arg2,
            eta_ms   : v0,
        };
        arg1.admin_state.pending_emergency_guardian = 0x1::option::some<PendingEmergencyGuardian>(v1);
        let v2 = EmergencyGuardianProposedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            guardian : arg2,
            eta_ms   : v0,
        };
        0x2::event::emit<EmergencyGuardianProposedEvent>(v2);
    }

    public fun propose_strategy_config<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u64, arg6: u32, arg7: u32, arg8: u64, arg9: &0x2::clock::Clock) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert_pool_matches<T0, T1, T2>(arg1, arg2);
        assert_calm_price_limit<T0, T1>(arg2, arg7);
        let v0 = 0x2::clock::timestamp_ms(arg9) + 21600000;
        let v1 = PendingStrategyConfig{
            config : checked_strategy_config(arg3, arg4, arg5, arg6, arg7, arg8),
            eta_ms : v0,
        };
        arg1.config.pending_strategy_config = 0x1::option::some<PendingStrategyConfig>(v1);
        let v2 = StrategyConfigProposedEvent{
            vault_id                : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            eta_ms                  : v0,
            num_bins                : arg3,
            rebalance_trigger_bins  : arg4,
            rebalance_cooldown_secs : arg5,
            max_center_drift        : arg6,
            calm_zone_bins          : arg7,
            twap_seconds            : arg8,
        };
        0x2::event::emit<StrategyConfigProposedEvent>(v2);
    }

    public fun propose_vault_admin(arg0: VaultAdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<VaultAdminCap>(&arg0);
        let v2 = arg0.vault_id;
        let v3 = 0x2::clock::timestamp_ms(arg2) + 172800000;
        let v4 = PendingVaultAdminTransfer{
            id                 : 0x2::object::new(arg3),
            vault_admin_cap_id : v1,
            vault_id           : v2,
            proposer           : v0,
            recipient          : arg1,
            accept_after_ms    : v3,
        };
        0x2::transfer::transfer<VaultAdminCap>(arg0, 0x2::object::uid_to_address(&v4.id));
        let v5 = VaultAdminTransferProposedEvent{
            pending_transfer_id : 0x2::object::uid_to_inner(&v4.id),
            vault_admin_cap_id  : v1,
            vault_id            : v2,
            proposer            : v0,
            recipient           : arg1,
            accept_after_ms     : v3,
        };
        0x2::event::emit<VaultAdminTransferProposedEvent>(v5);
        0x2::transfer::share_object<PendingVaultAdminTransfer>(v4);
    }

    fun quote_deposit_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg3 > 0) {
            (arg0 as u128) * (arg2 as u128) / (arg3 as u128)
        } else {
            0
        };
        let v1 = if (arg4 > 0) {
            (arg1 as u128) * (arg2 as u128) / (arg4 as u128)
        } else {
            0
        };
        let v2 = if (arg0 > 0 && arg1 > 0) {
            0x1::u128::min(v0, v1)
        } else if (arg0 > 0 && arg4 == 0) {
            v0
        } else if (arg1 > 0 && arg3 == 0) {
            v1
        } else {
            0
        };
        if (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::u128_math::fits_u64(v2)) {
            (v2 as u64)
        } else {
            0
        }
    }

    public(friend) fun register_vault<T0, T1, T2>(arg0: &mut VaultRegistry, arg1: 0x2::object::ID) {
        assert_registry_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.share_types, v0), 53);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.share_types, v0, arg1);
        let v1 = pair_key<T0, T1>();
        if (0x2::table::contains<VaultPairKey, vector<0x2::object::ID>>(&arg0.vaults, v1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<VaultPairKey, vector<0x2::object::ID>>(&mut arg0.vaults, v1), arg1);
        } else {
            let v2 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v2, arg1);
            0x2::table::add<VaultPairKey, vector<0x2::object::ID>>(&mut arg0.vaults, v1, v2);
        };
    }

    public fun registered_vault_count<T0, T1>(arg0: &VaultRegistry) : u64 {
        let v0 = pair_key<T0, T1>();
        if (!0x2::table::contains<VaultPairKey, vector<0x2::object::ID>>(&arg0.vaults, v0)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x2::table::borrow<VaultPairKey, vector<0x2::object::ID>>(&arg0.vaults, v0))
    }

    public fun residual_idle_ratio_bps<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) : u64 {
        let (v0, v1) = vault_balances<T0, T1, T2>(arg0);
        let (v2, v3) = total_value_live<T0, T1, T2>(arg0, arg1);
        let v4 = total_value_y_units<T0, T1>(arg1, v2, v3);
        if (v4 == 0) {
            return 0
        };
        let v5 = (total_value_y_units<T0, T1>(arg1, v0, v1) as u256) * (10000 as u256) / (v4 as u256);
        if (v5 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v5 as u64)
        }
    }

    public fun set_bootstrapper<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>, arg2: address) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        assert!(arg2 != @0x0, 64);
        arg1.admin_state.bootstrapper = arg2;
        let v0 = BootstrapperUpdatedEvent{
            vault_id         : 0x2::object::id<Vault<T0, T1, T2>>(arg1),
            old_bootstrapper : arg1.admin_state.bootstrapper,
            new_bootstrapper : arg2,
        };
        0x2::event::emit<BootstrapperUpdatedEvent>(v0);
    }

    public(friend) fun set_exit_only<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) {
        set_op_state<T0, T1, T2>(arg0, 1);
    }

    public(friend) fun set_last_rebalance_ts<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) {
        arg0.metrics.last_rebalance_ts = arg1;
        arg0.metrics.total_rebalances = arg0.metrics.total_rebalances + 1;
    }

    fun set_op_state<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u8) {
        arg0.pause.op_state = arg1;
        let v0 = VaultStateChangedEvent{
            vault_id : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            op_state : arg1,
        };
        0x2::event::emit<VaultStateChangedEvent>(v0);
        let v1 = VaultPauseEvent{
            vault_id  : 0x2::object::id<Vault<T0, T1, T2>>(arg0),
            is_paused : arg1 == 1,
        };
        0x2::event::emit<VaultPauseEvent>(v1);
    }

    public fun set_registry_paused(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::admin::AdminCap, arg1: &mut VaultRegistry, arg2: bool) {
        assert_registry_version(arg1);
        arg1.paused = arg2;
        let v0 = RegistryPausedEvent{
            registry_id : 0x2::object::id<VaultRegistry>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<RegistryPausedEvent>(v0);
    }

    public fun share_precision() : u64 {
        1000000000
    }

    public fun strategy_calm_zone_bins(arg0: &StrategyConfig) : u32 {
        arg0.calm_zone_bins
    }

    public fun strategy_config<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &StrategyConfig {
        &arg0.config.strategy_config
    }

    public fun strategy_config_timelock_ms() : u64 {
        21600000
    }

    public fun strategy_max_center_drift(arg0: &StrategyConfig) : u32 {
        arg0.max_center_drift
    }

    public fun strategy_num_bins(arg0: &StrategyConfig) : u32 {
        arg0.num_bins
    }

    public fun strategy_rebalance_cooldown_secs(arg0: &StrategyConfig) : u64 {
        arg0.rebalance_cooldown_secs
    }

    public fun strategy_rebalance_trigger_bins(arg0: &StrategyConfig) : u32 {
        arg0.rebalance_trigger_bins
    }

    public fun strategy_twap_seconds(arg0: &StrategyConfig) : u64 {
        arg0.twap_seconds
    }

    public fun total_rebalances<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.metrics.total_rebalances
    }

    public fun total_value_live<T0, T1, T2>(arg0: &Vault<T0, T1, T2>, arg1: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>) : (u64, u64) {
        assert_pool_matches<T0, T1, T2>(arg0, arg1);
        let (v0, v1) = 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::get_position_value<T0, T1>(arg1, &arg0.position);
        (0x2::balance::value<T0>(&arg0.balance_x) + v0, 0x2::balance::value<T1>(&arg0.balance_y) + v1)
    }

    fun total_value_y_units<T0, T1>(arg0: &0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u128 {
        let v0 = (0x577c62ef50b3e5780b988024c58c3c31528c89435bb0614aebed4b309ac8c7a2::fixed_point64::raw(0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::get_current_price<T0, T1>(arg0)) as u256) * (arg1 as u256) >> 64;
        let v1 = 340282366920938463463374607431768211455;
        let v2 = if (v0 > v1) {
            (v1 as u128)
        } else {
            (v0 as u128)
        };
        if ((arg2 as u256) > v1 - (v2 as u256)) {
            (v1 as u128)
        } else {
            v2 + (arg2 as u128)
        }
    }

    public fun unpause<T0, T1, T2>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1, T2>) {
        assert_admin_versioned<T0, T1, T2>(arg0, arg1);
        set_op_state<T0, T1, T2>(arg1, 0);
    }

    public fun vault_admin_transfer_timelock_ms() : u64 {
        172800000
    }

    public fun vault_balances<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y))
    }

    public fun vault_id_for_share_type<T0>(arg0: &VaultRegistry) : 0x2::object::ID {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.share_types, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun version<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        arg0.version
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = begin_redeem<T0, T1, T2>(arg0, arg1, 0x2::coin::value<T2>(&arg3), false);
        let (v1, v2, v3, v4) = if (0x1::vector::length<u32>(&v0.bin_ids) > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_for_claim<T0, T1>(arg1, &mut arg0.position, arg2, v0.bin_ids, v0.shares, v0.supply, v0.idle_x, v0.idle_y, 0, 0, 4102444800000, arg6, arg7)
        } else {
            let v2 = 0x2::coin::zero<T1>(arg7);
            let v1 = 0x2::coin::zero<T0>(arg7);
            (v1, v2, vector[], vector[])
        };
        finish_redeem<T0, T1, T2>(arg0, v0, arg3, v1, v2, v3, v4, arg4, arg5, arg7)
    }

    public(friend) fun withdraw_no_lending<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = begin_redeem<T0, T1, T2>(arg0, arg1, 0x2::coin::value<T2>(&arg2), true);
        let (v1, v2, v3, v4) = if (0x1::vector::length<u32>(&v0.bin_ids) > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_no_lending_with_position_values<T0, T1>(arg1, &mut arg0.position, v0.bin_ids, v0.bin_shares, 0, 0, 4102444800000, arg5, arg6)
        } else {
            let v2 = 0x2::coin::zero<T1>(arg6);
            let v1 = 0x2::coin::zero<T0>(arg6);
            (v1, v2, vector[], vector[])
        };
        finish_redeem<T0, T1, T2>(arg0, v0, arg2, v1, v2, v3, v4, arg3, arg4, arg6)
    }

    public(friend) fun withdraw_x_sui<T0, T1>(arg0: &mut Vault<0x2::sui::SUI, T0, T1>, arg1: &mut 0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = begin_redeem<0x2::sui::SUI, T0, T1>(arg0, arg1, 0x2::coin::value<T1>(&arg3), false);
        let (v1, v2, v3, v4) = if (0x1::vector::length<u32>(&v0.bin_ids) > 0) {
            0x2a42d9160d0f08ca0041572966b8fabbb242a25e8bd27e569310462755baa34e::pool::remove_liquidity_x_sui_for_claim<T0>(arg1, &mut arg0.position, arg2, v0.bin_ids, v0.shares, v0.supply, v0.idle_x, v0.idle_y, arg4, 0, 0, 4102444800000, arg7, arg8)
        } else {
            let v2 = 0x2::coin::zero<T0>(arg8);
            let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
            (v1, v2, vector[], vector[])
        };
        finish_redeem<0x2::sui::SUI, T0, T1>(arg0, v0, arg3, v1, v2, v3, v4, arg5, arg6, arg8)
    }

    // decompiled from Move bytecode v7
}

