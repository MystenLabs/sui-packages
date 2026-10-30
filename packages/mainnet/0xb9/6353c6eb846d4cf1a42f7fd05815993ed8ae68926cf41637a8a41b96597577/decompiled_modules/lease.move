module 0xb96353c6eb846d4cf1a42f7fd05815993ed8ae68926cf41637a8a41b96597577::lease {
    struct RunnerLease has key {
        id: 0x2::object::UID,
        holder: address,
        holder_cap: 0x1::option::Option<0x2::object::ID>,
        token: u64,
        expires_ms: u64,
        released: bool,
        reserved_until_ms: u64,
        runner_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RunnerCap has key {
        id: 0x2::object::UID,
        lease_id: 0x2::object::ID,
    }

    struct Acquired has copy, drop {
        holder: address,
        cap: 0x2::object::ID,
        token: u64,
        expires_ms: u64,
    }

    struct Revoked has copy, drop {
        token: u64,
        reserved_until_ms: u64,
    }

    public fun acquire(arg0: &mut RunnerLease, arg1: &RunnerCap, arg2: &0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert_runner(arg0, arg1);
        0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::assert_live(arg2);
        assert!(is_free(arg0, arg3), 1);
        arg0.token = arg0.token + 1;
        arg0.holder = 0x2::tx_context::sender(arg4);
        arg0.holder_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<RunnerCap>(arg1));
        arg0.expires_ms = 0x2::clock::timestamp_ms(arg3) + 180000;
        arg0.released = false;
        let v0 = Acquired{
            holder     : arg0.holder,
            cap        : 0x2::object::id<RunnerCap>(arg1),
            token      : arg0.token,
            expires_ms : arg0.expires_ms,
        };
        0x2::event::emit<Acquired>(v0);
        arg0.token
    }

    public fun admin_revoke(arg0: &AdminCap, arg1: &mut RunnerLease, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) + 30000;
        let v1 = if (arg1.expires_ms > v0) {
            arg1.expires_ms
        } else {
            v0
        };
        if (v1 > arg1.reserved_until_ms) {
            arg1.reserved_until_ms = v1;
        };
        arg1.token = arg1.token + 1;
        arg1.holder = @0x0;
        arg1.holder_cap = 0x1::option::none<0x2::object::ID>();
        arg1.expires_ms = 0;
        arg1.released = true;
        let v2 = Revoked{
            token             : arg1.token,
            reserved_until_ms : arg1.reserved_until_ms,
        };
        0x2::event::emit<Revoked>(v2);
    }

    fun assert_runner(arg0: &RunnerLease, arg1: &RunnerCap) {
        let v0 = if (arg1.lease_id == 0x2::object::id<RunnerLease>(arg0)) {
            let v1 = 0x2::object::id<RunnerCap>(arg1);
            0x2::vec_set::contains<0x2::object::ID>(&arg0.runner_caps, &v1)
        } else {
            false
        };
        assert!(v0, 5);
    }

    public fun assert_valid(arg0: &RunnerLease, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(!arg0.released && arg1 == arg0.token, 3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_ms, 4);
    }

    public fun expires_ms(arg0: &RunnerLease) : u64 {
        arg0.expires_ms
    }

    public fun grace_ms() : u64 {
        30000
    }

    public fun holder(arg0: &RunnerLease) : address {
        arg0.holder
    }

    public fun holder_cap(arg0: &RunnerLease) : 0x1::option::Option<0x2::object::ID> {
        arg0.holder_cap
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RunnerLease{
            id                : 0x2::object::new(arg0),
            holder            : @0x0,
            holder_cap        : 0x1::option::none<0x2::object::ID>(),
            token             : 0,
            expires_ms        : 0,
            released          : true,
            reserved_until_ms : 0,
            runner_caps       : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RunnerLease>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_free(arg0: &RunnerLease, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.reserved_until_ms && (arg0.released || v0 >= arg0.expires_ms + 30000)
    }

    public fun is_runner_cap(arg0: &RunnerLease, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.runner_caps, &arg1)
    }

    public fun is_valid(arg0: &RunnerLease, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.released) {
            if (arg1 == arg0.token) {
                0x2::clock::timestamp_ms(arg2) < arg0.expires_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun issue_runner_cap(arg0: &AdminCap, arg1: &mut RunnerLease, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RunnerCap{
            id       : 0x2::object::new(arg3),
            lease_id : 0x2::object::id<RunnerLease>(arg1),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.runner_caps, 0x2::object::id<RunnerCap>(&v0));
        0x2::transfer::transfer<RunnerCap>(v0, arg2);
    }

    public fun release(arg0: &mut RunnerLease, arg1: &RunnerCap, arg2: u64) {
        assert_runner(arg0, arg1);
        assert!(!arg0.released && arg0.holder_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<RunnerCap>(arg1)), 2);
        assert!(arg2 == arg0.token, 3);
        arg0.released = true;
        arg0.holder = @0x0;
        arg0.holder_cap = 0x1::option::none<0x2::object::ID>();
        arg0.expires_ms = 0;
    }

    public fun renew(arg0: &mut RunnerLease, arg1: &RunnerCap, arg2: &0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::HaltFlag, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_runner(arg0, arg1);
        0xe94269354ceb0d88dc01e0705865f7ec0b6593c46877c5200d7c452f1bbfa10c::halt::assert_live(arg2);
        assert!(!arg0.released && arg0.holder_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<RunnerCap>(arg1)), 2);
        assert!(arg3 == arg0.token, 3);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_ms, 4);
        arg0.expires_ms = 0x2::clock::timestamp_ms(arg4) + 180000;
    }

    public fun reserved_until_ms(arg0: &RunnerLease) : u64 {
        arg0.reserved_until_ms
    }

    public fun revoke_runner_cap(arg0: &AdminCap, arg1: &mut RunnerLease, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.runner_caps, &arg2), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.runner_caps, &arg2);
        if (arg1.holder_cap == 0x1::option::some<0x2::object::ID>(arg2)) {
            admin_revoke(arg0, arg1, arg3);
        };
    }

    public fun token(arg0: &RunnerLease) : u64 {
        arg0.token
    }

    public fun ttl_ms() : u64 {
        180000
    }

    // decompiled from Move bytecode v7
}

