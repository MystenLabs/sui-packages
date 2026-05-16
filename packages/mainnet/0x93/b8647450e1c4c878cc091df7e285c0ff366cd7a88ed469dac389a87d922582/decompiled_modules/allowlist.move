module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::allowlist {
    struct Allowlist has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        creator: address,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct AllowlistAdminCap has store, key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    struct AllowlistCreated has copy, drop {
        allowlist_id: 0x2::object::ID,
        creator: address,
    }

    struct AllowlistMemberAdded has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
    }

    struct AllowlistMemberRemoved has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
    }

    public fun add_member(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.members, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.members, arg2);
        let v0 = AllowlistMemberAdded{
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
            member       : arg2,
        };
        0x2::event::emit<AllowlistMemberAdded>(v0);
    }

    public fun cap_allowlist_id(arg0: &AllowlistAdminCap) : 0x2::object::ID {
        arg0.allowlist_id
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (Allowlist, AllowlistAdminCap) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg1));
        let v1 = Allowlist{
            id      : 0x2::object::new(arg1),
            name    : arg0,
            creator : 0x2::tx_context::sender(arg1),
            members : v0,
        };
        let v2 = AllowlistAdminCap{
            id           : 0x2::object::new(arg1),
            allowlist_id : 0x2::object::id<Allowlist>(&v1),
        };
        let v3 = AllowlistCreated{
            allowlist_id : 0x2::object::id<Allowlist>(&v1),
            creator      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AllowlistCreated>(v3);
        (v1, v2)
    }

    public fun create_and_share(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0, arg1);
        0x2::transfer::share_object<Allowlist>(v0);
        0x2::transfer::public_transfer<AllowlistAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun creator(arg0: &Allowlist) : address {
        arg0.creator
    }

    public fun delegate_admin(arg0: &Allowlist, arg1: &AllowlistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        let v0 = AllowlistAdminCap{
            id           : 0x2::object::new(arg3),
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
        };
        0x2::transfer::public_transfer<AllowlistAdminCap>(v0, arg2);
    }

    public fun is_member(arg0: &Allowlist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun member_count(arg0: &Allowlist) : u64 {
        0x2::vec_set::size<address>(&arg0.members)
    }

    public fun remove_member(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg2);
        let v0 = AllowlistMemberRemoved{
            allowlist_id : 0x2::object::id<Allowlist>(arg0),
            member       : arg2,
        };
        0x2::event::emit<AllowlistMemberRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 3);
    }

    // decompiled from Move bytecode v6
}

