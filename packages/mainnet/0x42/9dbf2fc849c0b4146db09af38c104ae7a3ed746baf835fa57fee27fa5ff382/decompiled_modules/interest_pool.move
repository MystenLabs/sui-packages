module 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::interest_pool {
    struct InterestPool<phantom T0> has key {
        id: 0x2::object::UID,
        coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        state: 0x2::versioned::Versioned,
        pool_admin_address: address,
        hooks: 0x1::option::Option<Hooks>,
    }

    struct Hooks has store {
        rules: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        config: 0x2::bag::Bag,
    }

    struct HooksBuilder {
        rules: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        config: 0x2::bag::Bag,
    }

    struct Request {
        name: 0x1::string::String,
        pool_address: address,
        approvals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public(friend) fun new<T0>(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: 0x2::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) : (InterestPool<T0>, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::PoolAdmin) {
        0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::curves::assert_curve<T0>();
        let v0 = 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::new(arg2);
        let v1 = InterestPool<T0>{
            id                 : 0x2::object::new(arg2),
            coins              : arg0,
            state              : arg1,
            pool_admin_address : 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::addy(&v0),
            hooks              : 0x1::option::none<Hooks>(),
        };
        (v1, v0)
    }

    public fun add_liquidity_hooks<T0>(arg0: &InterestPool<T0>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        hook<T0>(arg0, b"START_ADD_LIQUIDITY", b"FINISH_ADD_LIQUIDITY")
    }

    public fun add_rule<T0: drop>(arg0: &mut HooksBuilder, arg1: 0x1::string::String, arg2: T0) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, &arg1), 0x1::type_name::get<T0>());
    }

    public fun add_rule_config<T0: drop, T1: store>(arg0: &mut HooksBuilder, arg1: T0, arg2: T1) {
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg0.config, 0x1::type_name::get<T0>(), arg2);
    }

    public fun addy<T0>(arg0: &InterestPool<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun approvals(arg0: &Request) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.approvals
    }

    public fun approve<T0: drop>(arg0: &mut Request, arg1: T0) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.approvals, 0x1::type_name::get<T0>());
    }

    public fun are_coins_ordered<T0>(arg0: &InterestPool<T0>, arg1: vector<0x1::type_name::TypeName>) : bool {
        let v0 = coins<T0>(arg0);
        let v1 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::comparator::compare<vector<0x1::type_name::TypeName>>(&v0, &arg1);
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::comparator::eq(&v1)
    }

    public fun assert_pool_admin<T0>(arg0: &InterestPool<T0>, arg1: &0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::PoolAdmin) {
        assert!(arg0.pool_admin_address == 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::addy(arg1), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::invalid_pool_admin());
    }

    public fun coins<T0>(arg0: &InterestPool<T0>) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.coins)
    }

    public fun config<T0, T1: drop, T2: store>(arg0: &InterestPool<T0>) : &T2 {
        0x2::bag::borrow<0x1::type_name::TypeName, T2>(&0x1::option::borrow<Hooks>(&arg0.hooks).config, 0x1::type_name::get<T1>())
    }

    public fun config_mut<T0, T1: drop, T2: store>(arg0: &mut InterestPool<T0>, arg1: T1) : &mut T2 {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, T2>(&mut 0x1::option::borrow_mut<Hooks>(&mut arg0.hooks).config, 0x1::type_name::get<T1>())
    }

    fun confirm<T0>(arg0: &InterestPool<T0>, arg1: Request) {
        let v0 = 0x1::option::borrow<Hooks>(&arg0.hooks);
        let Request {
            name         : v1,
            pool_address : v2,
            approvals    : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v1;
        assert!(addy<T0>(arg0) == v2, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::wrong_request_pool_address());
        let v6 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v0.rules, &v5));
        assert!(!0x1::vector::is_empty<0x1::type_name::TypeName>(&v6), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::invalid_hook_name());
        let v7 = 0;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v6) > v7) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v4, 0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v7)), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::rule_not_approved());
            v7 = v7 + 1;
        };
    }

    public fun donate_hooks<T0>(arg0: &InterestPool<T0>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        hook<T0>(arg0, b"START_DONATE", b"FINISH_DONATE")
    }

    public fun finish<T0>(arg0: &InterestPool<T0>, arg1: Request) {
        let v0 = name(&arg1);
        let v1 = 0x1::string::utf8(b"F");
        assert!(0x1::string::index_of(&v0, &v1) == 0, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::must_be_finish_request());
        confirm<T0>(arg0, arg1);
    }

    public(friend) fun finish_add_liquidity<T0>(arg0: &InterestPool<T0>, arg1: Request) : Request {
        assert!(has_add_liquidity_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_add_liquidity_hooks());
        let v0 = name(&arg1);
        let v1 = b"START_ADD_LIQUIDITY";
        assert!(0x1::string::bytes(&v0) == &v1, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::must_be_start_add_liquidity_request());
        confirm<T0>(arg0, arg1);
        new_request<T0>(arg0, 0x1::string::utf8(b"FINISH_ADD_LIQUIDITY"))
    }

    public fun finish_add_liquidity_name() : vector<u8> {
        b"FINISH_ADD_LIQUIDITY"
    }

    public(friend) fun finish_donate<T0>(arg0: &InterestPool<T0>, arg1: Request) : Request {
        assert!(has_donate_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_donate_hooks());
        let v0 = name(&arg1);
        let v1 = b"START_DONATE";
        assert!(0x1::string::bytes(&v0) == &v1, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::must_be_start_donate_request());
        confirm<T0>(arg0, arg1);
        new_request<T0>(arg0, 0x1::string::utf8(b"FINISH_DONATE"))
    }

    public fun finish_donate_name() : vector<u8> {
        b"FINISH_DONATE"
    }

    public(friend) fun finish_remove_liquidity<T0>(arg0: &InterestPool<T0>, arg1: Request) : Request {
        assert!(has_remove_liquidity_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_remove_liquidity_hooks());
        let v0 = name(&arg1);
        let v1 = b"START_REMOVE_LIQUIDITY";
        assert!(0x1::string::bytes(&v0) == &v1, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::must_be_start_remove_liquidity_request());
        confirm<T0>(arg0, arg1);
        new_request<T0>(arg0, 0x1::string::utf8(b"FINISH_REMOVE_LIQUIDITY"))
    }

    public fun finish_remove_liquidity_name() : vector<u8> {
        b"FINISH_REMOVE_LIQUIDITY"
    }

    public(friend) fun finish_swap<T0>(arg0: &InterestPool<T0>, arg1: Request) : Request {
        assert!(has_swap_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_swap_hooks());
        let v0 = name(&arg1);
        let v1 = b"START_SWAP";
        assert!(0x1::string::bytes(&v0) == &v1, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::must_be_start_swap_request());
        confirm<T0>(arg0, arg1);
        new_request<T0>(arg0, 0x1::string::utf8(b"FINISH_SWAP"))
    }

    public fun finish_swap_name() : vector<u8> {
        b"FINISH_SWAP"
    }

    public fun has_add_liquidity_hooks<T0>(arg0: &InterestPool<T0>) : bool {
        has_hook<T0>(arg0, b"START_ADD_LIQUIDITY", b"FINISH_ADD_LIQUIDITY")
    }

    public fun has_donate_hooks<T0>(arg0: &InterestPool<T0>) : bool {
        has_hook<T0>(arg0, b"START_DONATE", b"FINISH_DONATE")
    }

    fun has_hook<T0>(arg0: &InterestPool<T0>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        if (!has_hooks<T0>(arg0)) {
            return false
        };
        let v0 = 0x1::option::borrow<Hooks>(&arg0.hooks).rules;
        let v1 = 0x1::string::utf8(arg1);
        if (!0x2::vec_set::is_empty<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v0, &v1))) {
            true
        } else {
            let v3 = 0x1::string::utf8(arg2);
            !0x2::vec_set::is_empty<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v0, &v3))
        }
    }

    public fun has_hooks<T0>(arg0: &InterestPool<T0>) : bool {
        0x1::option::is_some<Hooks>(&arg0.hooks)
    }

    public fun has_remove_liquidity_hooks<T0>(arg0: &InterestPool<T0>) : bool {
        has_hook<T0>(arg0, b"START_REMOVE_LIQUIDITY", b"FINISH_REMOVE_LIQUIDITY")
    }

    public fun has_rule_config<T0, T1: drop>(arg0: &InterestPool<T0>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&0x1::option::borrow<Hooks>(&arg0.hooks).config, 0x1::type_name::get<T1>())
    }

    public fun has_swap_hooks<T0>(arg0: &InterestPool<T0>) : bool {
        has_hook<T0>(arg0, b"START_SWAP", b"FINISH_SWAP")
    }

    fun hook<T0>(arg0: &InterestPool<T0>, arg1: vector<u8>, arg2: vector<u8>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        if (!has_hooks<T0>(arg0)) {
            return (0x1::vector::empty<0x1::type_name::TypeName>(), 0x1::vector::empty<0x1::type_name::TypeName>())
        };
        let v0 = 0x1::option::borrow<Hooks>(&arg0.hooks).rules;
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::utf8(arg2);
        (0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v0, &v1)), 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&v0, &v2)))
    }

    public fun name(arg0: &Request) : 0x1::string::String {
        arg0.name
    }

    public fun new_hooks_builder(arg0: &mut 0x2::tx_context::TxContext) : HooksBuilder {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"START_SWAP"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"FINISH_SWAP"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"START_ADD_LIQUIDITY"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"FINISH_ADD_LIQUIDITY"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"START_REMOVE_LIQUIDITY"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"FINISH_REMOVE_LIQUIDITY"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"START_DONATE"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, 0x1::string::utf8(b"FINISH_DONATE"), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        HooksBuilder{
            rules  : v0,
            config : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun new_request<T0>(arg0: &InterestPool<T0>, arg1: 0x1::string::String) : Request {
        Request{
            name         : arg1,
            pool_address : addy<T0>(arg0),
            approvals    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun new_with_hooks<T0>(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: 0x2::versioned::Versioned, arg2: HooksBuilder, arg3: &mut 0x2::tx_context::TxContext) : (InterestPool<T0>, 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::PoolAdmin) {
        0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::curves::assert_curve<T0>();
        let HooksBuilder {
            rules  : v0,
            config : v1,
        } = arg2;
        let v2 = 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::new(arg3);
        let v3 = Hooks{
            rules  : v0,
            config : v1,
        };
        let v4 = InterestPool<T0>{
            id                 : 0x2::object::new(arg3),
            coins              : arg0,
            state              : arg1,
            pool_admin_address : 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::addy(&v2),
            hooks              : 0x1::option::some<Hooks>(v3),
        };
        (v4, v2)
    }

    public fun pool_address(arg0: &Request) : address {
        arg0.pool_address
    }

    public fun pool_admin_address<T0>(arg0: &InterestPool<T0>) : address {
        arg0.pool_admin_address
    }

    public fun remove_liquidity_hooks<T0>(arg0: &InterestPool<T0>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        hook<T0>(arg0, b"START_REMOVE_LIQUIDITY", b"FINISH_REMOVE_LIQUIDITY")
    }

    public fun share<T0>(arg0: InterestPool<T0>) {
        0x2::transfer::share_object<InterestPool<T0>>(arg0);
    }

    public fun start_add_liquidity<T0>(arg0: &InterestPool<T0>) : Request {
        assert!(has_add_liquidity_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_add_liquidity_hooks());
        new_request<T0>(arg0, 0x1::string::utf8(b"START_ADD_LIQUIDITY"))
    }

    public fun start_add_liquidity_name() : vector<u8> {
        b"START_ADD_LIQUIDITY"
    }

    public fun start_donate<T0>(arg0: &InterestPool<T0>) : Request {
        assert!(has_donate_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_donate_hooks());
        new_request<T0>(arg0, 0x1::string::utf8(b"START_DONATE"))
    }

    public fun start_donate_name() : vector<u8> {
        b"START_DONATE"
    }

    public fun start_remove_liquidity<T0>(arg0: &InterestPool<T0>) : Request {
        assert!(has_remove_liquidity_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_remove_liquidity_hooks());
        new_request<T0>(arg0, 0x1::string::utf8(b"START_REMOVE_LIQUIDITY"))
    }

    public fun start_remove_liquidity_name() : vector<u8> {
        b"START_REMOVE_LIQUIDITY"
    }

    public fun start_swap<T0>(arg0: &InterestPool<T0>) : Request {
        assert!(has_swap_hooks<T0>(arg0), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::pool_has_no_swap_hooks());
        new_request<T0>(arg0, 0x1::string::utf8(b"START_SWAP"))
    }

    public fun start_swap_name() : vector<u8> {
        b"START_SWAP"
    }

    public(friend) fun state<T0>(arg0: &InterestPool<T0>) : &0x2::versioned::Versioned {
        &arg0.state
    }

    public(friend) fun state_mut<T0>(arg0: &mut InterestPool<T0>) : &mut 0x2::versioned::Versioned {
        &mut arg0.state
    }

    public fun swap_hooks<T0>(arg0: &InterestPool<T0>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        hook<T0>(arg0, b"START_SWAP", b"FINISH_SWAP")
    }

    public fun uid_mut<T0>(arg0: &mut InterestPool<T0>, arg1: &0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::pool_admin::PoolAdmin) : &mut 0x2::object::UID {
        assert_pool_admin<T0>(arg0, arg1);
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

