module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::access_policy {
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

    public fun add_field_access<T0: store + key, T1: store>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: vector<address>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_domain_mut<T0, AccessPolicy<T0>>(0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::from_witness<AccessPolicy<T0>, Witness>(v0), arg1);
        assert_version<T0>(v1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::insert_vec_in_vec_set<address>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&mut v1.field_access, 0x1::type_name::get<T1>()), arg2);
    }

    public fun add_field_access_to_policy<T0: store + key, T1: store>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut AccessPolicy<T0>, arg2: vector<address>) {
        assert_version<T0>(arg1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::insert_vec_in_vec_set<address>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&mut arg1.field_access, 0x1::type_name::get<T1>()), arg2);
    }

    public fun add_new<T0: store + key>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = NewPolicyEvent{
            policy_id : 0x2::object::uid_to_inner(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<NewPolicyEvent>(v1);
        let v2 = AccessPolicy<T0>{
            id            : v0,
            version       : 1,
            parent_access : empty_parent_access(),
            field_access  : empty_field_access(arg2),
        };
        0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::add_domain<T0, AccessPolicy<T0>>(arg0, arg1, v2);
    }

    public fun add_parent_access<T0: store + key>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>, arg2: vector<address>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_domain_mut<T0, AccessPolicy<T0>>(0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::from_witness<AccessPolicy<T0>, Witness>(v0), arg1);
        assert_version<T0>(v1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::insert_vec_in_vec_set<address>(&mut v1.parent_access, arg2);
    }

    public fun add_parent_access_to_policy<T0: store + key>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut AccessPolicy<T0>, arg2: vector<address>) {
        assert_version<T0>(arg1);
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::insert_vec_in_vec_set<address>(&mut arg1.parent_access, arg2);
    }

    public fun assert_field_auth<T0: store + key>(arg0: &AccessPolicy<T0>, arg1: 0x1::type_name::TypeName, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(&arg0.field_access, arg1), &v0), 2);
    }

    fun assert_no_access_policy<T0: drop, T1: store + key>(arg0: &0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T0>) {
        assert!(!0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::has_domain<T0, AccessPolicy<T1>>(arg0), 1);
    }

    public fun assert_parent_auth<T0: store + key>(arg0: &AccessPolicy<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.parent_access, &v0), 3);
    }

    fun assert_version<T0: store + key>(arg0: &AccessPolicy<T0>) {
        assert!(arg0.version == 1, 1000);
    }

    public fun confirm<T0: drop, T1: store + key>(arg0: &AccessPolicy<T1>, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::borrow_request::BorrowRequest<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T1>(arg0);
        if (0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::borrow_request::is_borrow_field<T0, T1>(arg1)) {
            assert_field_auth<T1>(arg0, 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::borrow_request::field<T0, T1>(arg1), arg2);
        } else {
            assert_parent_auth<T1>(arg0, arg2);
        };
        let v0 = AccessPolicyRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::borrow_request::add_receipt<T0, T1, AccessPolicyRule>(arg1, &v0);
    }

    public fun confirm_from_collection<T0: drop, T1: store + key>(arg0: &0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::Collection<T1>, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::borrow_request::BorrowRequest<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::collection::borrow_domain<T1, AccessPolicy<T1>>(arg0);
        assert_version<T1>(v0);
        confirm<T0, T1>(v0, arg1, arg2);
    }

    public fun create_new<T0: store + key>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &mut 0x2::tx_context::TxContext) : AccessPolicy<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = NewPolicyEvent{
            policy_id : 0x2::object::uid_to_inner(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<NewPolicyEvent>(v1);
        AccessPolicy<T0>{
            id            : v0,
            version       : 1,
            parent_access : empty_parent_access(),
            field_access  : empty_field_access(arg1),
        }
    }

    public fun drop<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::drop_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, AccessPolicyRule>(arg0, arg1);
    }

    fun empty_field_access(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>> {
        0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<address>>(arg0)
    }

    fun empty_parent_access() : 0x2::vec_set::VecSet<address> {
        0x2::vec_set::empty<address>()
    }

    public fun enforce<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::enforce_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, AccessPolicyRule>(arg0, arg1);
    }

    entry fun migrate_as_creator<T0: store + key>(arg0: &mut AccessPolicy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg1), 0);
        arg0.version = 1;
    }

    entry fun migrate_as_pub<T0: store + key>(arg0: &mut AccessPolicy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::nft_protocol::NFT_PROTOCOL>(arg1), 0);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

