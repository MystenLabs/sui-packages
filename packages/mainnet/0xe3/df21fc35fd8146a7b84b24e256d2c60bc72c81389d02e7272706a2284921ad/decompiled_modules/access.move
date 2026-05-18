module 0xe3df21fc35fd8146a7b84b24e256d2c60bc72c81389d02e7272706a2284921ad::access {
    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct AdminAdded has copy, drop {
        admin: address,
        added_by: address,
    }

    struct Allowlist has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
    }

    struct AllowlistCreated has copy, drop {
        id: 0x2::object::ID,
        creator: address,
    }

    entry fun add_address(arg0: &mut Allowlist, arg1: address) {
        if (!0x1::vector::contains<address>(&arg0.addresses, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.addresses, arg1);
        };
    }

    entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 0);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v1 = AdminAdded{
                admin    : arg1,
                added_by : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<AdminAdded>(v1);
        };
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Allowlist {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = Allowlist{
            id        : 0x2::object::new(arg0),
            addresses : v1,
        };
        let v3 = AllowlistCreated{
            id      : 0x2::object::id<Allowlist>(&v2),
            creator : v0,
        };
        0x2::event::emit<AllowlistCreated>(v3);
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = &mut v0;
        0x1::vector::push_back<address>(v1, 0x2::tx_context::sender(arg0));
        0x1::vector::push_back<address>(v1, @0xc4d6ee019649edba41d5a5ed1081fe3c86afc41fea413195dd6ecdd0f6090e54);
        let v2 = AdminRegistry{
            id     : 0x2::object::new(arg0),
            admins : v0,
        };
        0x2::transfer::share_object<AdminRegistry>(v2);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    entry fun new_allowlist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0);
        0x2::transfer::transfer<Allowlist>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun remove_address(arg0: &mut Allowlist, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.addresses, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.addresses, v1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Allowlist>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert!(starts_with(&arg0, &v1), 0);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.addresses, &v2), 1);
    }

    fun starts_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg1) > 0x1::vector::length<u8>(arg0)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

