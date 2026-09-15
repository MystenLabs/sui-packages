module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::funding_policy {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Proposal has drop, store {
        target: u64,
        execute_ms: u64,
    }

    struct Proposed has copy, drop {
        pool: 0x2::object::ID,
        target: u64,
        execute_ms: u64,
    }

    struct Executed has copy, drop {
        pool: 0x2::object::ID,
        target: u64,
    }

    struct Cancelled has copy, drop {
        pool: 0x2::object::ID,
    }

    public(friend) fun cancel(arg0: &mut 0x2::object::UID) {
        let v0 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists_<Key>(arg0, v0)) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::remove<Key, Proposal>(arg0, v1);
            let v2 = Cancelled{pool: 0x2::object::uid_to_inner(arg0)};
            0x2::event::emit<Cancelled>(v2);
        };
    }

    public(friend) fun execute(arg0: &mut 0x2::object::UID, arg1: &0x2::clock::Clock) : u64 {
        let v0 = Key{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<Key>(arg0, v0), 1);
        let v1 = Key{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::dynamic_field::borrow<Key, Proposal>(arg0, v1).execute_ms, 2);
        let v2 = Key{dummy_field: false};
        let Proposal {
            target     : v3,
            execute_ms : _,
        } = 0x2::dynamic_field::remove<Key, Proposal>(arg0, v2);
        let v5 = Executed{
            pool   : 0x2::object::uid_to_inner(arg0),
            target : v3,
        };
        0x2::event::emit<Executed>(v5);
        v3
    }

    public(friend) fun propose(arg0: &mut 0x2::object::UID, arg1: &0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::config::Config, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) + 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::config::timelock(0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::config::params(arg1));
        let v1 = Key{dummy_field: false};
        if (0x2::dynamic_field::exists_<Key>(arg0, v1)) {
            let v2 = Key{dummy_field: false};
            0x2::dynamic_field::remove<Key, Proposal>(arg0, v2);
        };
        let v3 = Key{dummy_field: false};
        let v4 = Proposal{
            target     : arg2,
            execute_ms : v0,
        };
        0x2::dynamic_field::add<Key, Proposal>(arg0, v3, v4);
        let v5 = Proposed{
            pool       : 0x2::object::uid_to_inner(arg0),
            target     : arg2,
            execute_ms : v0,
        };
        0x2::event::emit<Proposed>(v5);
    }

    public(friend) fun status(arg0: &0x2::object::UID) : (bool, u64, u64) {
        let v0 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists_<Key>(arg0, v0)) {
            return (false, 0, 0)
        };
        let v1 = Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<Key, Proposal>(arg0, v1);
        (true, v2.target, v2.execute_ms)
    }

    // decompiled from Move bytecode v7
}

