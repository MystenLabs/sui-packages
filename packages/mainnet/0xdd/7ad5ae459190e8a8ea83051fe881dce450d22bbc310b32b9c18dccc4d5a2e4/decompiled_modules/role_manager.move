module 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::role_manager {
    struct MasterRole has key {
        id: 0x2::object::UID,
    }

    struct RoleManager has key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<0x1::string::String, vector<address>>,
    }

    public fun check_role(arg0: &RoleManager, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        if (!has_role(arg0, arg1, 0x2::tx_context::sender(arg2))) {
            abort 101
        };
    }

    public fun get_roles(arg0: &RoleManager, arg1: 0x1::string::String) : vector<address> {
        if (0x2::table::contains<0x1::string::String, vector<address>>(&arg0.roles, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<address>>(&arg0.roles, arg1)
        } else {
            0x1::vector::empty<address>()
        }
    }

    entry fun grant_role(arg0: &MasterRole, arg1: &mut RoleManager, arg2: 0x1::string::String, arg3: address) {
        internal_grant_role(arg1, arg2, arg3);
    }

    public fun has_role(arg0: &RoleManager, arg1: 0x1::string::String, arg2: address) : bool {
        0x2::table::contains<0x1::string::String, vector<address>>(&arg0.roles, arg1) && 0x1::vector::contains<address>(0x2::table::borrow<0x1::string::String, vector<address>>(&arg0.roles, arg1), &arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterRole{id: 0x2::object::new(arg0)};
        let v1 = RoleManager{
            id    : 0x2::object::new(arg0),
            roles : 0x2::table::new<0x1::string::String, vector<address>>(arg0),
        };
        0x2::transfer::transfer<MasterRole>(v0, 0x2::tx_context::sender(arg0));
        let v2 = &mut v1;
        internal_grant_role(v2, 0x1::string::utf8(b"ug_sale_station_admin"), 0x2::tx_context::sender(arg0));
        let v3 = &mut v1;
        internal_grant_role(v3, 0x1::string::utf8(b"ug_sale_station_admin"), @0x3b0601b8a1e62e43860cc93d1fc51d2d0b44c67a0db2d4d375dddc01e6b79d36);
        let v4 = &mut v1;
        internal_grant_role(v4, 0x1::string::utf8(b"ug_nft_admin"), 0x2::tx_context::sender(arg0));
        let v5 = &mut v1;
        internal_grant_role(v5, 0x1::string::utf8(b"sox_exchanger_admin"), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<RoleManager>(v1);
    }

    fun internal_grant_role(arg0: &mut RoleManager, arg1: 0x1::string::String, arg2: address) {
        if (0x2::table::contains<0x1::string::String, vector<address>>(&arg0.roles, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<address>>(&mut arg0.roles, arg1);
            assert!(!0x1::vector::contains<address>(v0, &arg2), 100);
            0x1::vector::push_back<address>(v0, arg2);
        } else {
            let v1 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v1, arg2);
            0x2::table::add<0x1::string::String, vector<address>>(&mut arg0.roles, arg1, v1);
        };
    }

    entry fun revoke_role(arg0: &MasterRole, arg1: &mut RoleManager, arg2: 0x1::string::String, arg3: address) {
        assert!(0x2::table::contains<0x1::string::String, vector<address>>(&arg1.roles, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<address>>(&mut arg1.roles, arg2);
        let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg3);
        assert!(v1, 101);
        0x1::vector::remove<address>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

