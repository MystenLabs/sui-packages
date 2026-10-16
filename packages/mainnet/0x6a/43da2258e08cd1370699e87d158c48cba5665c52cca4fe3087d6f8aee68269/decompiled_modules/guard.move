module 0x6a43da2258e08cd1370699e87d158c48cba5665c52cca4fe3087d6f8aee68269::guard {
    struct Guard has key {
        id: 0x2::object::UID,
        admin_cap: 0x1::option::Option<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>,
        admin_cap_id: 0x2::object::ID,
        pauser: 0x2::object::ID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        guard: 0x2::object::ID,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
        guard: 0x2::object::ID,
    }

    struct Borrow {
        guard: 0x2::object::ID,
    }

    struct GuardCreated has copy, drop {
        guard: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        owner_cap: 0x2::object::ID,
        pauser_cap: 0x2::object::ID,
    }

    struct PausedByPauser has copy, drop {
        guard: 0x2::object::ID,
        pauser_cap: 0x2::object::ID,
        sender: address,
    }

    struct UnpausedByOwner has copy, drop {
        guard: 0x2::object::ID,
        sender: address,
    }

    struct AdminCapBorrowed has copy, drop {
        guard: 0x2::object::ID,
        sender: address,
    }

    struct AdminCapReturned has copy, drop {
        guard: 0x2::object::ID,
        sender: address,
    }

    struct PauserReplaced has copy, drop {
        guard: 0x2::object::ID,
        old_pauser_cap: 0x2::object::ID,
        new_pauser_cap: 0x2::object::ID,
        sender: address,
    }

    struct AdminCapReleased has copy, drop {
        guard: 0x2::object::ID,
        sender: address,
    }

    public fun pause<T0>(arg0: &Guard, arg1: &PauserCap, arg2: &mut 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::State<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.guard == 0x2::object::id<Guard>(arg0), 0);
        assert!(0x2::object::id<PauserCap>(arg1) == arg0.pauser, 1);
        assert!(0x1::option::is_some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), 4);
        0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::pause<T0>(0x1::option::borrow<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), arg2);
        let v0 = PausedByPauser{
            guard      : 0x2::object::id<Guard>(arg0),
            pauser_cap : 0x2::object::id<PauserCap>(arg1),
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PausedByPauser>(v0);
    }

    public fun unpause<T0>(arg0: &Guard, arg1: &OwnerCap, arg2: &mut 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::State<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.guard == 0x2::object::id<Guard>(arg0), 0);
        assert!(0x1::option::is_some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), 4);
        0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::unpause<T0>(0x1::option::borrow<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), arg2);
        let v0 = UnpausedByOwner{
            guard  : 0x2::object::id<Guard>(arg0),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UnpausedByOwner>(v0);
    }

    public fun admin_cap_id(arg0: &Guard) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun borrow_admin_cap(arg0: &mut Guard, arg1: &OwnerCap, arg2: &0x2::tx_context::TxContext) : (0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap, Borrow) {
        assert!(arg1.guard == 0x2::object::id<Guard>(arg0), 0);
        assert!(0x1::option::is_some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), 4);
        let v0 = AdminCapBorrowed{
            guard  : 0x2::object::id<Guard>(arg0),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminCapBorrowed>(v0);
        let v1 = Borrow{guard: 0x2::object::id<Guard>(arg0)};
        (0x1::option::extract<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&mut arg0.admin_cap), v1)
    }

    public fun create(arg0: 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (OwnerCap, PauserCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = OwnerCap{
            id    : 0x2::object::new(arg1),
            guard : v1,
        };
        let v3 = PauserCap{
            id    : 0x2::object::new(arg1),
            guard : v1,
        };
        let v4 = 0x2::object::id<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0);
        let v5 = GuardCreated{
            guard      : v1,
            admin_cap  : v4,
            owner_cap  : 0x2::object::id<OwnerCap>(&v2),
            pauser_cap : 0x2::object::id<PauserCap>(&v3),
        };
        0x2::event::emit<GuardCreated>(v5);
        let v6 = Guard{
            id           : v0,
            admin_cap    : 0x1::option::some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(arg0),
            admin_cap_id : v4,
            pauser       : 0x2::object::id<PauserCap>(&v3),
        };
        0x2::transfer::share_object<Guard>(v6);
        (v2, v3)
    }

    public fun current_pauser(arg0: &Guard) : 0x2::object::ID {
        arg0.pauser
    }

    public fun holds_admin_cap(arg0: &Guard) : bool {
        0x1::option::is_some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap)
    }

    public fun owner_cap_guard(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.guard
    }

    public fun pauser_cap_guard(arg0: &PauserCap) : 0x2::object::ID {
        arg0.guard
    }

    public fun put_back(arg0: &mut Guard, arg1: 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap, arg2: Borrow, arg3: &0x2::tx_context::TxContext) {
        let Borrow { guard: v0 } = arg2;
        assert!(v0 == 0x2::object::id<Guard>(arg0), 2);
        assert!(0x2::object::id<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg1) == arg0.admin_cap_id, 3);
        0x1::option::fill<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&mut arg0.admin_cap, arg1);
        let v1 = AdminCapReturned{
            guard  : 0x2::object::id<Guard>(arg0),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdminCapReturned>(v1);
    }

    public fun release(arg0: &mut Guard, arg1: &OwnerCap, arg2: &0x2::tx_context::TxContext) : 0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap {
        assert!(arg1.guard == 0x2::object::id<Guard>(arg0), 0);
        assert!(0x1::option::is_some<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&arg0.admin_cap), 4);
        let v0 = AdminCapReleased{
            guard  : 0x2::object::id<Guard>(arg0),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminCapReleased>(v0);
        0x1::option::extract<0x374f4acc8f7c38959eb7b3aac02573503160746a941719e342dbc0df28bdcd88::state::AdminCap>(&mut arg0.admin_cap)
    }

    public fun replace_pauser(arg0: &mut Guard, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : PauserCap {
        assert!(arg1.guard == 0x2::object::id<Guard>(arg0), 0);
        let v0 = PauserCap{
            id    : 0x2::object::new(arg2),
            guard : 0x2::object::id<Guard>(arg0),
        };
        let v1 = PauserReplaced{
            guard          : 0x2::object::id<Guard>(arg0),
            old_pauser_cap : arg0.pauser,
            new_pauser_cap : 0x2::object::id<PauserCap>(&v0),
            sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PauserReplaced>(v1);
        arg0.pauser = 0x2::object::id<PauserCap>(&v0);
        v0
    }

    // decompiled from Move bytecode v7
}

