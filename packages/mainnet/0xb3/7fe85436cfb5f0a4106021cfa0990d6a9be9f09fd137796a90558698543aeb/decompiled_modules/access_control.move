module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::access_control {
    struct AccessControl<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        roles: 0x2::vec_map::VecMap<vector<u8>, 0x2::vec_set::VecSet<address>>,
    }

    struct Admin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        access_control: address,
    }

    public fun destroy_empty<T0: drop>(arg0: AccessControl<T0>) {
        let AccessControl {
            id    : v0,
            roles : v1,
        } = arg0;
        0x2::vec_map::destroy_empty<vector<u8>, 0x2::vec_set::VecSet<address>>(v1);
        0x2::object::delete(v0);
    }

    public fun new<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (AccessControl<T0>, Admin<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 3);
        let v0 = AccessControl<T0>{
            id    : 0x2::object::new(arg1),
            roles : 0x2::vec_map::empty<vector<u8>, 0x2::vec_set::VecSet<address>>(),
        };
        let v1 = Admin<T0>{
            id             : 0x2::object::new(arg1),
            access_control : 0x2::object::uid_to_address(&v0.id),
        };
        let v2 = &mut v0;
        new_role_singleton_impl<T0>(v2, b"SUPER_ADMIN_ROLE", 0x2::object::uid_to_address(&v1.id));
        (v0, v1)
    }

    public fun contains<T0: drop>(arg0: &AccessControl<T0>, arg1: vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.roles, &arg1)
    }

    public fun remove<T0: drop>(arg0: &Admin<T0>, arg1: &mut AccessControl<T0>, arg2: vector<u8>) {
        assert_super_admin<T0>(arg0, arg1);
        if (contains<T0>(arg1, arg2)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2);
        };
    }

    public fun access_control<T0: drop>(arg0: &Admin<T0>) : address {
        arg0.access_control
    }

    public fun add<T0: drop>(arg0: &Admin<T0>, arg1: &mut AccessControl<T0>, arg2: vector<u8>) {
        assert_super_admin<T0>(arg0, arg1);
        if (!contains<T0>(arg1, arg2)) {
            new_role_impl<T0>(arg1, arg2);
        };
    }

    fun assert_super_admin<T0: drop>(arg0: &Admin<T0>, arg1: &AccessControl<T0>) {
        assert!(has_role<T0>(arg0, arg1, b"SUPER_ADMIN_ROLE"), 1);
    }

    public fun destroy<T0: drop>(arg0: &Admin<T0>, arg1: AccessControl<T0>) {
        assert_super_admin<T0>(arg0, &arg1);
        let AccessControl {
            id    : v0,
            roles : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun destroy_account<T0: drop>(arg0: Admin<T0>) {
        let Admin {
            id             : v0,
            access_control : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun grant<T0: drop>(arg0: &Admin<T0>, arg1: &mut AccessControl<T0>, arg2: vector<u8>, arg3: address) {
        assert_super_admin<T0>(arg0, arg1);
        if (contains<T0>(arg1, arg2)) {
            0x2::vec_set::insert<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), arg3);
        } else {
            new_role_singleton_impl<T0>(arg1, arg2, arg3);
        };
    }

    public fun has_role<T0: drop>(arg0: &Admin<T0>, arg1: &AccessControl<T0>, arg2: vector<u8>) : bool {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.access_control, 0);
        has_role_<T0>(0x2::object::uid_to_address(&arg0.id), arg1, arg2)
    }

    public fun has_role_<T0: drop>(arg0: address, arg1: &AccessControl<T0>, arg2: vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.roles, &arg2) && 0x2::vec_set::contains<address>(0x2::vec_map::get<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.roles, &arg2), &arg0)
    }

    public fun new_admin<T0: drop>(arg0: &Admin<T0>, arg1: &AccessControl<T0>, arg2: &mut 0x2::tx_context::TxContext) : Admin<T0> {
        assert_super_admin<T0>(arg0, arg1);
        Admin<T0>{
            id             : 0x2::object::new(arg2),
            access_control : 0x2::object::uid_to_address(&arg1.id),
        }
    }

    fun new_role_impl<T0: drop>(arg0: &mut AccessControl<T0>, arg1: vector<u8>) {
        0x2::vec_map::insert<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg1, 0x2::vec_set::empty<address>());
    }

    fun new_role_singleton_impl<T0: drop>(arg0: &mut AccessControl<T0>, arg1: vector<u8>, arg2: address) {
        0x2::vec_map::insert<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg1, 0x2::vec_set::singleton<address>(arg2));
    }

    public fun renounce<T0: drop>(arg0: &Admin<T0>, arg1: &mut AccessControl<T0>, arg2: vector<u8>) {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.access_control, 0);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        if (has_role_<T0>(v0, arg1, arg2)) {
            0x2::vec_set::remove<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), &v0);
        };
    }

    public fun revoke<T0: drop>(arg0: &Admin<T0>, arg1: &mut AccessControl<T0>, arg2: vector<u8>, arg3: address) {
        assert_super_admin<T0>(arg0, arg1);
        assert!(contains<T0>(arg1, arg2), 2);
        if (has_role_<T0>(arg3, arg1, arg2)) {
            0x2::vec_set::remove<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), &arg3);
        };
    }

    public fun super_admin_role() : vector<u8> {
        b"SUPER_ADMIN_ROLE"
    }

    // decompiled from Move bytecode v6
}

