module 0xaf2992555307c6c35bc2f8bf9912d2f8237fcce7d393304b74b6faf4ce12af12::access_control {
    struct Registry has key {
        id: 0x2::object::UID,
        owner_count: u64,
        admin_count: u64,
        reviewer_count: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct ReviewerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 1);
        arg1.admin_count = arg1.admin_count + 1;
        let v0 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : 0x2::object::id<Registry>(arg1),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
    }

    public fun admin_registry_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.registry_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            owner_count    : 1,
            admin_count    : 0,
            reviewer_count : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = OwnerCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<Registry>(&v0),
        };
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun issue_admin_cap(arg0: &OwnerCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 1);
        arg1.admin_count = arg1.admin_count + 1;
        let v0 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : 0x2::object::id<Registry>(arg1),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
    }

    public fun issue_admin_cap_to_sender(arg0: &OwnerCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        issue_admin_cap(arg0, arg1, v0, arg2);
    }

    public fun issue_reviewer_cap(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 2);
        arg1.reviewer_count = arg1.reviewer_count + 1;
        let v0 = ReviewerCap{
            id          : 0x2::object::new(arg3),
            registry_id : 0x2::object::id<Registry>(arg1),
        };
        0x2::transfer::public_transfer<ReviewerCap>(v0, arg2);
    }

    public fun issue_reviewer_cap_to_sender(arg0: &AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        issue_reviewer_cap(arg0, arg1, v0, arg2);
    }

    public fun owner_registry_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun reviewer_registry_id(arg0: &ReviewerCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun stats(arg0: &Registry) : (u64, u64, u64) {
        (arg0.owner_count, arg0.admin_count, arg0.reviewer_count)
    }

    // decompiled from Move bytecode v7
}

