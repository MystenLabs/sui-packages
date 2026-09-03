module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules {
    struct RuleSet<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        required: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        any_of: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        configs: 0x2::bag::Bag,
    }

    struct RuleSetCap has store, key {
        id: 0x2::object::UID,
        set: 0x2::object::ID,
    }

    struct Approval has copy, drop, store {
        rule: 0x1::type_name::TypeName,
        set: 0x2::object::ID,
    }

    struct Request<phantom T0> {
        key: address,
        account: address,
        approvals: 0x2::vec_set::VecSet<Approval>,
    }

    public fun add<T0, T1: drop, T2: store>(arg0: T1, arg1: &mut RuleSet<T0>, arg2: &RuleSetCap, arg3: T2, arg4: bool) {
        assert_version<T0>(arg1);
        assert!(arg2.set == 0x2::object::id<RuleSet<T0>>(arg1), 5);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.required, &v0) && !0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.any_of, &v0), 0);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg1.required) + 0x2::vec_set::length<0x1::type_name::TypeName>(&arg1.any_of) < 20, 4);
        if (arg4) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.required, v0);
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.any_of, v0);
        };
        0x2::bag::add<0x1::type_name::TypeName, T2>(&mut arg1.configs, v0, arg3);
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : (RuleSet<T0>, RuleSetCap) {
        let v0 = RuleSet<T0>{
            id       : 0x2::object::new(arg0),
            version  : 1,
            required : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            any_of   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            configs  : 0x2::bag::new(arg0),
        };
        let v1 = RuleSetCap{
            id  : 0x2::object::new(arg0),
            set : 0x2::object::id<RuleSet<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun remove<T0, T1: drop, T2: store>(arg0: &mut RuleSet<T0>, arg1: &RuleSetCap) : T2 {
        assert_version<T0>(arg0);
        assert!(arg1.set == 0x2::object::id<RuleSet<T0>>(arg0), 5);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.required, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.required, &v0);
        } else {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.any_of, &v0), 1);
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.any_of, &v0);
        };
        0x2::bag::remove<0x1::type_name::TypeName, T2>(&mut arg0.configs, v0)
    }

    public fun is_empty<T0>(arg0: &RuleSet<T0>) : bool {
        0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.required) && 0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.any_of)
    }

    public fun add_approval<T0, T1: drop>(arg0: T1, arg1: &RuleSet<T0>, arg2: &mut Request<T0>) {
        let v0 = Approval{
            rule : 0x1::type_name::with_defining_ids<T1>(),
            set  : 0x2::object::id<RuleSet<T0>>(arg1),
        };
        if (!0x2::vec_set::contains<Approval>(&arg2.approvals, &v0)) {
            0x2::vec_set::insert<Approval>(&mut arg2.approvals, v0);
        };
    }

    fun assert_version<T0>(arg0: &RuleSet<T0>) {
        assert!(arg0.version == 1, 6);
    }

    public(friend) fun check<T0>(arg0: &RuleSet<T0>, arg1: &Request<T0>) {
        let v0 = 0x2::object::id<RuleSet<T0>>(arg0);
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.required);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = Approval{
                rule : *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2),
                set  : v0,
            };
            assert!(0x2::vec_set::contains<Approval>(&arg1.approvals, &v3), 2);
            v2 = v2 + 1;
        };
        if (!0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.any_of)) {
            let v4 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.any_of);
            let v5 = false;
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
                let v7 = Approval{
                    rule : *0x1::vector::borrow<0x1::type_name::TypeName>(v4, v6),
                    set  : v0,
                };
                if (0x2::vec_set::contains<Approval>(&arg1.approvals, &v7)) {
                    v5 = true;
                    break
                };
                v6 = v6 + 1;
            };
            assert!(v5, 3);
        };
    }

    public fun config<T0, T1: drop, T2: store>(arg0: &RuleSet<T0>) : &T2 {
        0x2::bag::borrow<0x1::type_name::TypeName, T2>(&arg0.configs, 0x1::type_name::with_defining_ids<T1>())
    }

    public(friend) fun confirm<T0>(arg0: &RuleSet<T0>, arg1: Request<T0>) {
        check<T0>(arg0, &arg1);
        destroy<T0>(arg1);
    }

    public fun current_version() : u64 {
        1
    }

    public(friend) fun destroy<T0>(arg0: Request<T0>) {
        let Request {
            key       : _,
            account   : _,
            approvals : _,
        } = arg0;
    }

    public fun has_approval<T0, T1: drop>(arg0: &RuleSet<T0>, arg1: &Request<T0>) : bool {
        let v0 = Approval{
            rule : 0x1::type_name::with_defining_ids<T1>(),
            set  : 0x2::object::id<RuleSet<T0>>(arg0),
        };
        0x2::vec_set::contains<Approval>(&arg1.approvals, &v0)
    }

    public fun has_rule<T0, T1: drop>(arg0: &RuleSet<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.required, &v0) || 0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.any_of, &v0)
    }

    public fun migrate<T0>(arg0: &mut RuleSet<T0>, arg1: &RuleSetCap) {
        assert!(arg1.set == 0x2::object::id<RuleSet<T0>>(arg0), 5);
        assert!(arg0.version < 1, 7);
        arg0.version = 1;
    }

    public(friend) fun new_request<T0>(arg0: address, arg1: address) : Request<T0> {
        Request<T0>{
            key       : arg0,
            account   : arg1,
            approvals : 0x2::vec_set::empty<Approval>(),
        }
    }

    public fun request_account<T0>(arg0: &Request<T0>) : address {
        arg0.account
    }

    public fun request_key<T0>(arg0: &Request<T0>) : address {
        arg0.key
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"Humming 1.0.0")
    }

    public fun version<T0>(arg0: &RuleSet<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

