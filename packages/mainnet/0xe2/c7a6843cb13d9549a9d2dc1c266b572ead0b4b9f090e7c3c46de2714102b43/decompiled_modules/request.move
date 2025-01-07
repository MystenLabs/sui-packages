module 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request {
    struct WithNft<phantom T0, phantom T1> {
        dummy_field: bool,
    }

    struct RequestBody<phantom T0> {
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        metadata: 0x2::object::UID,
    }

    struct Policy<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PolicyCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct RuleStateDfKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : RequestBody<T0> {
        RequestBody<T0>{
            receipts : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            metadata : 0x2::object::new(arg0),
        }
    }

    public fun add_receipt<T0, T1>(arg0: &mut RequestBody<T0>, arg1: &T1) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.receipts, 0x1::type_name::get<T1>());
    }

    public fun assert_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 1);
    }

    fun assert_version<T0>(arg0: &Policy<T0>) {
        assert!(arg0.version == 1, 1000);
    }

    public fun confirm<T0>(arg0: RequestBody<T0>, arg1: &Policy<T0>) {
        confirm_(0x2::vec_set::into_keys<0x1::type_name::TypeName>(destroy<T0>(arg0)), &arg1.rules);
    }

    fun confirm_(arg0: vector<0x1::type_name::TypeName>, arg1: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(&arg0);
        assert!(v0 == 0x2::vec_set::size<0x1::type_name::TypeName>(arg1), 3);
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg0);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(arg1, &v1), 2);
            v0 = v0 - 1;
        };
    }

    public fun destroy<T0>(arg0: RequestBody<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let RequestBody {
            receipts : v0,
            metadata : v1,
        } = arg0;
        0x2::object::delete(v1);
        v0
    }

    public fun drop_rule<T0, T1, T2: store>(arg0: &mut Policy<T0>, arg1: &PolicyCap) : T2 {
        assert_version<T0>(arg0);
        assert!(0x2::object::id<Policy<T0>>(arg0) == arg1.for, 4);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
        let v1 = RuleStateDfKey<T1>{dummy_field: false};
        0x2::dynamic_field::remove<RuleStateDfKey<T1>, T2>(&mut arg0.id, v1)
    }

    public fun drop_rule_no_state<T0, T1>(arg0: &mut Policy<T0>, arg1: &PolicyCap) {
        assert_version<T0>(arg0);
        assert!(0x2::object::id<Policy<T0>>(arg0) == arg1.for, 4);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
        let v1 = RuleStateDfKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::remove<RuleStateDfKey<T1>, bool>(&mut arg0.id, v1), 0);
    }

    public fun enforce_rule<T0, T1, T2: store>(arg0: &mut Policy<T0>, arg1: &PolicyCap, arg2: T2) {
        assert_version<T0>(arg0);
        assert!(0x2::object::id<Policy<T0>>(arg0) == arg1.for, 4);
        let v0 = RuleStateDfKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RuleStateDfKey<T1>, T2>(&mut arg0.id, v0, arg2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, 0x1::type_name::get<T1>());
    }

    public fun enforce_rule_no_state<T0, T1>(arg0: &mut Policy<T0>, arg1: &PolicyCap) {
        assert_version<T0>(arg0);
        assert!(0x2::object::id<Policy<T0>>(arg0) == arg1.for, 4);
        let v0 = RuleStateDfKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RuleStateDfKey<T1>, bool>(&mut arg0.id, v0, true);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, 0x1::type_name::get<T1>());
    }

    public fun metadata<T0>(arg0: &RequestBody<T0>) : &0x2::object::UID {
        &arg0.metadata
    }

    public fun metadata_mut<T0>(arg0: &mut RequestBody<T0>) : &mut 0x2::object::UID {
        &mut arg0.metadata
    }

    entry fun migrate<T0>(arg0: &mut Policy<T0>, arg1: &PolicyCap) {
        assert!(0x2::object::id<Policy<T0>>(arg0) == arg1.for, 4);
        assert!(arg0.version < 1, 999);
        arg0.version = 1;
    }

    entry fun migrate_as_pub<T0>(arg0: &mut Policy<T0>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::ob_request::OB_REQUEST>(arg1), 0);
        assert!(arg0.version < 1, 999);
        arg0.version = 1;
    }

    public fun new_policy<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Policy<T0>, PolicyCap) {
        let v0 = Policy<T0>{
            id      : 0x2::object::new(arg1),
            version : 1,
            rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = PolicyCap{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::id<Policy<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun new_policy_with_type<T0, T1: drop>(arg0: T1, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : (Policy<WithNft<T0, T1>>, PolicyCap) {
        assert_publisher<T0>(arg1);
        let v0 = Policy<WithNft<T0, T1>>{
            id      : 0x2::object::new(arg2),
            version : 1,
            rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = PolicyCap{
            id  : 0x2::object::new(arg2),
            for : 0x2::object::id<Policy<WithNft<T0, T1>>>(&v0),
        };
        (v0, v1)
    }

    public fun policy_cap_for(arg0: &PolicyCap) : &0x2::object::ID {
        &arg0.for
    }

    public fun policy_metadata<T0>(arg0: &Policy<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun policy_metadata_mut<T0>(arg0: &mut Policy<T0>) : &mut 0x2::object::UID {
        assert_version<T0>(arg0);
        &mut arg0.id
    }

    public fun receipts<T0>(arg0: &RequestBody<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.receipts
    }

    public fun rule_state<T0, T1: drop, T2: drop + store>(arg0: &Policy<T0>, arg1: T1) : &T2 {
        let v0 = RuleStateDfKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleStateDfKey<T1>, T2>(&arg0.id, v0)
    }

    public fun rule_state_mut<T0, T1: drop, T2: drop + store>(arg0: &mut Policy<T0>, arg1: T1) : &mut T2 {
        assert_version<T0>(arg0);
        let v0 = RuleStateDfKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RuleStateDfKey<T1>, T2>(&mut arg0.id, v0)
    }

    public fun rules<T0>(arg0: &Policy<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.rules
    }

    // decompiled from Move bytecode v6
}

