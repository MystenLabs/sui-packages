module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ArbCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCap has key {
        id: 0x2::object::UID,
    }

    struct GovernanceConfig has key {
        id: 0x2::object::UID,
        cap_rotation_timelock_ms: u64,
        allow_emergency_rotation: bool,
        incident_freeze_active: bool,
        pending_admin_owner: address,
        pending_admin_effective_at_ms: u64,
        has_pending_admin_rotation: bool,
        pending_admin_treasury_approved: bool,
        pending_arb_owner: address,
        pending_arb_effective_at_ms: u64,
        has_pending_arb_rotation: bool,
        pending_arb_treasury_approved: bool,
        pending_treasury_owner: address,
        pending_treasury_effective_at_ms: u64,
        has_pending_treasury_rotation: bool,
        pending_treasury_arb_approved: bool,
        pending_timelock_ms: u64,
        pending_timelock_effective_at_ms: u64,
        has_pending_timelock_update: bool,
        pending_timelock_treasury_approved: bool,
    }

    struct CapInitialized has copy, drop {
        cap_kind: u8,
        owner: address,
    }

    struct GovernanceConfigInitialized has copy, drop {
        config_id: address,
        actor: address,
        cap_rotation_timelock_ms: u64,
    }

    struct CapRotationQueued has copy, drop {
        cap_kind: u8,
        actor: address,
        new_owner: address,
        effective_at_ms: u64,
    }

    struct EmergencyRotationModeSet has copy, drop {
        actor: address,
        enabled: bool,
    }

    struct IncidentFreezeSet has copy, drop {
        actor: address,
        enabled: bool,
    }

    struct CapRotationApproved has copy, drop {
        cap_kind: u8,
        actor: address,
        approver_kind: u8,
    }

    struct CapRotationCanceled has copy, drop {
        cap_kind: u8,
        actor: address,
        pending_owner: address,
    }

    struct CapRotated has copy, drop {
        cap_kind: u8,
        actor: address,
        previous_owner: address,
        new_owner: address,
    }

    struct TimelockUpdateQueued has copy, drop {
        actor: address,
        new_timelock_ms: u64,
        effective_at_ms: u64,
    }

    struct TimelockUpdateApproved has copy, drop {
        actor: address,
    }

    struct TimelockUpdateCanceled has copy, drop {
        actor: address,
        pending_timelock_ms: u64,
    }

    struct TimelockUpdated has copy, drop {
        actor: address,
        previous_timelock_ms: u64,
        new_timelock_ms: u64,
    }

    public fun apply_admin_cap_rotation(arg0: AdminCap, arg1: &mut GovernanceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_admin_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        assert!(arg1.pending_admin_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_not_approved());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.pending_admin_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_timelock_not_elapsed());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.pending_admin_owner;
        arg1.pending_admin_owner = @0x0;
        arg1.pending_admin_effective_at_ms = 0;
        arg1.has_pending_admin_rotation = false;
        arg1.pending_admin_treasury_approved = false;
        0x2::transfer::transfer<AdminCap>(arg0, v1);
        let v2 = CapRotated{
            cap_kind       : 0,
            actor          : v0,
            previous_owner : v0,
            new_owner      : v1,
        };
        0x2::event::emit<CapRotated>(v2);
    }

    public fun apply_arb_cap_rotation(arg0: ArbCap, arg1: &mut GovernanceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_arb_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        assert!(arg1.pending_arb_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_not_approved());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.pending_arb_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_timelock_not_elapsed());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.pending_arb_owner;
        arg1.pending_arb_owner = @0x0;
        arg1.pending_arb_effective_at_ms = 0;
        arg1.has_pending_arb_rotation = false;
        arg1.pending_arb_treasury_approved = false;
        0x2::transfer::transfer<ArbCap>(arg0, v1);
        let v2 = CapRotated{
            cap_kind       : 1,
            actor          : v0,
            previous_owner : v0,
            new_owner      : v1,
        };
        0x2::event::emit<CapRotated>(v2);
    }

    public fun apply_timelock_update(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_timelock_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        assert!(arg1.pending_timelock_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_not_approved());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.pending_timelock_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_timelock_not_elapsed());
        arg1.cap_rotation_timelock_ms = arg1.pending_timelock_ms;
        arg1.pending_timelock_ms = 0;
        arg1.pending_timelock_effective_at_ms = 0;
        arg1.has_pending_timelock_update = false;
        arg1.pending_timelock_treasury_approved = false;
        let v0 = TimelockUpdated{
            actor                : 0x2::tx_context::sender(arg3),
            previous_timelock_ms : arg1.cap_rotation_timelock_ms,
            new_timelock_ms      : arg1.cap_rotation_timelock_ms,
        };
        0x2::event::emit<TimelockUpdated>(v0);
    }

    public fun apply_treasury_cap_rotation(arg0: TreasuryCap, arg1: &mut GovernanceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_treasury_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        assert!(arg1.pending_treasury_arb_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_not_approved());
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.pending_treasury_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_cap_rotation_timelock_not_elapsed());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.pending_treasury_owner;
        arg1.pending_treasury_owner = @0x0;
        arg1.pending_treasury_effective_at_ms = 0;
        arg1.has_pending_treasury_rotation = false;
        arg1.pending_treasury_arb_approved = false;
        0x2::transfer::transfer<TreasuryCap>(arg0, v1);
        let v2 = CapRotated{
            cap_kind       : 2,
            actor          : v0,
            previous_owner : v0,
            new_owner      : v1,
        };
        0x2::event::emit<CapRotated>(v2);
    }

    public fun approve_pending_admin_cap_rotation(arg0: &TreasuryCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_admin_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_admin_treasury_approved = true;
        let v0 = CapRotationApproved{
            cap_kind      : 0,
            actor         : 0x2::tx_context::sender(arg2),
            approver_kind : 2,
        };
        0x2::event::emit<CapRotationApproved>(v0);
    }

    public fun approve_pending_arb_cap_rotation(arg0: &TreasuryCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_arb_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_arb_treasury_approved = true;
        let v0 = CapRotationApproved{
            cap_kind      : 1,
            actor         : 0x2::tx_context::sender(arg2),
            approver_kind : 2,
        };
        0x2::event::emit<CapRotationApproved>(v0);
    }

    public fun approve_pending_timelock_update(arg0: &TreasuryCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_timelock_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_timelock_treasury_approved = true;
        let v0 = TimelockUpdateApproved{actor: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<TimelockUpdateApproved>(v0);
    }

    public fun approve_pending_treasury_cap_rotation(arg0: &ArbCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg1.has_pending_treasury_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_treasury_arb_approved = true;
        let v0 = CapRotationApproved{
            cap_kind      : 2,
            actor         : 0x2::tx_context::sender(arg2),
            approver_kind : 1,
        };
        0x2::event::emit<CapRotationApproved>(v0);
    }

    public fun assert_incident_not_frozen(arg0: &GovernanceConfig) {
        assert!(!arg0.incident_freeze_active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_incident_freeze_active());
    }

    fun assert_valid_new_owner(arg0: address) {
        assert!(arg0 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_address());
    }

    public fun cancel_pending_admin_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_admin_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_admin_owner = @0x0;
        arg1.pending_admin_effective_at_ms = 0;
        arg1.has_pending_admin_rotation = false;
        arg1.pending_admin_treasury_approved = false;
        let v0 = CapRotationCanceled{
            cap_kind      : 0,
            actor         : 0x2::tx_context::sender(arg2),
            pending_owner : arg1.pending_admin_owner,
        };
        0x2::event::emit<CapRotationCanceled>(v0);
    }

    public fun cancel_pending_arb_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_arb_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_arb_owner = @0x0;
        arg1.pending_arb_effective_at_ms = 0;
        arg1.has_pending_arb_rotation = false;
        arg1.pending_arb_treasury_approved = false;
        let v0 = CapRotationCanceled{
            cap_kind      : 1,
            actor         : 0x2::tx_context::sender(arg2),
            pending_owner : arg1.pending_arb_owner,
        };
        0x2::event::emit<CapRotationCanceled>(v0);
    }

    public fun cancel_pending_timelock_update(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_timelock_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_timelock_ms = 0;
        arg1.pending_timelock_effective_at_ms = 0;
        arg1.has_pending_timelock_update = false;
        arg1.pending_timelock_treasury_approved = false;
        let v0 = TimelockUpdateCanceled{
            actor               : 0x2::tx_context::sender(arg2),
            pending_timelock_ms : arg1.pending_timelock_ms,
        };
        0x2::event::emit<TimelockUpdateCanceled>(v0);
    }

    public fun cancel_pending_treasury_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_treasury_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_cap_rotation());
        arg1.pending_treasury_owner = @0x0;
        arg1.pending_treasury_effective_at_ms = 0;
        arg1.has_pending_treasury_rotation = false;
        arg1.pending_treasury_arb_approved = false;
        let v0 = CapRotationCanceled{
            cap_kind      : 2,
            actor         : 0x2::tx_context::sender(arg2),
            pending_owner : arg1.pending_treasury_owner,
        };
        0x2::event::emit<CapRotationCanceled>(v0);
    }

    public fun cap_rotation_timelock_ms(arg0: &GovernanceConfig) : u64 {
        arg0.cap_rotation_timelock_ms
    }

    public fun emergency_rotation_enabled(arg0: &GovernanceConfig) : bool {
        arg0.allow_emergency_rotation
    }

    fun emit_initialized(arg0: address) {
        let v0 = CapInitialized{
            cap_kind : 0,
            owner    : arg0,
        };
        0x2::event::emit<CapInitialized>(v0);
        let v1 = CapInitialized{
            cap_kind : 1,
            owner    : arg0,
        };
        0x2::event::emit<CapInitialized>(v1);
        let v2 = CapInitialized{
            cap_kind : 2,
            owner    : arg0,
        };
        0x2::event::emit<CapInitialized>(v2);
    }

    public(friend) fun governance_uid(arg0: &GovernanceConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun governance_uid_mut(arg0: &mut GovernanceConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun incident_freeze_enabled(arg0: &GovernanceConfig) : bool {
        arg0.incident_freeze_active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2, v3) = new_caps(arg0);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::transfer<ArbCap>(v2, v0);
        0x2::transfer::transfer<TreasuryCap>(v3, v0);
        emit_initialized(v0);
        let v4 = new_governance_config(86400000, arg0);
        let v5 = 0x2::object::id<GovernanceConfig>(&v4);
        let v6 = GovernanceConfigInitialized{
            config_id                : 0x2::object::id_to_address(&v5),
            actor                    : v0,
            cap_rotation_timelock_ms : v4.cap_rotation_timelock_ms,
        };
        0x2::event::emit<GovernanceConfigInitialized>(v6);
        0x2::transfer::share_object<GovernanceConfig>(v4);
    }

    fun new_caps(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, ArbCap, TreasuryCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ArbCap{id: 0x2::object::new(arg0)};
        let v2 = TreasuryCap{id: 0x2::object::new(arg0)};
        (v0, v1, v2)
    }

    fun new_governance_config(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : GovernanceConfig {
        assert!(arg0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        GovernanceConfig{
            id                                 : 0x2::object::new(arg1),
            cap_rotation_timelock_ms           : arg0,
            allow_emergency_rotation           : false,
            incident_freeze_active             : false,
            pending_admin_owner                : @0x0,
            pending_admin_effective_at_ms      : 0,
            has_pending_admin_rotation         : false,
            pending_admin_treasury_approved    : false,
            pending_arb_owner                  : @0x0,
            pending_arb_effective_at_ms        : 0,
            has_pending_arb_rotation           : false,
            pending_arb_treasury_approved      : false,
            pending_treasury_owner             : @0x0,
            pending_treasury_effective_at_ms   : 0,
            has_pending_treasury_rotation      : false,
            pending_treasury_arb_approved      : false,
            pending_timelock_ms                : 0,
            pending_timelock_effective_at_ms   : 0,
            has_pending_timelock_update        : false,
            pending_timelock_treasury_approved : false,
        }
    }

    public fun pending_admin_rotation_approved(arg0: &GovernanceConfig) : bool {
        arg0.pending_admin_treasury_approved
    }

    public fun pending_arb_rotation_approved(arg0: &GovernanceConfig) : bool {
        arg0.pending_arb_treasury_approved
    }

    public fun pending_treasury_rotation_approved(arg0: &GovernanceConfig) : bool {
        arg0.pending_treasury_arb_approved
    }

    public fun queue_admin_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert_valid_new_owner(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.cap_rotation_timelock_ms;
        queue_cap_rotation(0, arg1, arg2, v0, 0x2::tx_context::sender(arg4));
    }

    public fun queue_arb_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert_valid_new_owner(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.cap_rotation_timelock_ms;
        queue_cap_rotation(1, arg1, arg2, v0, 0x2::tx_context::sender(arg4));
    }

    fun queue_cap_rotation(arg0: u8, arg1: &mut GovernanceConfig, arg2: address, arg3: u64, arg4: address) {
        if (arg0 == 0) {
            assert!(!arg1.has_pending_admin_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
            arg1.pending_admin_owner = arg2;
            arg1.pending_admin_effective_at_ms = arg3;
            arg1.has_pending_admin_rotation = true;
            arg1.pending_admin_treasury_approved = false;
        } else if (arg0 == 1) {
            assert!(!arg1.has_pending_arb_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
            arg1.pending_arb_owner = arg2;
            arg1.pending_arb_effective_at_ms = arg3;
            arg1.has_pending_arb_rotation = true;
            arg1.pending_arb_treasury_approved = false;
        } else {
            assert!(!arg1.has_pending_treasury_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
            arg1.pending_treasury_owner = arg2;
            arg1.pending_treasury_effective_at_ms = arg3;
            arg1.has_pending_treasury_rotation = true;
            arg1.pending_treasury_arb_approved = false;
        };
        let v0 = CapRotationQueued{
            cap_kind        : arg0,
            actor           : arg4,
            new_owner       : arg2,
            effective_at_ms : arg3,
        };
        0x2::event::emit<CapRotationQueued>(v0);
    }

    public fun queue_timelock_update(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert!(arg2 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(!arg1.has_pending_timelock_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.cap_rotation_timelock_ms;
        arg1.pending_timelock_ms = arg2;
        arg1.pending_timelock_effective_at_ms = v0;
        arg1.has_pending_timelock_update = true;
        arg1.pending_timelock_treasury_approved = false;
        let v1 = TimelockUpdateQueued{
            actor           : 0x2::tx_context::sender(arg4),
            new_timelock_ms : arg2,
            effective_at_ms : v0,
        };
        0x2::event::emit<TimelockUpdateQueued>(v1);
    }

    public fun queue_treasury_cap_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_incident_not_frozen(arg1);
        assert_valid_new_owner(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.cap_rotation_timelock_ms;
        queue_cap_rotation(2, arg1, arg2, v0, 0x2::tx_context::sender(arg4));
    }

    public fun rotate_admin_cap(arg0: AdminCap, arg1: &GovernanceConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.incident_freeze_active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg1.allow_emergency_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert_valid_new_owner(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
        let v1 = CapRotated{
            cap_kind       : 0,
            actor          : v0,
            previous_owner : v0,
            new_owner      : arg2,
        };
        0x2::event::emit<CapRotated>(v1);
    }

    public fun rotate_arb_cap(arg0: ArbCap, arg1: &GovernanceConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.incident_freeze_active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg1.allow_emergency_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert_valid_new_owner(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<ArbCap>(arg0, arg2);
        let v1 = CapRotated{
            cap_kind       : 1,
            actor          : v0,
            previous_owner : v0,
            new_owner      : arg2,
        };
        0x2::event::emit<CapRotated>(v1);
    }

    public fun rotate_treasury_cap(arg0: TreasuryCap, arg1: &GovernanceConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.incident_freeze_active, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg1.allow_emergency_rotation, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert_valid_new_owner(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<TreasuryCap>(arg0, arg2);
        let v1 = CapRotated{
            cap_kind       : 2,
            actor          : v0,
            previous_owner : v0,
            new_owner      : arg2,
        };
        0x2::event::emit<CapRotated>(v1);
    }

    public fun set_allow_emergency_rotation(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.allow_emergency_rotation = arg2;
        let v0 = EmergencyRotationModeSet{
            actor   : 0x2::tx_context::sender(arg3),
            enabled : arg2,
        };
        0x2::event::emit<EmergencyRotationModeSet>(v0);
    }

    public fun set_incident_freeze(arg0: &AdminCap, arg1: &mut GovernanceConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.incident_freeze_active = arg2;
        let v0 = IncidentFreezeSet{
            actor   : 0x2::tx_context::sender(arg3),
            enabled : arg2,
        };
        0x2::event::emit<IncidentFreezeSet>(v0);
    }

    // decompiled from Move bytecode v7
}

