module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store {
    struct RoleStore has store {
        roles: 0x2::bag::Bag,
        super_admin_count: u8,
        admin_count: u8,
    }

    struct SuperAdmin has drop, store {
        dummy_field: bool,
    }

    struct Admin has drop, store {
        dummy_field: bool,
    }

    struct RoleProof<phantom T0> has drop {
        owner: address,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct RoleGranted<phantom T0> has copy, drop {
        to: address,
        by: address,
    }

    struct RoleRevoked<phantom T0> has copy, drop {
        from: address,
        by: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RoleStore {
        let v0 = RoleStore{
            roles             : 0x2::bag::new(arg0),
            super_admin_count : 1,
            admin_count       : 0,
        };
        let v1 = &mut v0;
        add_cap<SuperAdmin>(v1, 0x2::tx_context::sender(arg0), new_super_admin());
        let v2 = RoleGranted<SuperAdmin>{
            to : 0x2::tx_context::sender(arg0),
            by : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<RoleGranted<SuperAdmin>>(v2);
        v0
    }

    fun add_cap<T0: drop + store>(arg0: &mut RoleStore, arg1: address, arg2: T0) {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, T0>(&mut arg0.roles, v0, arg2);
    }

    public fun add_capability<T0: drop + store>(arg0: &mut RoleStore, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<SuperAdmin>(arg0, 0x2::tx_context::sender(arg3)), 3);
        assert!(!has_cap<T0>(arg0, arg1), 1);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<SuperAdmin>()) {
            arg0.super_admin_count = arg0.super_admin_count + 1;
        };
        add_cap<T0>(arg0, arg1, arg2);
        let v0 = RoleGranted<T0>{
            to : arg1,
            by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RoleGranted<T0>>(v0);
    }

    public(friend) fun create_role_proof<T0: store>(arg0: &RoleStore, arg1: &mut 0x2::tx_context::TxContext) : RoleProof<T0> {
        assert!(has_cap<T0>(arg0, 0x2::tx_context::sender(arg1)), 0);
        RoleProof<T0>{owner: 0x2::tx_context::sender(arg1)}
    }

    public fun has_cap<T0: store>(arg0: &RoleStore, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    public fun list_roles(arg0: &RoleStore, arg1: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        if (has_cap<Admin>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Admin"));
        };
        if (has_cap<SuperAdmin>(arg0, arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"SuperAdmin"));
        };
        v0
    }

    public fun new_admin() : Admin {
        Admin{dummy_field: false}
    }

    public fun new_super_admin() : SuperAdmin {
        SuperAdmin{dummy_field: false}
    }

    public fun owner<T0: store>(arg0: &RoleProof<T0>) : address {
        arg0.owner
    }

    fun remove_cap<T0: drop + store>(arg0: &mut RoleStore, arg1: address) : T0 {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v0)
    }

    public fun remove_capability<T0: drop + store>(arg0: &mut RoleStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_cap<SuperAdmin>(arg0, 0x2::tx_context::sender(arg2)), 3);
        assert!(has_cap<T0>(arg0, arg1), 0);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<SuperAdmin>()) {
            assert!(arg0.super_admin_count > 1, 2);
            arg0.super_admin_count = arg0.super_admin_count - 1;
        };
        remove_cap<T0>(arg0, arg1);
        let v0 = RoleRevoked<T0>{
            from : arg1,
            by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RoleRevoked<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

