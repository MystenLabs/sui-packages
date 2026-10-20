module 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct TimelockStateV1 has store, key {
        id: 0x2::object::UID,
        min_delay_ms: u64,
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

    struct DelayRaisedEventV1 has copy, drop {
        lock_id: 0x2::object::ID,
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    public fun commit_upgrade(arg0: &mut Timelock, arg1: 0x2::object::ID, arg2: 0x2::package::UpgradeReceipt) {
        assert!(arg0.version == 1, 13835059120434053121);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg1), 13836466512498130955);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg1);
        assert!(0x2::package::receipt_cap(&arg2) == 0x2::object::id<0x2::package::UpgradeCap>(&v2.upgrade_cap), 13837029471041749007);
        0x2::package::commit_upgrade(&mut v2.upgrade_cap, arg2);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 30);
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

    public fun cancel_upgrade(arg0: &mut Timelock, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0x2::object::ID) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058871325949953);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466267684995083);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v2.pending_digest), 13835621851344404485);
        v2.eta_ms = 0;
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 76);
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
            id           : 0x2::object::new(arg0),
            min_delay_ms : 86400000,
            slots        : 0x2::table::new<0x2::object::ID, UpgradeSlot>(arg0),
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::add<TimelockStateV1>(&mut v1.id, v0, v2);
        v1
    }

    public fun deposit_upgrade_cap(arg0: &mut Timelock, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0x2::package::UpgradeCap) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058652282617857);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = 0x2::package::upgrade_package(&arg3);
        let v2 = state_mut(arg0);
        assert!(!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v2.slots, v1), 13836747532208439309);
        let v3 = UpgradeSlot{
            pending_digest : 0x1::option::none<vector<u8>>(),
            eta_ms         : 0,
            upgrade_cap    : arg3,
        };
        0x2::table::add<0x2::object::ID, UpgradeSlot>(&mut v2.slots, v1, v3);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v4, 0x2::object::id<Timelock>(arg0), 29);
        let v5 = UpgradeCapDepositedEventV1{
            lock_id    : v0,
            package_id : v1,
            cap_id     : 0x2::object::id<0x2::package::UpgradeCap>(&arg3),
        };
        0x2::event::emit<UpgradeCapDepositedEventV1>(v5);
    }

    public fun execute_upgrade(arg0: &mut Timelock, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058995880001537);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466392239046667);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v2.pending_digest), 13835621975898456069);
        assert!(*0x1::option::borrow<vector<u8>>(&v2.pending_digest) == arg4, 13836184930147106825);
        assert!(0x2::clock::timestamp_ms(arg5) >= v2.eta_ms, 13835903459465232391);
        0x1::option::extract<vector<u8>>(&mut v2.pending_digest);
        let v3 = 0x2::package::authorize_upgrade(&mut v2.upgrade_cap, 0x2::package::upgrade_policy(&v2.upgrade_cap), arg4);
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v4, 0x2::object::id<Timelock>(arg0), 27);
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
        state(arg0).min_delay_ms
    }

    public fun propose_extension<T0: drop>(arg0: &Timelock, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835059382427058177);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::propose_extension_inner<T0>(arg1, 0x2::clock::timestamp_ms(arg3) + state(arg0).min_delay_ms);
    }

    public fun raise_delay(arg0: &mut Timelock, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835059442556600321);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(arg3 >= v1.min_delay_ms && arg3 >= 86400000, 13835340943303245827);
        assert!(arg3 <= 2592000000, 13837311276731072529);
        v1.min_delay_ms = arg3;
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Timelock>(arg0), 28);
        let v3 = DelayRaisedEventV1{
            lock_id      : v0,
            old_delay_ms : v1.min_delay_ms,
            new_delay_ms : arg3,
        };
        0x2::event::emit<DelayRaisedEventV1>(v3);
    }

    public fun schedule_upgrade(arg0: &mut Timelock, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058759656800257);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 13836184668154101769);
        let v0 = 0x2::object::id<Timelock>(arg0);
        let v1 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v1.slots, arg3), 13836466164605779979);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v1.slots, arg3);
        v2.pending_digest = 0x1::option::some<vector<u8>>(arg4);
        v2.eta_ms = 0x2::clock::timestamp_ms(arg5) + v1.min_delay_ms;
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 26);
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
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow<TimelockStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Timelock) : &mut TimelockStateV1 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow_mut<TimelockStateV1>(&mut arg0.id, arg0.version)
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

