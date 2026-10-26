module 0x7b619b222b80edb40cb10d2dd36538ee7762dde3dd30245bed25804bbd2dcf53::access {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        members: vector<address>,
    }

    struct MemberAdded has copy, drop {
        registry_id: 0x2::object::ID,
        member: address,
        version: u64,
    }

    struct MemberRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        member: address,
        version: u64,
    }

    public fun add(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        assert!(!contains(arg1, arg2), 0);
        0x1::vector::push_back<address>(&mut arg1.members, arg2);
        arg1.version = arg1.version + 1;
        let v0 = MemberAdded{
            registry_id : 0x2::object::id<Registry>(arg1),
            member      : arg2,
            version     : arg1.version,
        };
        0x2::event::emit<MemberAdded>(v0);
    }

    public fun contains(arg0: &Registry, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.members)) {
            if (*0x1::vector::borrow<address>(&arg0.members, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            members : v1,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v2);
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public fun remove(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg1.members)) {
            if (*0x1::vector::borrow<address>(&arg1.members, v0) == arg2) {
                0x1::vector::swap_remove<address>(&mut arg1.members, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 1);
        arg1.version = arg1.version + 1;
        let v2 = MemberRemoved{
            registry_id : 0x2::object::id<Registry>(arg1),
            member      : arg2,
            version     : arg1.version,
        };
        0x2::event::emit<MemberRemoved>(v2);
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

