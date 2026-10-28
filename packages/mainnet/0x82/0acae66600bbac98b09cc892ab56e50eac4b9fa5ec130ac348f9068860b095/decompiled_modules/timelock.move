module 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct TimelockStateV1 has store, key {
        id: 0x2::object::UID,
        slots: 0x2::table::Table<0x2::object::ID, UpgradeSlot>,
    }

    struct UpgradeSlot has store {
        pending_digest: 0x1::option::Option<vector<u8>>,
        eta_ms: u64,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    struct UpgradeCapDepositedEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct UpgradeScheduledEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        digest: vector<u8>,
        eta_ms: u64,
    }

    struct UpgradeCancelledEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        digest: vector<u8>,
        eta_ms: u64,
    }

    struct UpgradeAuthorizedEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        from_package_id: 0x2::object::ID,
        digest: vector<u8>,
        policy: u8,
    }

    struct UpgradeCommittedEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        new_package_id: 0x2::object::ID,
        new_version: u64,
    }

    public fun commit_upgrade(arg0: &mut Timelock, arg1: 0x2::object::ID, arg2: 0x2::package::UpgradeReceipt) {
        assert!(arg0.version == 1, 13835059051714576385);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg1), 13836466443778392071);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg1);
        assert!(0x2::package::receipt_cap(&arg2) == 0x2::object::id<0x2::package::UpgradeCap>(&v2.upgrade_cap), 13837029402322010123);
        0x2::package::commit_upgrade(&mut v2.upgrade_cap, arg2);
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::new();
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 30);
        let v4 = UpgradeCommittedEventV1{
            lock_id        : v0,
            package_id     : arg1,
            new_package_id : 0x2::package::upgrade_package(&v2.upgrade_cap),
            new_version    : 0x2::package::version(&v2.upgrade_cap),
        };
        0x2::event::emit<UpgradeCommittedEventV1>(v4);
    }

    public fun upgrade_package(arg0: &Timelock, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        let v0 = state(arg0);
        if (!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::package::upgrade_package(&0x2::table::borrow<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1).upgrade_cap))
        }
    }

    public fun cancel_upgrade(arg0: &mut Timelock, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: 0x2::object::ID) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058806901440513);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466203260223495);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v2.pending_digest), 13835621786919763971);
        v2.eta_ms = 0;
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::new();
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 76);
        let v4 = UpgradeCancelledEventV1{
            lock_id    : v0,
            package_id : arg3,
            digest     : 0x1::option::extract<vector<u8>>(&mut v2.pending_digest),
            eta_ms     : v2.eta_ms,
        };
        0x2::event::emit<UpgradeCancelledEventV1>(v4);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Timelock {
        let v0 = 1;
        let v1 = Timelock{
            id      : 0x2::object::new(arg0),
            version : v0,
        };
        let v2 = TimelockStateV1{
            id    : 0x2::object::new(arg0),
            slots : 0x2::table::new<0x2::object::ID, UpgradeSlot>(arg0),
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::extended_field::add<TimelockStateV1>(&mut v1.id, v0, v2);
        v1
    }

    public fun deposit_upgrade_cap(arg0: &mut Timelock, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: 0x2::package::UpgradeCap) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058592153075713);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = 0x2::package::upgrade_package(&arg3);
        let v2 = state_mut(arg0);
        assert!(!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v2.slots, v1), 13836747472078635017);
        let v3 = UpgradeSlot{
            pending_digest : 0x1::option::none<vector<u8>>(),
            eta_ms         : 0,
            upgrade_cap    : arg3,
        };
        0x2::table::add<0x2::object::ID, UpgradeSlot>(&mut v2.slots, v1, v3);
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::new();
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(&v4, 0x2::object::id<Timelock>(arg0), 29);
        let v5 = UpgradeCapDepositedEventV1{
            lock_id    : v0,
            package_id : v1,
            cap_id     : 0x2::object::id<0x2::package::UpgradeCap>(&arg3),
        };
        0x2::event::emit<UpgradeCapDepositedEventV1>(v5);
    }

    public fun execute_upgrade(arg0: &mut Timelock, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058931455492097);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466327814275079);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v2.pending_digest), 13835621911473815555);
        assert!(*0x1::option::borrow<vector<u8>>(&v2.pending_digest) == arg4, 13836184865722335237);
        0x1::option::extract<vector<u8>>(&mut v2.pending_digest);
        let v3 = 0x2::package::authorize_upgrade(&mut v2.upgrade_cap, 0x2::package::upgrade_policy(&v2.upgrade_cap), arg4);
        let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::new();
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(&v4, 0x2::object::id<Timelock>(arg0), 27);
        let v5 = UpgradeAuthorizedEventV1{
            lock_id         : v0,
            package_id      : arg3,
            from_package_id : 0x2::package::upgrade_package(&v2.upgrade_cap),
            digest          : *0x2::package::ticket_digest(&v3),
            policy          : 0x2::package::ticket_policy(&v3),
        };
        0x2::event::emit<UpgradeAuthorizedEventV1>(v5);
        v3
    }

    public fun min_delay_ms(arg0: &Timelock) : u64 {
        0
    }

    public fun propose_extension<T0: drop>(arg0: &Timelock, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835059326592483329);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::propose_extension_inner<T0>(arg1, 0x2::clock::timestamp_ms(arg3));
    }

    public fun schedule_upgrade(arg0: &mut Timelock, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058699527258113);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 13836184608024297477);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466100181008391);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        v2.pending_digest = 0x1::option::some<vector<u8>>(arg4);
        v2.eta_ms = 0x2::clock::timestamp_ms(arg5);
        let v3 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::new();
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 26);
        let v4 = UpgradeScheduledEventV1{
            lock_id    : v0,
            package_id : arg3,
            digest     : arg4,
            eta_ms     : v2.eta_ms,
        };
        0x2::event::emit<UpgradeScheduledEventV1>(v4);
    }

    public(friend) fun share(arg0: Timelock) {
        0x2::transfer::share_object<Timelock>(arg0);
    }

    fun state(arg0: &Timelock) : &TimelockStateV1 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::extended_field::borrow<TimelockStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Timelock) : &mut TimelockStateV1 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::extended_field::borrow_mut<TimelockStateV1>(&mut arg0.id, arg0.version)
    }

    public fun upgrade_version(arg0: &Timelock, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = state(arg0);
        if (!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0x2::package::version(&0x2::table::borrow<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1).upgrade_cap))
        }
    }

    // decompiled from Move bytecode v7
}

