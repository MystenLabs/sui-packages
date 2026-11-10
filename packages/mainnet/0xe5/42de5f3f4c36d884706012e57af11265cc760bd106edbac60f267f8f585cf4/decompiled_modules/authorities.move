module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities {
    struct GovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct MigrationCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CompositionCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct EmergencyUpgradeCap has store, key {
        id: 0x2::object::UID,
    }

    struct PendingRotation has drop, store {
        target: u8,
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        proposed_at_ms: u64,
        executable_after_ms: u64,
    }

    struct Authorities has store {
        governance: 0x2::object::ID,
        migration: 0x2::object::ID,
        pause: 0x2::object::ID,
        oracle: 0x2::object::ID,
        composition: 0x2::object::ID,
        keeper: 0x2::object::ID,
        emergency: 0x2::object::ID,
        pending: 0x1::option::Option<PendingRotation>,
    }

    struct RotationProposed has copy, drop {
        target: u8,
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        proposed_at_ms: u64,
        executable_after_ms: u64,
    }

    struct RotationExecuted has copy, drop {
        target: u8,
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct RotationCancelled has copy, drop {
        target: u8,
        from: 0x2::object::ID,
        abandoned: 0x2::object::ID,
    }

    struct FastRotationExecuted has copy, drop {
        target: u8,
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        timestamp_ms: u64,
    }

    fun apply(arg0: &mut Authorities, arg1: u8, arg2: 0x2::object::ID) {
        if (arg1 == 0) {
            arg0.pause = arg2;
        } else if (arg1 == 1) {
            arg0.oracle = arg2;
        } else if (arg1 == 2) {
            arg0.composition = arg2;
        } else if (arg1 == 3) {
            arg0.keeper = arg2;
        } else if (arg1 == 4) {
            arg0.migration = arg2;
        } else if (arg1 == 5) {
            arg0.governance = arg2;
        } else {
            assert!(arg1 == 6, 704);
            arg0.emergency = arg2;
        };
    }

    public(friend) fun assert_composition(arg0: &Authorities, arg1: &CompositionCap) {
        assert!(0x2::object::id<CompositionCap>(arg1) == arg0.composition, 700);
    }

    public(friend) fun assert_emergency(arg0: &Authorities, arg1: &EmergencyUpgradeCap) {
        assert!(0x2::object::id<EmergencyUpgradeCap>(arg1) == arg0.emergency, 700);
    }

    public(friend) fun assert_governance(arg0: &Authorities, arg1: &GovernanceCap) {
        assert!(0x2::object::id<GovernanceCap>(arg1) == arg0.governance, 700);
    }

    public(friend) fun assert_keeper(arg0: &Authorities, arg1: &KeeperCap) {
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper, 700);
    }

    public(friend) fun assert_migration(arg0: &Authorities, arg1: &MigrationCap) {
        assert!(0x2::object::id<MigrationCap>(arg1) == arg0.migration, 700);
    }

    public(friend) fun assert_oracle(arg0: &Authorities, arg1: &OracleAdminCap) {
        assert!(0x2::object::id<OracleAdminCap>(arg1) == arg0.oracle, 700);
    }

    public(friend) fun assert_pause(arg0: &Authorities, arg1: &PauseCap) {
        assert!(0x2::object::id<PauseCap>(arg1) == arg0.pause, 700);
    }

    public(friend) fun cancel_rotation(arg0: &mut Authorities) : (u8, 0x2::object::ID) {
        assert!(0x1::option::is_some<PendingRotation>(&arg0.pending), 702);
        let PendingRotation {
            target              : v0,
            from                : v1,
            to                  : v2,
            proposed_at_ms      : _,
            executable_after_ms : _,
        } = 0x1::option::extract<PendingRotation>(&mut arg0.pending);
        let v5 = RotationCancelled{
            target    : v0,
            from      : v1,
            abandoned : v2,
        };
        0x2::event::emit<RotationCancelled>(v5);
        (v0, v2)
    }

    fun check_new(arg0: &Authorities, arg1: u8, arg2: 0x2::object::ID) : 0x2::object::ID {
        let v0 = current_of(arg0, arg1);
        assert!(arg2 != 0x2::object::id_from_address(@0x0), 706);
        assert!(arg2 != v0, 705);
        v0
    }

    public fun composition_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.composition
    }

    fun current_of(arg0: &Authorities, arg1: u8) : 0x2::object::ID {
        if (arg1 == 0) {
            arg0.pause
        } else if (arg1 == 1) {
            arg0.oracle
        } else if (arg1 == 2) {
            arg0.composition
        } else if (arg1 == 3) {
            arg0.keeper
        } else if (arg1 == 4) {
            arg0.migration
        } else if (arg1 == 5) {
            arg0.governance
        } else {
            assert!(arg1 == 6, 704);
            arg0.emergency
        }
    }

    public fun emergency_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.emergency
    }

    public(friend) fun execute_rotation(arg0: &mut Authorities, arg1: &0x2::clock::Clock) : (u8, 0x2::object::ID, 0x2::object::ID) {
        assert!(0x1::option::is_some<PendingRotation>(&arg0.pending), 702);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x1::option::borrow<PendingRotation>(&arg0.pending);
        assert!(v0 >= v1.executable_after_ms, 703);
        assert!(current_of(arg0, v1.target) == v1.from, 707);
        let PendingRotation {
            target              : v2,
            from                : v3,
            to                  : v4,
            proposed_at_ms      : _,
            executable_after_ms : _,
        } = 0x1::option::extract<PendingRotation>(&mut arg0.pending);
        apply(arg0, v2, v4);
        let v7 = RotationExecuted{
            target       : v2,
            from         : v3,
            to           : v4,
            timestamp_ms : v0,
        };
        0x2::event::emit<RotationExecuted>(v7);
        (v2, v3, v4)
    }

    public(friend) fun fast_rotation(arg0: &mut Authorities, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x2::object::ID {
        let v0 = check_new(arg0, arg1, arg2);
        apply(arg0, arg1, arg2);
        let v1 = FastRotationExecuted{
            target       : arg1,
            from         : v0,
            to           : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FastRotationExecuted>(v1);
        v0
    }

    public fun governance_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.governance
    }

    public fun has_pending_rotation(arg0: &Authorities) : bool {
        0x1::option::is_some<PendingRotation>(&arg0.pending)
    }

    public(friend) fun is_root_target(arg0: u8) : bool {
        arg0 == 5 || arg0 == 6
    }

    public fun keeper_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.keeper
    }

    public fun migration_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.migration
    }

    public(friend) fun mint_all(arg0: &mut 0x2::tx_context::TxContext) : (GovernanceCap, MigrationCap, PauseCap, OracleAdminCap, CompositionCap, KeeperCap, EmergencyUpgradeCap, Authorities) {
        let v0 = GovernanceCap{id: 0x2::object::new(arg0)};
        let v1 = MigrationCap{id: 0x2::object::new(arg0)};
        let v2 = PauseCap{id: 0x2::object::new(arg0)};
        let v3 = OracleAdminCap{id: 0x2::object::new(arg0)};
        let v4 = CompositionCap{id: 0x2::object::new(arg0)};
        let v5 = KeeperCap{id: 0x2::object::new(arg0)};
        let v6 = EmergencyUpgradeCap{id: 0x2::object::new(arg0)};
        let v7 = Authorities{
            governance  : 0x2::object::id<GovernanceCap>(&v0),
            migration   : 0x2::object::id<MigrationCap>(&v1),
            pause       : 0x2::object::id<PauseCap>(&v2),
            oracle      : 0x2::object::id<OracleAdminCap>(&v3),
            composition : 0x2::object::id<CompositionCap>(&v4),
            keeper      : 0x2::object::id<KeeperCap>(&v5),
            emergency   : 0x2::object::id<EmergencyUpgradeCap>(&v6),
            pending     : 0x1::option::none<PendingRotation>(),
        };
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun oracle_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.oracle
    }

    public fun pause_id(arg0: &Authorities) : 0x2::object::ID {
        arg0.pause
    }

    public fun pending_rotation(arg0: &Authorities) : 0x1::option::Option<u8> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<u8>(0x1::option::borrow<PendingRotation>(&arg0.pending).target)
        } else {
            0x1::option::none<u8>()
        }
    }

    public(friend) fun pending_rotation_count(arg0: &Authorities) : u64 {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            1
        } else {
            0
        }
    }

    public fun pending_rotation_effective_ms(arg0: &Authorities) : u64 {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::borrow<PendingRotation>(&arg0.pending).executable_after_ms
        } else {
            0
        }
    }

    public fun pending_rotation_to(arg0: &Authorities) : 0x1::option::Option<0x2::object::ID> {
        if (0x1::option::is_some<PendingRotation>(&arg0.pending)) {
            0x1::option::some<0x2::object::ID>(0x1::option::borrow<PendingRotation>(&arg0.pending).to)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun propose_rotation(arg0: &mut Authorities, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x1::option::is_none<PendingRotation>(&arg0.pending), 701);
        let v0 = check_new(arg0, arg1, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + 172800000;
        let v3 = PendingRotation{
            target              : arg1,
            from                : v0,
            to                  : arg2,
            proposed_at_ms      : v1,
            executable_after_ms : v2,
        };
        0x1::option::fill<PendingRotation>(&mut arg0.pending, v3);
        let v4 = RotationProposed{
            target              : arg1,
            from                : v0,
            to                  : arg2,
            proposed_at_ms      : v1,
            executable_after_ms : v2,
        };
        0x2::event::emit<RotationProposed>(v4);
        v2
    }

    public fun rotation_timelock_ms() : u64 {
        172800000
    }

    public fun target_composition() : u8 {
        2
    }

    public fun target_emergency() : u8 {
        6
    }

    public fun target_governance() : u8 {
        5
    }

    public fun target_keeper() : u8 {
        3
    }

    public fun target_migration() : u8 {
        4
    }

    public fun target_oracle() : u8 {
        1
    }

    public fun target_pause() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

