module 0xe56b2ce15f4cbdd0756068b166be19f1b1741840a43f31259f8a40bca562f331::timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::package::UpgradeCap>,
        package: 0x2::object::ID,
        delay_ms: u64,
        pending: 0x1::option::Option<Proposal>,
    }

    struct Proposal has copy, drop, store {
        kind: u8,
        digest: vector<u8>,
        policy: u8,
        proposed_ms: u64,
        ready_ms: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        timelock: 0x2::object::ID,
    }

    struct Wrapped has copy, drop {
        timelock: 0x2::object::ID,
        package: 0x2::object::ID,
        delay_ms: u64,
    }

    struct Proposed has copy, drop {
        timelock: 0x2::object::ID,
        package: 0x2::object::ID,
        kind: u8,
        digest: vector<u8>,
        policy: u8,
        ready_ms: u64,
    }

    struct Cancelled has copy, drop {
        timelock: 0x2::object::ID,
        kind: u8,
        digest: vector<u8>,
    }

    struct Authorized has copy, drop {
        timelock: 0x2::object::ID,
        package: 0x2::object::ID,
        digest: vector<u8>,
        policy: u8,
    }

    struct Committed has copy, drop {
        timelock: 0x2::object::ID,
        new_package: 0x2::object::ID,
        version: u64,
    }

    struct Restricted has copy, drop {
        timelock: 0x2::object::ID,
        package: 0x2::object::ID,
        kind: u8,
    }

    struct DelayRaised has copy, drop {
        timelock: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun new(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : OwnerCap {
        assert!(arg1 >= 259200000 && arg1 <= 2592000000, 2);
        let v0 = 0x2::package::upgrade_package(&arg0);
        let v1 = Timelock{
            id       : 0x2::object::new(arg2),
            cap      : 0x1::option::some<0x2::package::UpgradeCap>(arg0),
            package  : v0,
            delay_ms : arg1,
            pending  : 0x1::option::none<Proposal>(),
        };
        let v2 = 0x2::object::id<Timelock>(&v1);
        let v3 = Wrapped{
            timelock : v2,
            package  : v0,
            delay_ms : arg1,
        };
        0x2::event::emit<Wrapped>(v3);
        0x2::transfer::share_object<Timelock>(v1);
        OwnerCap{
            id       : 0x2::object::new(arg2),
            timelock : v2,
        }
    }

    public fun package(arg0: &Timelock) : 0x2::object::ID {
        arg0.package
    }

    public fun authorize_upgrade(arg0: &mut Timelock, arg1: &OwnerCap, arg2: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        check_owner(arg0, arg1);
        let v0 = take_ready(arg0, 0, arg2);
        let v1 = Authorized{
            timelock : 0x2::object::id<Timelock>(arg0),
            package  : arg0.package,
            digest   : v0.digest,
            policy   : v0.policy,
        };
        0x2::event::emit<Authorized>(v1);
        0x2::package::authorize_upgrade(cap_mut(arg0), v0.policy, v0.digest)
    }

    public fun commit_upgrade(arg0: &mut Timelock, arg1: 0x2::package::UpgradeReceipt) {
        let v0 = cap_mut(arg0);
        0x2::package::commit_upgrade(v0, arg1);
        let v1 = Committed{
            timelock    : 0x2::object::id<Timelock>(arg0),
            new_package : 0x2::package::upgrade_package(v0),
            version     : 0x2::package::version(v0),
        };
        0x2::event::emit<Committed>(v1);
    }

    public fun cancel(arg0: &mut Timelock, arg1: &OwnerCap) {
        check_owner(arg0, arg1);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 4);
        let v0 = 0x1::option::extract<Proposal>(&mut arg0.pending);
        let v1 = Cancelled{
            timelock : 0x2::object::id<Timelock>(arg0),
            kind     : v0.kind,
            digest   : v0.digest,
        };
        0x2::event::emit<Cancelled>(v1);
    }

    fun cap(arg0: &Timelock) : &0x2::package::UpgradeCap {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 9);
        0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap)
    }

    fun cap_mut(arg0: &mut Timelock) : &mut 0x2::package::UpgradeCap {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 9);
        0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.cap)
    }

    fun check_owner(arg0: &Timelock, arg1: &OwnerCap) {
        assert!(arg1.timelock == 0x2::object::id<Timelock>(arg0), 1);
    }

    public fun current(arg0: &Timelock) : (0x2::object::ID, u64) {
        if (0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.cap)) {
            return (arg0.package, 0)
        };
        let v0 = 0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.cap);
        (0x2::package::upgrade_package(v0), 0x2::package::version(v0))
    }

    public fun delay_ms(arg0: &Timelock) : u64 {
        arg0.delay_ms
    }

    public fun execute_restrict(arg0: &mut Timelock, arg1: &OwnerCap, arg2: &0x2::clock::Clock) {
        check_owner(arg0, arg1);
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 4);
        let v0 = 0x1::option::borrow<Proposal>(&arg0.pending).kind;
        assert!(v0 != 0, 6);
        take_ready(arg0, v0, arg2);
        if (v0 == 1) {
            let v1 = cap_mut(arg0);
            0x2::package::only_additive_upgrades(v1);
        } else if (v0 == 2) {
            let v2 = cap_mut(arg0);
            0x2::package::only_dep_upgrades(v2);
        } else {
            0x2::package::make_immutable(0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.cap));
        };
        let v3 = Restricted{
            timelock : 0x2::object::id<Timelock>(arg0),
            package  : arg0.package,
            kind     : v0,
        };
        0x2::event::emit<Restricted>(v3);
    }

    public fun execute_window_ms() : u64 {
        604800000
    }

    public fun is_immutable(arg0: &Timelock) : bool {
        0x1::option::is_none<0x2::package::UpgradeCap>(&arg0.cap)
    }

    public fun min_delay_ms() : u64 {
        259200000
    }

    public fun owner_timelock(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.timelock
    }

    public fun pending(arg0: &Timelock) : 0x1::option::Option<Proposal> {
        arg0.pending
    }

    public fun proposal_digest(arg0: &Proposal) : vector<u8> {
        arg0.digest
    }

    public fun proposal_kind(arg0: &Proposal) : u8 {
        arg0.kind
    }

    public fun proposal_policy(arg0: &Proposal) : u8 {
        arg0.policy
    }

    public fun proposal_ready_ms(arg0: &Proposal) : u64 {
        arg0.ready_ms
    }

    fun propose(arg0: &mut Timelock, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.cap), 9);
        assert!(0x1::option::is_none<Proposal>(&arg0.pending), 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + arg0.delay_ms;
        let v2 = Proposal{
            kind        : arg1,
            digest      : arg2,
            policy      : arg3,
            proposed_ms : v0,
            ready_ms    : v1,
        };
        0x1::option::fill<Proposal>(&mut arg0.pending, v2);
        let v3 = Proposed{
            timelock : 0x2::object::id<Timelock>(arg0),
            package  : arg0.package,
            kind     : arg1,
            digest   : arg2,
            policy   : arg3,
            ready_ms : v1,
        };
        0x2::event::emit<Proposed>(v3);
    }

    public fun propose_restrict(arg0: &mut Timelock, arg1: &OwnerCap, arg2: u8, arg3: &0x2::clock::Clock) {
        check_owner(arg0, arg1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 11);
        if (arg2 == 1) {
            assert!(0x2::package::upgrade_policy(cap(arg0)) < 0x2::package::additive_policy(), 13);
        } else if (arg2 == 2) {
            assert!(0x2::package::upgrade_policy(cap(arg0)) < 0x2::package::dep_only_policy(), 13);
        };
        propose(arg0, arg2, b"", 0, arg3);
    }

    public fun propose_upgrade(arg0: &mut Timelock, arg1: &OwnerCap, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        check_owner(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 7);
        let v0 = if (arg3 == 0x2::package::compatible_policy()) {
            true
        } else if (arg3 == 0x2::package::additive_policy()) {
            true
        } else {
            arg3 == 0x2::package::dep_only_policy()
        };
        assert!(v0, 8);
        assert!(arg3 >= 0x2::package::upgrade_policy(cap(arg0)), 8);
        propose(arg0, 0, arg2, arg3, arg4);
    }

    public fun raise_delay(arg0: &mut Timelock, arg1: &OwnerCap, arg2: u64) {
        check_owner(arg0, arg1);
        assert!(arg2 > arg0.delay_ms, 10);
        assert!(arg2 <= 2592000000, 2);
        let v0 = DelayRaised{
            timelock : 0x2::object::id<Timelock>(arg0),
            from     : arg0.delay_ms,
            to       : arg2,
        };
        0x2::event::emit<DelayRaised>(v0);
        arg0.delay_ms = arg2;
    }

    fun take_ready(arg0: &mut Timelock, arg1: u8, arg2: &0x2::clock::Clock) : Proposal {
        assert!(0x1::option::is_some<Proposal>(&arg0.pending), 4);
        let v0 = 0x1::option::extract<Proposal>(&mut arg0.pending);
        assert!(v0.kind == arg1, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.ready_ms, 5);
        assert!(0x2::clock::timestamp_ms(arg2) <= v0.ready_ms + 604800000, 12);
        v0
    }

    // decompiled from Move bytecode v7
}

