module 0x9dbfbedc73e2dfaf95e965d23e5ce08c816c3a049f9de0d0d68621f04fe9c7f6::allowlist {
    struct Allowlist has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        list: vector<address>,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        allowlist_id: address,
    }

    struct AdminSet has key {
        id: 0x2::object::UID,
        allowlist_id: address,
        admins: vector<address>,
    }

    public fun remove(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::uid_to_address(&arg0.id), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.list, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.list, v1);
        };
    }

    public fun add(arg0: &mut Allowlist, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == 0x2::object::uid_to_address(&arg0.id), 0);
        if (!0x1::vector::contains<address>(&arg0.list, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.list, arg2);
        };
    }

    public fun add_member_by_admin(arg0: &mut Allowlist, arg1: &AdminSet, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::uid_to_address(&arg0.id), 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg1.admins, &v0), 0);
        if (!0x1::vector::contains<address>(&arg0.list, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.list, arg2);
        };
    }

    public fun admin_set_allowlist_id(arg0: &AdminSet) : address {
        arg0.allowlist_id
    }

    public fun admins(arg0: &AdminSet) : &vector<address> {
        &arg0.admins
    }

    public fun allowlist_id_of_cap(arg0: &Cap) : address {
        arg0.allowlist_id
    }

    public fun create_admin_set(arg0: &Allowlist, arg1: &Cap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        assert!(arg1.allowlist_id == v0, 0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg2));
        let v2 = AdminSet{
            id           : 0x2::object::new(arg2),
            allowlist_id : v0,
            admins       : v1,
        };
        0x2::transfer::share_object<AdminSet>(v2);
    }

    public fun create_allowlist_entry(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Allowlist{
            id   : v0,
            name : arg0,
            list : vector[],
        };
        let v2 = Cap{
            id           : 0x2::object::new(arg1),
            allowlist_id : 0x2::object::uid_to_address(&v0),
        };
        0x2::transfer::share_object<Allowlist>(v1);
        0x2::transfer::transfer<Cap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun grant_admin(arg0: &mut AdminSet, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == arg0.allowlist_id, 0);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg2);
        };
    }

    public fun members(arg0: &Allowlist) : &vector<address> {
        &arg0.list
    }

    public fun remove_member_by_admin(arg0: &mut Allowlist, arg1: &AdminSet, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.allowlist_id == 0x2::object::uid_to_address(&arg0.id), 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg1.admins, &v0), 0);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.list, &arg2);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.list, v2);
        };
    }

    public fun revoke_admin(arg0: &mut AdminSet, arg1: &Cap, arg2: address) {
        assert!(arg1.allowlist_id == arg0.allowlist_id, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        };
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg1.list, &v0), 1);
    }

    // decompiled from Move bytecode v7
}

