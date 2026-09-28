module 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::upgrade_timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
        delay_ms: u64,
        pending: 0x1::option::Option<Proposal>,
    }

    struct Proposal has copy, drop, store {
        digest: vector<u8>,
        policy: u8,
        ready_at_ms: u64,
    }

    struct TimelockAdmin has store, key {
        id: 0x2::object::UID,
        timelock: 0x2::object::ID,
    }

    struct UpgradeProposed has copy, drop {
        package: 0x2::object::ID,
        digest: vector<u8>,
        policy: u8,
        ready_at_ms: u64,
    }

    struct UpgradeCancelled has copy, drop {
        package: 0x2::object::ID,
    }

    struct UpgradeAuthorized has copy, drop {
        package: 0x2::object::ID,
        digest: vector<u8>,
    }

    struct MadeImmutable has copy, drop {
        package: 0x2::object::ID,
    }

    public fun make_immutable(arg0: Timelock, arg1: &TimelockAdmin) {
        assert_admin(&arg0, arg1);
        let Timelock {
            id       : v0,
            cap      : v1,
            delay_ms : _,
            pending  : _,
        } = arg0;
        let v4 = v1;
        let v5 = MadeImmutable{package: 0x2::package::upgrade_package(&v4)};
        0x2::event::emit<MadeImmutable>(v5);
        0x2::object::delete(v0);
        0x2::package::make_immutable(v4);
    }

    public fun admin_timelock(arg0: &TimelockAdmin) : 0x2::object::ID {
        arg0.timelock
    }

    fun assert_admin(arg0: &Timelock, arg1: &TimelockAdmin) {
        assert!(arg1.timelock == 0x2::object::id<Timelock>(arg0), 0);
    }

    public fun authorize(arg0: &mut Timelock, arg1: &TimelockAdmin, arg2: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 1);
        let v0 = 0x1::option::extract<Proposal>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.ready_at_ms, 2);
        let v1 = UpgradeAuthorized{
            package : 0x2::package::upgrade_package(&arg0.cap),
            digest  : v0.digest,
        };
        0x2::event::emit<UpgradeAuthorized>(v1);
        0x2::package::authorize_upgrade(&mut arg0.cap, v0.policy, v0.digest)
    }

    public fun cancel(arg0: &mut Timelock, arg1: &TimelockAdmin) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 1);
        arg0.pending = 0x1::option::none<Proposal>();
        let v0 = UpgradeCancelled{package: 0x2::package::upgrade_package(&arg0.cap)};
        0x2::event::emit<UpgradeCancelled>(v0);
    }

    public fun commit(arg0: &mut Timelock, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    public fun delay_ms(arg0: &Timelock) : u64 {
        arg0.delay_ms
    }

    public fun package_id(arg0: &Timelock) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun pending(arg0: &Timelock) : 0x1::option::Option<Proposal> {
        arg0.pending
    }

    public fun propose(arg0: &mut Timelock, arg1: &TimelockAdmin, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_none<Proposal>(&arg0.pending), 3);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg0.delay_ms;
        let v1 = Proposal{
            digest      : arg2,
            policy      : arg3,
            ready_at_ms : v0,
        };
        arg0.pending = 0x1::option::some<Proposal>(v1);
        let v2 = UpgradeProposed{
            package     : 0x2::package::upgrade_package(&arg0.cap),
            digest      : arg2,
            policy      : arg3,
            ready_at_ms : v0,
        };
        0x2::event::emit<UpgradeProposed>(v2);
    }

    public fun wrap(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TimelockAdmin {
        assert!(arg1 >= 3600000 && arg1 <= 7776000000, 4);
        let v0 = Timelock{
            id       : 0x2::object::new(arg2),
            cap      : arg0,
            delay_ms : arg1,
            pending  : 0x1::option::none<Proposal>(),
        };
        let v1 = TimelockAdmin{
            id       : 0x2::object::new(arg2),
            timelock : 0x2::object::id<Timelock>(&v0),
        };
        0x2::transfer::share_object<Timelock>(v0);
        v1
    }

    // decompiled from Move bytecode v7
}

