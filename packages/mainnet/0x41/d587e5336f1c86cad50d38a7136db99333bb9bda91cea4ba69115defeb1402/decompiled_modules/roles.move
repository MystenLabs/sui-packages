module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles {
    struct AdminRole {
        dummy_field: bool,
    }

    struct BenefactorRole {
        dummy_field: bool,
    }

    struct Roles has store {
        data: 0x2::bag::Bag,
        admin_count: u64,
    }

    struct Role<phantom T0> has copy, drop, store {
        addr: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Roles {
        Roles{
            data        : 0x2::bag::new(arg0),
            admin_count : 0,
        }
    }

    public(friend) fun assert_is_authorized<T0>(arg0: &Roles, arg1: address) {
        assert!(is_authorized<T0>(arg0, arg1), 13835621366012968963);
    }

    public(friend) fun authorize<T0>(arg0: &mut Roles, arg1: address) {
        let v0 = Role<T0>{addr: arg1};
        assert!(!0x2::bag::contains<Role<T0>>(&arg0.data, v0), 13835339775072010241);
        if (is_admin_role<T0>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        0x2::bag::add<Role<T0>, bool>(&mut arg0.data, v0, true);
    }

    public(friend) fun deauthorize<T0>(arg0: &mut Roles, arg1: address) {
        let v0 = Role<T0>{addr: arg1};
        assert!(0x2::bag::contains_with_type<Role<T0>, bool>(&arg0.data, v0), 13835902767975366661);
        if (is_admin_role<T0>()) {
            assert!(arg0.admin_count > 1, 13836184260132077575);
            arg0.admin_count = arg0.admin_count - 1;
        };
        0x2::bag::remove<Role<T0>, bool>(&mut arg0.data, v0);
    }

    fun is_admin_role<T0>() : bool {
        0x1::type_name::with_defining_ids<AdminRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public(friend) fun is_authorized<T0>(arg0: &Roles, arg1: address) : bool {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::contains<Role<T0>>(&arg0.data, v0)
    }

    public(friend) fun is_benefactor_role<T0>() : bool {
        0x1::type_name::with_defining_ids<BenefactorRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

