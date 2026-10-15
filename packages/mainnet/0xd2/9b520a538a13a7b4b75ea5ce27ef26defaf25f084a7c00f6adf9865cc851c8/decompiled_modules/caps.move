module 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperRegistry has key {
        id: 0x2::object::UID,
        keepers: 0x2::vec_set::VecSet<address>,
        u64_padding: vector<u64>,
    }

    struct AdminCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct KeeperAdded has copy, drop {
        keeper: address,
    }

    struct KeeperRemoved has copy, drop {
        keeper: address,
    }

    public fun add_keeper(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut KeeperRegistry, arg4: address) {
        assert_admin_cap(arg0, arg1, arg2);
        assert!(!is_keeper(arg3, arg4), 1000);
        0x2::vec_set::insert<address>(&mut arg3.keepers, arg4);
        let v0 = KeeperAdded{keeper: arg4};
        0x2::event::emit<KeeperAdded>(v0);
    }

    public fun assert_admin_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::version_check(arg0);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::assert_not_revoked(arg2, 0x2::object::id<AdminCap>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperRegistry{
            id          : 0x2::object::new(arg0),
            keepers     : 0x2::vec_set::empty<address>(),
            u64_padding : vector[],
        };
        0x2::transfer::share_object<KeeperRegistry>(v0);
    }

    public fun is_keeper(arg0: &KeeperRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun issue_admin_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::version_check(arg0);
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::verify(arg0, arg2);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = AdminCapIssued{
            cap_id    : 0x2::object::id<AdminCap>(&v0),
            recipient : arg1,
        };
        0x2::event::emit<AdminCapIssued>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun remove_keeper(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut KeeperRegistry, arg4: address) {
        assert_admin_cap(arg0, arg1, arg2);
        assert!(is_keeper(arg3, arg4), 1001);
        0x2::vec_set::remove<address>(&mut arg3.keepers, &arg4);
        let v0 = KeeperRemoved{keeper: arg4};
        0x2::event::emit<KeeperRemoved>(v0);
    }

    // decompiled from Move bytecode v7
}

