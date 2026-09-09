module 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct Cap has key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    struct AllowlistCreated has copy, drop {
        allowlist: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct AllowlistDeleted has copy, drop {
        allowlist: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct MemberAdded has copy, drop {
        allowlist: 0x2::object::ID,
        member: address,
    }

    struct MemberRemoved has copy, drop {
        allowlist: 0x2::object::ID,
        member: address,
    }

    struct CapTransferred has copy, drop {
        allowlist: 0x2::object::ID,
        recipient: address,
    }

    public fun add_member(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.members, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.members, arg2);
        let v0 = MemberAdded{
            allowlist : 0x2::object::id<Allowlist>(arg0),
            member    : arg2,
        };
        0x2::event::emit<MemberAdded>(v0);
    }

    fun assert_valid_allowlist_seal_id(arg0: &Allowlist, arg1: &vector<u8>) {
        let v0 = 0x2::object::id<Allowlist>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(arg1) > v2 + 1, 3);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&v1, v3) == *0x1::vector::borrow<u8>(arg1, v3), 3);
            v3 = v3 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(arg1, v2) == 2, 4);
    }

    public fun cap_allowlist_id(arg0: &Cap) : 0x2::object::ID {
        arg0.allowlist_id
    }

    public fun delete_allowlist(arg0: Allowlist, arg1: Cap) {
        let v0 = 0x2::object::id<Allowlist>(&arg0);
        assert!(arg1.allowlist_id == v0, 0);
        let Cap {
            id           : v1,
            allowlist_id : _,
        } = arg1;
        0x2::object::delete(v1);
        let Allowlist {
            id      : v3,
            name    : v4,
            members : _,
        } = arg0;
        0x2::object::delete(v3);
        let v6 = AllowlistDeleted{
            allowlist : v0,
            name      : v4,
        };
        0x2::event::emit<AllowlistDeleted>(v6);
    }

    public fun is_member(arg0: &Allowlist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun member_count(arg0: &Allowlist) : u64 {
        0x2::vec_set::length<address>(&arg0.members)
    }

    public fun name(arg0: &Allowlist) : 0x1::string::String {
        arg0.name
    }

    public fun new_allowlist(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (Allowlist, Cap) {
        let v0 = Allowlist{
            id      : 0x2::object::new(arg1),
            name    : arg0,
            members : 0x2::vec_set::empty<address>(),
        };
        let v1 = 0x2::object::id<Allowlist>(&v0);
        let v2 = Cap{
            id           : 0x2::object::new(arg1),
            allowlist_id : v1,
        };
        let v3 = AllowlistCreated{
            allowlist : v1,
            name      : v0.name,
        };
        0x2::event::emit<AllowlistCreated>(v3);
        (v0, v2)
    }

    public fun remove_member(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::id<Allowlist>(arg0), 0);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg2);
        let v0 = MemberRemoved{
            allowlist : 0x2::object::id<Allowlist>(arg0),
            member    : arg2,
        };
        0x2::event::emit<MemberRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        assert_valid_allowlist_seal_id(arg1, &arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 5);
    }

    public fun share_allowlist(arg0: Allowlist) {
        0x2::transfer::share_object<Allowlist>(arg0);
    }

    public fun transfer_cap(arg0: Cap, arg1: address) {
        0x2::transfer::transfer<Cap>(arg0, arg1);
        let v0 = CapTransferred{
            allowlist : arg0.allowlist_id,
            recipient : arg1,
        };
        0x2::event::emit<CapTransferred>(v0);
    }

    // decompiled from Move bytecode v7
}

