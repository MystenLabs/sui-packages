module 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::access_policy {
    struct AccessPolicyRule has drop {
        dummy_field: bool,
    }

    struct AccessPolicy<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        version: u64,
        parent_access: 0x2::vec_set::VecSet<address>,
        field_access: 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct NewPolicyEvent has copy, drop {
        policy_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    public fun add_field_access<T0: store + key, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg2: vector<address>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_domain_mut<T0, AccessPolicy<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AccessPolicy<T0>, Witness>(v0), arg1);
        assert_version_and_upgrade<T0>(v1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::insert_vec_in_vec_set<address>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&mut v1.field_access, 0x1::type_name::get<T1>()), arg2);
    }

    public fun add_field_access_to_policy<T0: store + key, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut AccessPolicy<T0>, arg2: vector<address>) {
        assert_version_and_upgrade<T0>(arg1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::insert_vec_in_vec_set<address>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&mut arg1.field_access, 0x1::type_name::get<T1>()), arg2);
    }

    public fun add_new<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = NewPolicyEvent{
            policy_id : 0x2::object::uid_to_inner(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<NewPolicyEvent>(v1);
        let v2 = AccessPolicy<T0>{
            id            : v0,
            version       : 2,
            parent_access : empty_parent_access(),
            field_access  : empty_field_access(arg2),
        };
        0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::add_domain<T0, AccessPolicy<T0>>(arg0, arg1, v2);
    }

    public fun add_parent_access<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>, arg2: vector<address>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_domain_mut<T0, AccessPolicy<T0>>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<AccessPolicy<T0>, Witness>(v0), arg1);
        assert_version_and_upgrade<T0>(v1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::insert_vec_in_vec_set<address>(&mut v1.parent_access, arg2);
    }

    public fun add_parent_access_to_policy<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut AccessPolicy<T0>, arg2: vector<address>) {
        assert_version_and_upgrade<T0>(arg1);
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::insert_vec_in_vec_set<address>(&mut arg1.parent_access, arg2);
    }

    public fun assert_field_auth<T0: store + key>(arg0: &AccessPolicy<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&arg0.field_access, arg1), &v0), 2);
    }

    fun assert_no_access_policy<T0: drop, T1: store + key>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T0>) {
        assert!(!0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::has_domain<T0, AccessPolicy<T1>>(arg0), 1);
    }

    public fun assert_parent_auth<T0: store + key>(arg0: &AccessPolicy<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.parent_access, &v0), 3);
    }

    fun assert_version<T0: store + key>(arg0: &AccessPolicy<T0>) {
        assert!(arg0.version == 2, 1000);
    }

    fun assert_version_and_upgrade<T0: store + key>(arg0: &mut AccessPolicy<T0>) {
        if (arg0.version < 2) {
            arg0.version = 2;
        };
        assert_version<T0>(arg0);
    }

    public fun confirm<T0: drop, T1: store + key>(arg0: &AccessPolicy<T1>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T1>(arg0);
        if (0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::is_borrow_field<T0, T1>(arg1)) {
            assert_field_auth<T1>(arg0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::field<T0, T1>(arg1), arg2);
        } else {
            assert_parent_auth<T1>(arg0, arg2);
        };
        let v0 = AccessPolicyRule{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::add_receipt<T0, T1, AccessPolicyRule>(arg1, &v0);
    }

    public fun confirm_from_collection<T0: drop, T1: store + key>(arg0: &0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::Collection<T1>, arg1: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::collection::borrow_domain<T1, AccessPolicy<T1>>(arg0);
        assert_version<T1>(v0);
        confirm<T0, T1>(v0, arg1, arg2);
    }

    public fun create_new<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::tx_context::TxContext) : AccessPolicy<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = NewPolicyEvent{
            policy_id : 0x2::object::uid_to_inner(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<NewPolicyEvent>(v1);
        AccessPolicy<T0>{
            id            : v0,
            version       : 2,
            parent_access : empty_parent_access(),
            field_access  : empty_field_access(arg1),
        }
    }

    public fun drop<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::drop_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, AccessPolicyRule>(arg0, arg1);
    }

    fun empty_field_access(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>> {
        0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(arg0)
    }

    fun empty_parent_access() : 0x2::vec_set::VecSet<address> {
        0x2::vec_set::empty<address>()
    }

    public entry fun enforce<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::enforce_rule_no_state<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>, AccessPolicyRule>(arg0, arg1);
    }

    entry fun migrate_as_creator<T0: store + key>(arg0: &mut AccessPolicy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 2;
    }

    entry fun migrate_as_pub<T0: store + key>(arg0: &mut AccessPolicy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0xa4651b55698b80d11ca8bc90b7c76c5570391b8b12f7535725bbabc28e8efe5a::nft_protocol::NFT_PROTOCOL>(arg1), 0);
        arg0.version = 2;
    }

    // decompiled from Move bytecode v6
}

