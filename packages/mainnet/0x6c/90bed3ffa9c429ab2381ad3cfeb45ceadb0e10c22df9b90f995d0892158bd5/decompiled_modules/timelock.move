module 0x6c90bed3ffa9c429ab2381ad3cfeb45ceadb0e10c22df9b90f995d0892158bd5::timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
        pending: 0x1::option::Option<Pending>,
    }

    struct Pending has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
        ready_ms: u64,
    }

    struct Locked has copy, drop {
        timelock: 0x2::object::ID,
        package: 0x2::object::ID,
        delay_ms: u64,
    }

    struct Announced has copy, drop {
        package: 0x2::object::ID,
        policy: u8,
        digest: vector<u8>,
        ready_ms: u64,
    }

    struct Cancelled has copy, drop {
        package: 0x2::object::ID,
        digest: vector<u8>,
    }

    struct Upgraded has copy, drop {
        package: 0x2::object::ID,
        version: u64,
    }

    struct MadeImmutable has copy, drop {
        package: 0x2::object::ID,
    }

    entry fun make_immutable(arg0: Timelock) {
        let Timelock {
            id      : v0,
            cap     : v1,
            pending : _,
        } = arg0;
        let v3 = v1;
        let v4 = MadeImmutable{package: 0x2::package::upgrade_package(&v3)};
        0x2::event::emit<MadeImmutable>(v4);
        0x2::object::delete(v0);
        0x2::package::make_immutable(v3);
    }

    entry fun announce(arg0: &mut Timelock, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<Pending>(&arg0.pending), 3);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 172800000;
        let v1 = Pending{
            policy   : arg1,
            digest   : arg2,
            ready_ms : v0,
        };
        arg0.pending = 0x1::option::some<Pending>(v1);
        let v2 = Announced{
            package  : 0x2::package::upgrade_package(&arg0.cap),
            policy   : arg1,
            digest   : arg2,
            ready_ms : v0,
        };
        0x2::event::emit<Announced>(v2);
    }

    public fun authorize(arg0: &mut Timelock, arg1: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 1);
        let v0 = 0x1::option::extract<Pending>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.ready_ms, 2);
        0x2::package::authorize_upgrade(&mut arg0.cap, v0.policy, v0.digest)
    }

    entry fun cancel(arg0: &mut Timelock) {
        assert!(0x1::option::is_some<Pending>(&arg0.pending), 1);
        let v0 = 0x1::option::extract<Pending>(&mut arg0.pending);
        let v1 = Cancelled{
            package : 0x2::package::upgrade_package(&arg0.cap),
            digest  : v0.digest,
        };
        0x2::event::emit<Cancelled>(v1);
    }

    public fun commit(arg0: &mut Timelock, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
        let v0 = Upgraded{
            package : 0x2::package::upgrade_package(&arg0.cap),
            version : 0x2::package::version(&arg0.cap),
        };
        0x2::event::emit<Upgraded>(v0);
    }

    public fun delay_ms() : u64 {
        172800000
    }

    entry fun lock(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Timelock{
            id      : 0x2::object::new(arg1),
            cap     : arg0,
            pending : 0x1::option::none<Pending>(),
        };
        let v1 = Locked{
            timelock : 0x2::object::id<Timelock>(&v0),
            package  : 0x2::package::upgrade_package(&v0.cap),
            delay_ms : 172800000,
        };
        0x2::event::emit<Locked>(v1);
        0x2::transfer::transfer<Timelock>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun ready_ms(arg0: &Timelock) : u64 {
        if (0x1::option::is_some<Pending>(&arg0.pending)) {
            0x1::option::borrow<Pending>(&arg0.pending).ready_ms
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

