module 0xa58f2dee1dd01ac655ef2d9180a96228ab4667219049cfc1286752b3923ad730::yield_router {
    struct YieldPosition has key {
        id: 0x2::object::UID,
        owner: address,
        basis_usdc: u64,
        active_venues: u8,
        rotations_total: u64,
        rebalance_enabled: bool,
        rebalance_paused: bool,
        max_per_rotation: u64,
        max_per_day: u64,
        used_today: u64,
        day_start_ms: u64,
        expires_at_ms: u64,
    }

    struct YieldPositionV2 has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        basis_usdc: u64,
        active_venues: u8,
        rotations_total: u64,
        rebalance_enabled: bool,
        rebalance_paused: bool,
        registry_id: 0x1::option::Option<0x2::object::ID>,
        max_per_rotation: u64,
        max_per_window: u64,
        spent_in_window: u64,
        window_start_ms: u64,
        expires_at_ms: u64,
    }

    struct RebalanceRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        workers: vector<address>,
        paused_venues: u8,
    }

    struct RebalanceRegistryV2 has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        pending_admin: 0x1::option::Option<PendingAdminTransfer>,
        workers: vector<address>,
        paused_venues: u8,
        rotation_paused: bool,
    }

    struct PendingAdminTransfer has drop, store {
        new_admin: address,
        scheduled_at_ms: u64,
    }

    struct PendingAdminKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RegistryV2Key has copy, drop, store {
        dummy_field: bool,
    }

    struct RotationTicket {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
    }

    struct RotationTicketV2 {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
    }

    struct VenueWithdrawal {
        position_id: 0x2::object::ID,
        venue: u8,
        value: u64,
    }

    struct VenueDeposit {
        position_id: 0x2::object::ID,
        venue: u8,
        value: u64,
    }

    struct PositionMinted has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct ReceiptDeposited has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
        basis_added: u64,
    }

    struct ReceiptRemoved has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
    }

    struct Rotated has copy, drop {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
        ts_ms: u64,
    }

    struct PositionV2Minted has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct ReceiptDepositedV2 has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
        basis_added: u64,
        basis_total: u64,
    }

    struct ReceiptRemovedV2 has copy, drop {
        position_id: 0x2::object::ID,
        venue: u8,
        basis_removed: u64,
        basis_total: u64,
    }

    struct RebalanceArmed has copy, drop {
        position_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        max_per_rotation: u64,
        max_per_window: u64,
        expires_at_ms: u64,
    }

    struct RebalancePauseSet has copy, drop {
        position_id: 0x2::object::ID,
        paused: bool,
    }

    struct RebalanceDisarmed has copy, drop {
        position_id: 0x2::object::ID,
    }

    struct RotatedV2 has copy, drop {
        position_id: 0x2::object::ID,
        from_venue: u8,
        to_venue: u8,
        amount: u64,
        value_out: u64,
        value_in: u64,
        ts_ms: u64,
    }

    struct PositionOwnerChangedV2 has copy, drop {
        position_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct VersionMigrated has copy, drop {
        object_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct RegistryV2Created has copy, drop {
        registry_id: 0x2::object::ID,
        legacy_registry_id: 0x2::object::ID,
    }

    struct WorkerAdded has copy, drop {
        registry_id: 0x2::object::ID,
        worker: address,
    }

    struct WorkerRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        worker: address,
    }

    struct VenuePauseSet has copy, drop {
        registry_id: 0x2::object::ID,
        venue: u8,
        paused: bool,
    }

    struct RotationPauseSet has copy, drop {
        registry_id: 0x2::object::ID,
        paused: bool,
    }

    struct AdminTransferStarted has copy, drop {
        registry_id: 0x2::object::ID,
        current_admin: address,
        pending_admin: address,
        executable_after_ms: u64,
    }

    struct AdminTransferAccepted has copy, drop {
        registry_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct AdminTransferCancelled has copy, drop {
        registry_id: 0x2::object::ID,
        was_pending_admin: address,
    }

    public fun accept_admin_transfer(arg0: &mut RebalanceRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = PendingAdminKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingAdminKey>(&arg0.id, v0), 422);
        let v1 = PendingAdminKey{dummy_field: false};
        let PendingAdminTransfer {
            new_admin       : v2,
            scheduled_at_ms : v3,
        } = 0x2::dynamic_field::remove<PendingAdminKey, PendingAdminTransfer>(&mut arg0.id, v1);
        assert!(0x2::tx_context::sender(arg2) == v2, 423);
        assert!(0x2::clock::timestamp_ms(arg1) >= v3 + 172800000, 424);
        arg0.admin = v2;
        let v4 = AdminTransferAccepted{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            old_admin   : arg0.admin,
            new_admin   : v2,
        };
        0x2::event::emit<AdminTransferAccepted>(v4);
    }

    public fun accept_admin_transfer_v2(arg0: &mut RebalanceRegistryV2, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin), 422);
        let PendingAdminTransfer {
            new_admin       : v0,
            scheduled_at_ms : v1,
        } = 0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg2) == v0, 423);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1 + 172800000, 424);
        arg0.admin = v0;
        let v2 = AdminTransferAccepted{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            old_admin   : arg0.admin,
            new_admin   : v0,
        };
        0x2::event::emit<AdminTransferAccepted>(v2);
    }

    public fun active_venues(arg0: &YieldPosition) : u8 {
        arg0.active_venues
    }

    public fun active_venues_v2(arg0: &YieldPositionV2) : u8 {
        arg0.active_venues
    }

    public fun add_worker(arg0: &mut RebalanceRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        if (!0x1::vector::contains<address>(&arg0.workers, &arg1)) {
            assert!(0x1::vector::length<address>(&arg0.workers) < 16, 417);
            0x1::vector::push_back<address>(&mut arg0.workers, arg1);
            let v0 = WorkerAdded{
                registry_id : 0x2::object::uid_to_inner(&arg0.id),
                worker      : arg1,
            };
            0x2::event::emit<WorkerAdded>(v0);
        };
    }

    public fun add_worker_v2(arg0: &mut RebalanceRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        assert!(arg1 != @0x0, 400);
        assert!(!0x1::vector::contains<address>(&arg0.workers, &arg1), 428);
        assert!(0x1::vector::length<address>(&arg0.workers) < 16, 417);
        0x1::vector::push_back<address>(&mut arg0.workers, arg1);
        let v0 = WorkerAdded{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            worker      : arg1,
        };
        0x2::event::emit<WorkerAdded>(v0);
    }

    fun assert_position_version(arg0: &YieldPositionV2) {
        assert!(arg0.version == 1, 434);
    }

    fun assert_registry_version(arg0: &RebalanceRegistryV2) {
        assert!(arg0.version == 1, 434);
    }

    public fun basis_usdc(arg0: &YieldPosition) : u64 {
        arg0.basis_usdc
    }

    public fun basis_usdc_v2(arg0: &YieldPositionV2) : u64 {
        arg0.basis_usdc
    }

    public fun begin_admin_transfer(arg0: &mut RebalanceRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 400);
        assert!(arg1 != @0x0, 400);
        assert!(arg1 != arg0.admin, 425);
        let v0 = PendingAdminKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<PendingAdminKey>(&arg0.id, v0), 421);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = PendingAdminKey{dummy_field: false};
        let v3 = PendingAdminTransfer{
            new_admin       : arg1,
            scheduled_at_ms : v1,
        };
        0x2::dynamic_field::add<PendingAdminKey, PendingAdminTransfer>(&mut arg0.id, v2, v3);
        let v4 = AdminTransferStarted{
            registry_id         : 0x2::object::uid_to_inner(&arg0.id),
            current_admin       : arg0.admin,
            pending_admin       : arg1,
            executable_after_ms : v1 + 172800000,
        };
        0x2::event::emit<AdminTransferStarted>(v4);
    }

    public fun begin_admin_transfer_v2(arg0: &mut RebalanceRegistryV2, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 400);
        assert!(arg1 != @0x0, 400);
        assert!(arg1 != arg0.admin, 425);
        assert!(0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_admin), 421);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = PendingAdminTransfer{
            new_admin       : arg1,
            scheduled_at_ms : v0,
        };
        0x1::option::fill<PendingAdminTransfer>(&mut arg0.pending_admin, v1);
        let v2 = AdminTransferStarted{
            registry_id         : 0x2::object::uid_to_inner(&arg0.id),
            current_admin       : arg0.admin,
            pending_admin       : arg1,
            executable_after_ms : v0 + 172800000,
        };
        0x2::event::emit<AdminTransferStarted>(v2);
    }

    public fun begin_rotation<T0: store + key>(arg0: &mut YieldPosition, arg1: &RebalanceRegistry, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (T0, RotationTicket) {
        abort 413
    }

    public fun begin_rotation_v2<T0: store + key>(arg0: &mut YieldPositionV2, arg1: &RebalanceRegistryV2, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (T0, RotationTicketV2) {
        assert_position_version(arg0);
        assert_registry_version(arg1);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.registry_id, &v0), 416);
        assert!(!arg1.rotation_paused, 418);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&arg1.workers, &v1), 406);
        assert!(arg0.rebalance_enabled, 412);
        assert!(!arg0.rebalance_paused, 402);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v2 < arg0.expires_at_ms, 403);
        assert!(arg4 > 0, 411);
        assert!(arg4 <= arg0.max_per_rotation, 404);
        assert!(is_known_venue(arg2) && is_known_venue(arg3), 407);
        assert!(arg2 != arg3, 410);
        assert!(arg1.paused_venues & venue_bit(arg3) == 0, 408);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T0>(&arg0.id, arg2), 409);
        assert!(!0x2::dynamic_object_field::exists<u8>(&arg0.id, arg3), 415);
        let (v3, v4) = decayed_spend(arg0.spent_in_window, arg0.window_start_ms, v2);
        assert!(v3 <= arg0.max_per_window, 405);
        assert!(arg4 <= arg0.max_per_window - v3, 405);
        arg0.spent_in_window = v3 + arg4;
        arg0.window_start_ms = v4;
        arg0.active_venues = arg0.active_venues & (255 ^ venue_bit(arg2));
        let v5 = RotationTicketV2{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            from_venue  : arg2,
            to_venue    : arg3,
            amount      : arg4,
        };
        (0x2::dynamic_object_field::remove<u8, T0>(&mut arg0.id, arg2), v5)
    }

    public fun bound_registry_id(arg0: &YieldPositionV2) : 0x1::option::Option<0x2::object::ID> {
        arg0.registry_id
    }

    public fun cancel_admin_transfer(arg0: &mut RebalanceRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 400);
        let v0 = PendingAdminKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingAdminKey>(&arg0.id, v0), 422);
        let v1 = PendingAdminKey{dummy_field: false};
        let PendingAdminTransfer {
            new_admin       : v2,
            scheduled_at_ms : _,
        } = 0x2::dynamic_field::remove<PendingAdminKey, PendingAdminTransfer>(&mut arg0.id, v1);
        let v4 = AdminTransferCancelled{
            registry_id       : 0x2::object::uid_to_inner(&arg0.id),
            was_pending_admin : v2,
        };
        0x2::event::emit<AdminTransferCancelled>(v4);
    }

    public fun cancel_admin_transfer_v2(arg0: &mut RebalanceRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 400);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin), 422);
        let PendingAdminTransfer {
            new_admin       : v0,
            scheduled_at_ms : _,
        } = 0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_admin);
        let v2 = AdminTransferCancelled{
            registry_id       : 0x2::object::uid_to_inner(&arg0.id),
            was_pending_admin : v0,
        };
        0x2::event::emit<AdminTransferCancelled>(v2);
    }

    public fun canonical_legacy_registry() : address {
        @0x9ba71e5164254040f60a439abb7317670a90437b3603a22ca3eceac92c3d7e21
    }

    fun decayed_spend(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg2 <= arg1) {
            return (arg0, arg1)
        };
        let v0 = arg2 - arg1;
        if (v0 >= 86400000) {
            return (0, arg2)
        };
        (arg0 - (((arg0 as u128) * (v0 as u128) / (86400000 as u128)) as u64), arg2)
    }

    public fun deposit_receipt<T0: store + key>(arg0: &mut YieldPosition, arg1: T0, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 400);
        assert!(is_known_venue(arg2), 407);
        assert!(!0x2::dynamic_object_field::exists<u8>(&arg0.id, arg2), 415);
        0x2::dynamic_object_field::add<u8, T0>(&mut arg0.id, arg2, arg1);
        arg0.active_venues = arg0.active_venues | venue_bit(arg2);
        arg0.basis_usdc = arg0.basis_usdc + arg3;
        let v0 = ReceiptDeposited{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            venue       : arg2,
            basis_added : arg3,
        };
        0x2::event::emit<ReceiptDeposited>(v0);
    }

    public fun deposit_receipt_v2<T0: store + key>(arg0: &mut YieldPositionV2, arg1: T0, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_position_version(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 400);
        assert!(is_known_venue(arg2), 407);
        assert!(!0x2::dynamic_object_field::exists<u8>(&arg0.id, arg2), 415);
        0x2::dynamic_object_field::add<u8, T0>(&mut arg0.id, arg2, arg1);
        arg0.active_venues = arg0.active_venues | venue_bit(arg2);
        arg0.basis_usdc = arg0.basis_usdc + arg3;
        let v0 = ReceiptDepositedV2{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            venue       : arg2,
            basis_added : arg3,
            basis_total : arg0.basis_usdc,
        };
        0x2::event::emit<ReceiptDepositedV2>(v0);
    }

    public fun disable_rebalance(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        if (arg0.rebalance_enabled) {
            arg0.rebalance_enabled = false;
            let v0 = RebalanceDisarmed{position_id: 0x2::object::uid_to_inner(&arg0.id)};
            0x2::event::emit<RebalanceDisarmed>(v0);
        };
    }

    public fun disable_rebalance_v2(arg0: &mut YieldPositionV2, arg1: &0x2::tx_context::TxContext) {
        assert_position_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        if (arg0.rebalance_enabled || 0x1::option::is_some<0x2::object::ID>(&arg0.registry_id)) {
            arg0.rebalance_enabled = false;
            arg0.registry_id = 0x1::option::none<0x2::object::ID>();
            let v0 = RebalanceDisarmed{position_id: 0x2::object::uid_to_inner(&arg0.id)};
            0x2::event::emit<RebalanceDisarmed>(v0);
        };
    }

    public fun enable_rebalance(arg0: &mut YieldPosition, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        abort 413
    }

    public fun enable_rebalance_v2(arg0: &mut YieldPositionV2, arg1: &RebalanceRegistryV2, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_position_version(arg0);
        assert_registry_version(arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 400);
        assert!(arg2 > 0, 430);
        assert!(arg3 >= arg2, 430);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v0, 403);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        arg0.rebalance_enabled = true;
        arg0.rebalance_paused = false;
        arg0.registry_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.max_per_rotation = arg2;
        arg0.max_per_window = arg3;
        arg0.spent_in_window = 0;
        arg0.window_start_ms = v0;
        arg0.expires_at_ms = arg4;
        let v2 = RebalanceArmed{
            position_id      : 0x2::object::uid_to_inner(&arg0.id),
            registry_id      : v1,
            max_per_rotation : arg2,
            max_per_window   : arg3,
            expires_at_ms    : arg4,
        };
        0x2::event::emit<RebalanceArmed>(v2);
    }

    public fun end_rotation<T0: store + key>(arg0: &mut YieldPosition, arg1: T0, arg2: RotationTicket, arg3: &0x2::clock::Clock) {
        abort 413
    }

    public fun end_rotation_v2<T0: store + key>(arg0: &mut YieldPositionV2, arg1: T0, arg2: VenueWithdrawal, arg3: VenueDeposit, arg4: RotationTicketV2, arg5: &0x2::clock::Clock) {
        assert_position_version(arg0);
        let RotationTicketV2 {
            position_id : v0,
            from_venue  : v1,
            to_venue    : v2,
            amount      : v3,
        } = arg4;
        let VenueWithdrawal {
            position_id : v4,
            venue       : v5,
            value       : v6,
        } = arg2;
        let VenueDeposit {
            position_id : v7,
            venue       : v8,
            value       : v9,
        } = arg3;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 401);
        assert!(v4 == v0, 431);
        assert!(v7 == v0, 431);
        assert!(v5 == v1, 432);
        assert!(v8 == v2, 426);
        assert!(v6 <= v3, 433);
        assert!(v9 >= rotation_value_floor(v6), 427);
        assert!(!0x2::dynamic_object_field::exists<u8>(&arg0.id, v2), 415);
        0x2::dynamic_object_field::add<u8, T0>(&mut arg0.id, v2, arg1);
        arg0.active_venues = arg0.active_venues | venue_bit(v2);
        arg0.rotations_total = arg0.rotations_total + 1;
        let v10 = RotatedV2{
            position_id : 0x2::object::uid_to_inner(&arg0.id),
            from_venue  : v1,
            to_venue    : v2,
            amount      : v3,
            value_out   : v6,
            value_in    : v9,
            ts_ms       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RotatedV2>(v10);
    }

    public fun holds(arg0: &YieldPosition, arg1: u8) : bool {
        0x2::dynamic_object_field::exists<u8>(&arg0.id, arg1)
    }

    public fun holds_v2(arg0: &YieldPositionV2, arg1: u8) : bool {
        0x2::dynamic_object_field::exists<u8>(&arg0.id, arg1)
    }

    fun is_known_venue(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    public fun is_worker(arg0: &RebalanceRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.workers, &arg1)
    }

    public fun is_worker_v2(arg0: &RebalanceRegistryV2, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.workers, &arg1)
    }

    public fun migrate_position_v2(arg0: &mut YieldPositionV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        assert!(arg0.version < 1, 434);
        arg0.version = 1;
        let v0 = VersionMigrated{
            object_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_version : arg0.version,
            new_version : 1,
        };
        0x2::event::emit<VersionMigrated>(v0);
    }

    public fun migrate_registry_v2(arg0: &mut RebalanceRegistryV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 400);
        assert!(arg0.version < 1, 434);
        arg0.version = 1;
        let v0 = VersionMigrated{
            object_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_version : arg0.version,
            new_version : 1,
        };
        0x2::event::emit<VersionMigrated>(v0);
    }

    public fun mint_position(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldPosition{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            basis_usdc        : 0,
            active_venues     : 0,
            rotations_total   : 0,
            rebalance_enabled : false,
            rebalance_paused  : false,
            max_per_rotation  : 0,
            max_per_day       : 0,
            used_today        : 0,
            day_start_ms      : 0,
            expires_at_ms     : 0,
        };
        let v1 = PositionMinted{
            position_id : 0x2::object::uid_to_inner(&v0.id),
            owner       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PositionMinted>(v1);
        0x2::transfer::share_object<YieldPosition>(v0);
    }

    public fun mint_position_v2(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldPositionV2{
            id                : 0x2::object::new(arg0),
            version           : 1,
            owner             : 0x2::tx_context::sender(arg0),
            basis_usdc        : 0,
            active_venues     : 0,
            rotations_total   : 0,
            rebalance_enabled : false,
            rebalance_paused  : false,
            registry_id       : 0x1::option::none<0x2::object::ID>(),
            max_per_rotation  : 0,
            max_per_window    : 0,
            spent_in_window   : 0,
            window_start_ms   : 0,
            expires_at_ms     : 0,
        };
        let v1 = PositionV2Minted{
            position_id : 0x2::object::uid_to_inner(&v0.id),
            owner       : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PositionV2Minted>(v1);
        0x2::transfer::share_object<YieldPositionV2>(v0);
    }

    public fun new_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RebalanceRegistry{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            workers       : vector[],
            paused_venues : 0,
        };
        0x2::transfer::share_object<RebalanceRegistry>(v0);
    }

    public fun new_registry_v2(arg0: &mut RebalanceRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == 0x2::object::id_from_address(@0x9ba71e5164254040f60a439abb7317670a90437b3603a22ca3eceac92c3d7e21), 419);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 400);
        let v0 = RegistryV2Key{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RegistryV2Key>(&arg0.id, v0), 420);
        let v1 = RebalanceRegistryV2{
            id              : 0x2::object::new(arg1),
            version         : 1,
            admin           : arg0.admin,
            pending_admin   : 0x1::option::none<PendingAdminTransfer>(),
            workers         : vector[],
            paused_venues   : 0,
            rotation_paused : false,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = RegistryV2Key{dummy_field: false};
        0x2::dynamic_field::add<RegistryV2Key, 0x2::object::ID>(&mut arg0.id, v3, v2);
        let v4 = RegistryV2Created{
            registry_id        : v2,
            legacy_registry_id : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::event::emit<RegistryV2Created>(v4);
        0x2::transfer::share_object<RebalanceRegistryV2>(v1);
    }

    public(friend) fun new_venue_deposit(arg0: 0x2::object::ID, arg1: u8, arg2: u64) : VenueDeposit {
        assert!(is_known_venue(arg1), 407);
        VenueDeposit{
            position_id : arg0,
            venue       : arg1,
            value       : arg2,
        }
    }

    public(friend) fun new_venue_withdrawal(arg0: 0x2::object::ID, arg1: u8, arg2: u64) : VenueWithdrawal {
        assert!(is_known_venue(arg1), 407);
        VenueWithdrawal{
            position_id : arg0,
            venue       : arg1,
            value       : arg2,
        }
    }

    public fun owner(arg0: &YieldPosition) : address {
        arg0.owner
    }

    public fun owner_v2(arg0: &YieldPositionV2) : address {
        arg0.owner
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        if (!arg0.rebalance_paused) {
            arg0.rebalance_paused = true;
            let v0 = RebalancePauseSet{
                position_id : 0x2::object::uid_to_inner(&arg0.id),
                paused      : true,
            };
            0x2::event::emit<RebalancePauseSet>(v0);
        };
    }

    public fun paused_venues_v2(arg0: &RebalanceRegistryV2) : u8 {
        arg0.paused_venues
    }

    public fun rebalance_enabled(arg0: &YieldPosition) : bool {
        arg0.rebalance_enabled
    }

    public fun rebalance_enabled_v2(arg0: &YieldPositionV2) : bool {
        arg0.rebalance_enabled
    }

    public fun rebalance_paused_v2(arg0: &YieldPositionV2) : bool {
        arg0.rebalance_paused
    }

    public fun registry_admin(arg0: &RebalanceRegistry) : address {
        arg0.admin
    }

    public fun registry_admin_v2(arg0: &RebalanceRegistryV2) : address {
        arg0.admin
    }

    public fun registry_version_v2(arg0: &RebalanceRegistryV2) : u64 {
        arg0.version
    }

    public fun remove_worker(arg0: &mut RebalanceRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.workers, &arg1);
        assert!(v0, 429);
        0x1::vector::remove<address>(&mut arg0.workers, v1);
        let v2 = WorkerRemoved{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            worker      : arg1,
        };
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun remove_worker_v2(arg0: &mut RebalanceRegistryV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.workers, &arg1);
        assert!(v0, 429);
        0x1::vector::remove<address>(&mut arg0.workers, v1);
        let v2 = WorkerRemoved{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            worker      : arg1,
        };
        0x2::event::emit<WorkerRemoved>(v2);
    }

    public fun resume(arg0: &mut YieldPosition, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 400);
        if (arg0.rebalance_paused) {
            arg0.rebalance_paused = false;
            let v0 = RebalancePauseSet{
                position_id : 0x2::object::uid_to_inner(&arg0.id),
                paused      : false,
            };
            0x2::event::emit<RebalancePauseSet>(v0);
        };
    }

    public fun rotation_paused(arg0: &RebalanceRegistryV2) : bool {
        arg0.rotation_paused
    }

    fun rotation_value_floor(arg0: u64) : u64 {
        arg0 - (((arg0 as u128) * (50 as u128) / (10000 as u128)) as u64)
    }

    public fun rotations_total(arg0: &YieldPosition) : u64 {
        arg0.rotations_total
    }

    public fun rotations_total_v2(arg0: &YieldPositionV2) : u64 {
        arg0.rotations_total
    }

    public fun set_rebalance_paused_v2(arg0: &mut YieldPositionV2, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_position_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 400);
        if (arg0.rebalance_paused != arg1) {
            arg0.rebalance_paused = arg1;
            let v0 = RebalancePauseSet{
                position_id : 0x2::object::uid_to_inner(&arg0.id),
                paused      : arg1,
            };
            0x2::event::emit<RebalancePauseSet>(v0);
        };
    }

    public fun set_rotation_paused(arg0: &mut RebalanceRegistryV2, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 400);
        assert!(arg0.rotation_paused != arg1, 425);
        arg0.rotation_paused = arg1;
        let v0 = RotationPauseSet{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            paused      : arg1,
        };
        0x2::event::emit<RotationPauseSet>(v0);
    }

    public fun set_venue_paused(arg0: &mut RebalanceRegistry, arg1: u8, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 400);
        assert!(is_known_venue(arg1), 407);
        let v0 = if (arg2) {
            arg0.paused_venues | venue_bit(arg1)
        } else {
            arg0.paused_venues & (255 ^ venue_bit(arg1))
        };
        arg0.paused_venues = v0;
        if (arg0.paused_venues & venue_bit(arg1) != 0 != arg2) {
            let v1 = VenuePauseSet{
                registry_id : 0x2::object::uid_to_inner(&arg0.id),
                venue       : arg1,
                paused      : arg2,
            };
            0x2::event::emit<VenuePauseSet>(v1);
        };
    }

    public fun set_venue_paused_v2(arg0: &mut RebalanceRegistryV2, arg1: u8, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 400);
        assert!(is_known_venue(arg1), 407);
        assert!(arg0.paused_venues & venue_bit(arg1) != 0 != arg2, 425);
        let v0 = if (arg2) {
            arg0.paused_venues | venue_bit(arg1)
        } else {
            arg0.paused_venues & (255 ^ venue_bit(arg1))
        };
        arg0.paused_venues = v0;
        let v1 = VenuePauseSet{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            venue       : arg1,
            paused      : arg2,
        };
        0x2::event::emit<VenuePauseSet>(v1);
    }

    public fun spent_in_window(arg0: &YieldPositionV2) : u64 {
        arg0.spent_in_window
    }

    public fun take_receipt<T0: store + key>(arg0: &mut YieldPosition, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 400);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T0>(&arg0.id, arg1), 409);
        assert!(arg2 <= arg0.basis_usdc, 414);
        arg0.active_venues = arg0.active_venues & (255 ^ venue_bit(arg1));
        arg0.basis_usdc = arg0.basis_usdc - arg2;
        let v0 = ReceiptRemovedV2{
            position_id   : 0x2::object::uid_to_inner(&arg0.id),
            venue         : arg1,
            basis_removed : arg2,
            basis_total   : arg0.basis_usdc,
        };
        0x2::event::emit<ReceiptRemovedV2>(v0);
        0x2::dynamic_object_field::remove<u8, T0>(&mut arg0.id, arg1)
    }

    public fun take_receipt_v2<T0: store + key>(arg0: &mut YieldPositionV2, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        assert_position_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 400);
        assert!(0x2::dynamic_object_field::exists_with_type<u8, T0>(&arg0.id, arg1), 409);
        assert!(arg2 <= arg0.basis_usdc, 414);
        arg0.active_venues = arg0.active_venues & (255 ^ venue_bit(arg1));
        arg0.basis_usdc = arg0.basis_usdc - arg2;
        let v0 = ReceiptRemovedV2{
            position_id   : 0x2::object::uid_to_inner(&arg0.id),
            venue         : arg1,
            basis_removed : arg2,
            basis_total   : arg0.basis_usdc,
        };
        0x2::event::emit<ReceiptRemovedV2>(v0);
        0x2::dynamic_object_field::remove<u8, T0>(&mut arg0.id, arg1)
    }

    public fun transfer_ownership_v2(arg0: &mut YieldPositionV2, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_position_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 400);
        assert!(arg1 != @0x0, 435);
        assert!(arg1 != arg0.owner, 425);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = arg0.rebalance_enabled || 0x1::option::is_some<0x2::object::ID>(&arg0.registry_id);
        arg0.owner = arg1;
        arg0.rebalance_enabled = false;
        arg0.registry_id = 0x1::option::none<0x2::object::ID>();
        let v2 = PositionOwnerChangedV2{
            position_id : v0,
            old_owner   : arg0.owner,
            new_owner   : arg1,
        };
        0x2::event::emit<PositionOwnerChangedV2>(v2);
        if (v1) {
            let v3 = RebalanceDisarmed{position_id: v0};
            0x2::event::emit<RebalanceDisarmed>(v3);
        };
    }

    fun venue_bit(arg0: u8) : u8 {
        assert!(arg0 >= 1 && arg0 <= 8, 407);
        1 << arg0 - 1
    }

    public fun version_v2(arg0: &YieldPositionV2) : u64 {
        arg0.version
    }

    public fun worker_count(arg0: &RebalanceRegistry) : u64 {
        0x1::vector::length<address>(&arg0.workers)
    }

    public fun worker_count_v2(arg0: &RebalanceRegistryV2) : u64 {
        0x1::vector::length<address>(&arg0.workers)
    }

    // decompiled from Move bytecode v7
}

