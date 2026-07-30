module 0x7499f97221cc2e65d12e8c76b938341b1ca41780a1c9d321b246662951fcf6bc::policy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        revoked: 0x2::vec_set::VecSet<0x2::object::ID>,
        owners: 0x2::table::Table<0x2::object::ID, address>,
        feed_ids: 0x2::table::Table<0x1::type_name::TypeName, vector<u8>>,
        admins: 0x2::vec_set::VecSet<address>,
    }

    public fun add_admin(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
        };
    }

    public(friend) fun assert_not_revoked(arg0: &PolicyRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked, &arg1), 4);
    }

    public(friend) fun expected_feed_id(arg0: &PolicyRegistry, arg1: 0x1::type_name::TypeName) : vector<u8> {
        assert!(0x2::table::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.feed_ids, arg1), 2);
        *0x2::table::borrow<0x1::type_name::TypeName, vector<u8>>(&arg0.feed_ids, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = PolicyRegistry{
            id       : 0x2::object::new(arg0),
            version  : 0x7499f97221cc2e65d12e8c76b938341b1ca41780a1c9d321b246662951fcf6bc::version::current(),
            revoked  : 0x2::vec_set::empty<0x2::object::ID>(),
            owners   : 0x2::table::new<0x2::object::ID, address>(arg0),
            feed_ids : 0x2::table::new<0x1::type_name::TypeName, vector<u8>>(arg0),
            admins   : v1,
        };
        0x2::transfer::share_object<PolicyRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
    }

    public(friend) fun is_admin(arg0: &PolicyRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public(friend) fun mark_revoked(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked, arg1);
        };
    }

    public fun migrate_registry(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: u64) {
        arg0.version = arg2;
    }

    public(friend) fun owner_of(arg0: &PolicyRegistry, arg1: 0x2::object::ID) : address {
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.owners, arg1), 3);
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.owners, arg1)
    }

    public(friend) fun record_owner(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID, arg2: address) {
        0x2::table::add<0x2::object::ID, address>(&mut arg0.owners, arg1, arg2);
    }

    public fun register_feed_id<T0>(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: vector<u8>) {
        0x7499f97221cc2e65d12e8c76b938341b1ca41780a1c9d321b246662951fcf6bc::version::assert_is_current(arg0.version);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.feed_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, vector<u8>>(&mut arg0.feed_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<u8>>(&mut arg0.feed_ids, v0, arg2);
    }

    public fun remove_admin(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        };
    }

    public(friend) fun version_of(arg0: &PolicyRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

