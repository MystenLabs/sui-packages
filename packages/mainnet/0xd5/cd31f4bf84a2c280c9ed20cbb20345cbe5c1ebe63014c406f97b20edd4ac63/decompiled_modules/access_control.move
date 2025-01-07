module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::access_control {
    struct AccessControl has store, key {
        id: 0x2::object::UID,
        roles: 0x2::vec_map::VecMap<vector<u8>, 0x2::vec_set::VecSet<address>>,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
        access_control: address,
    }

    public fun destroy_empty(arg0: AccessControl) {
        let AccessControl {
            id    : v0,
            roles : v1,
        } = arg0;
        0x2::vec_map::destroy_empty<vector<u8>, 0x2::vec_set::VecSet<address>>(v1);
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (AccessControl, Admin) {
        let v0 = AccessControl{
            id    : 0x2::object::new(arg0),
            roles : 0x2::vec_map::empty<vector<u8>, 0x2::vec_set::VecSet<address>>(),
        };
        let v1 = new_admin(&v0, arg0);
        let v2 = &mut v0;
        new_role_singleton_impl(v2, b"SUPER_ADMIN_ROLE", 0x2::object::uid_to_address(&v1.id));
        (v0, v1)
    }

    public fun contains(arg0: &AccessControl, arg1: vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.roles, &arg1)
    }

    public fun remove(arg0: &Admin, arg1: &mut AccessControl, arg2: vector<u8>) {
        assert_super_admin(arg0, arg1);
        if (contains(arg1, arg2)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2);
        };
    }

    public fun access_control(arg0: &Admin) : address {
        arg0.access_control
    }

    public fun add(arg0: &Admin, arg1: &mut AccessControl, arg2: vector<u8>) {
        assert_super_admin(arg0, arg1);
        if (!contains(arg1, arg2)) {
            new_role_impl(arg1, arg2);
        };
    }

    fun assert_super_admin(arg0: &Admin, arg1: &AccessControl) {
        assert!(has_role(arg0, arg1, b"SUPER_ADMIN_ROLE"), 1);
    }

    public fun destroy(arg0: &Admin, arg1: AccessControl) {
        assert_super_admin(arg0, &arg1);
        let AccessControl {
            id    : v0,
            roles : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun destroy_account(arg0: Admin) {
        let Admin {
            id             : v0,
            access_control : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun grant(arg0: &Admin, arg1: &mut AccessControl, arg2: vector<u8>, arg3: address) {
        assert_super_admin(arg0, arg1);
        if (contains(arg1, arg2)) {
            0x2::vec_set::insert<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), arg3);
        } else {
            new_role_singleton_impl(arg1, arg2, arg3);
        };
    }

    public fun has_role(arg0: &Admin, arg1: &AccessControl, arg2: vector<u8>) : bool {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.access_control, 0);
        has_role_(0x2::object::uid_to_address(&arg0.id), arg1, arg2)
    }

    public fun has_role_(arg0: address, arg1: &AccessControl, arg2: vector<u8>) : bool {
        0x2::vec_map::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.roles, &arg2) && 0x2::vec_set::contains<address>(0x2::vec_map::get<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.roles, &arg2), &arg0)
    }

    public fun new_admin(arg0: &AccessControl, arg1: &mut 0x2::tx_context::TxContext) : Admin {
        Admin{
            id             : 0x2::object::new(arg1),
            access_control : 0x2::object::uid_to_address(&arg0.id),
        }
    }

    fun new_role_impl(arg0: &mut AccessControl, arg1: vector<u8>) {
        0x2::vec_map::insert<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg1, 0x2::vec_set::empty<address>());
    }

    fun new_role_singleton_impl(arg0: &mut AccessControl, arg1: vector<u8>, arg2: address) {
        0x2::vec_map::insert<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.roles, arg1, 0x2::vec_set::singleton<address>(arg2));
    }

    public fun renounce(arg0: &Admin, arg1: &mut AccessControl, arg2: vector<u8>) {
        assert!(0x2::object::uid_to_address(&arg1.id) == arg0.access_control, 0);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        if (has_role_(v0, arg1, arg2)) {
            0x2::vec_set::remove<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), &v0);
        };
    }

    public fun revoke(arg0: &Admin, arg1: &mut AccessControl, arg2: vector<u8>, arg3: address) {
        assert_super_admin(arg0, arg1);
        assert!(contains(arg1, arg2), 2);
        if (has_role_(arg3, arg1, arg2)) {
            0x2::vec_set::remove<address>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg1.roles, &arg2), &arg3);
        };
    }

    public fun super_admin_role() : vector<u8> {
        b"SUPER_ADMIN_ROLE"
    }

    // decompiled from Move bytecode v6
}

