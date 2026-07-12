module 0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        list: vector<address>,
    }

    struct AllowlistCap has store, key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    struct AllowlistCreated has copy, drop {
        allowlist_id: 0x2::object::ID,
        owner: address,
    }

    public fun add(arg0: &mut Allowlist, arg1: &AllowlistCap, arg2: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg3: address) {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg2);
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(!0x1::vector::contains<address>(&arg0.list, &arg3), 2);
        0x1::vector::push_back<address>(&mut arg0.list, arg3);
    }

    public fun cap_allowlist_id(arg0: &AllowlistCap) : 0x2::object::ID {
        arg0.allowlist_id
    }

    public fun create_for_owner(arg0: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::site::DeployerCap, arg1: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg1);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg2);
        let v1 = Allowlist{
            id   : 0x2::object::new(arg3),
            list : v0,
        };
        let v2 = 0x2::object::id<Allowlist>(&v1);
        let v3 = AllowlistCap{
            id           : 0x2::object::new(arg3),
            allowlist_id : v2,
        };
        0x2::transfer::transfer<AllowlistCap>(v3, arg2);
        let v4 = AllowlistCreated{
            allowlist_id : v2,
            owner        : arg2,
        };
        0x2::event::emit<AllowlistCreated>(v4);
        0x2::transfer::share_object<Allowlist>(v1);
        v2
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun members(arg0: &Allowlist) : vector<address> {
        arg0.list
    }

    public fun namespace(arg0: &Allowlist) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun remove(arg0: &mut Allowlist, arg1: &AllowlistCap, arg2: &0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::Version, arg3: address) {
        0xec2dcd65271127019351678ddd05287176a0b9b7fc59ef6ceef34fdbc36e87db::version::assert_version(arg2);
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        let v0 = vector[];
        let v1 = arg0.list;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            if (&v3 != &arg3) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        arg0.list = v0;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        assert!(is_prefix(namespace(arg1), arg0), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.list, &v0), 1);
    }

    // decompiled from Move bytecode v7
}

