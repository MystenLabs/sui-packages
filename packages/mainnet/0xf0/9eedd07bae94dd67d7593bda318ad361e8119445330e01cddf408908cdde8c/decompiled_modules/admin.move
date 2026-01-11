module 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AclControl has store, key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<vector<u8>, vector<address>>,
    }

    public fun add_address_to_role(arg0: &AdminCap, arg1: &mut AclControl, arg2: vector<u8>, arg3: address) {
        assert!(0x2::table::contains<vector<u8>, vector<address>>(&arg1.roles, arg2), 1002);
        let v0 = 0x2::table::borrow_mut<vector<u8>, vector<address>>(&mut arg1.roles, arg2);
        assert!(!0x1::vector::contains<address>(v0, &arg3), 1003);
        0x1::vector::push_back<address>(v0, arg3);
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut AclControl, arg2: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, vector<address>>(&arg1.roles, arg2), 1001);
        0x2::table::add<vector<u8>, vector<address>>(&mut arg1.roles, arg2, 0x1::vector::empty<address>());
    }

    public fun has_role(arg0: &AclControl, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<vector<u8>, vector<address>>(&arg0.roles, arg1)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<vector<u8>, vector<address>>(&arg0.roles, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AclControl{
            id    : 0x2::object::new(arg0),
            roles : 0x2::table::new<vector<u8>, vector<address>>(arg0),
        };
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::initialize(0x2::object::uid_to_inner(&v0.id), 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<AclControl>(v1);
    }

    public fun remove_address_from_role(arg0: &AdminCap, arg1: &mut AclControl, arg2: vector<u8>, arg3: address) {
        assert!(0x2::table::contains<vector<u8>, vector<address>>(&arg1.roles, arg2), 1002);
        let v0 = 0x2::table::borrow_mut<vector<u8>, vector<address>>(&mut arg1.roles, arg2);
        let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg3);
        assert!(v1, 1004);
        0x1::vector::remove<address>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

