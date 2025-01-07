module 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token {
    struct Token<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        expiration: 0x1::option::Option<u64>,
    }

    struct TokenPolicyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct TokenPolicy<phantom T0> has key {
        id: 0x2::object::UID,
        spent_balance: 0x2::balance::Balance<T0>,
        rules: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    struct ActionRequest<phantom T0> {
        name: 0x1::string::String,
        amount: u64,
        sender: address,
        expiration: 0x1::option::Option<u64>,
        recipient: 0x1::option::Option<address>,
        spent_balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        approvals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RuleKey<phantom T0> has copy, drop, store {
        is_protected: bool,
    }

    struct TokenPolicyCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        is_mutable: bool,
    }

    public fun destroy_zero<T0>(arg0: Token<T0>) {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : _,
        } = arg0;
        let v3 = v1;
        assert!(0x2::balance::value<T0>(&v3) == 0, 4);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun join<T0>(arg0: &mut Token<T0>, arg1: Token<T0>) {
        if (0x1::option::is_some<u64>(&arg0.expiration) && 0x1::option::is_some<u64>(&arg1.expiration)) {
            join_with_expiration<T0>(arg0, arg1);
        } else {
            join_without_expiration<T0>(arg0, arg1);
        };
    }

    public fun split<T0>(arg0: &mut Token<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Token<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 3);
        Token<T0>{
            id         : 0x2::object::new(arg2),
            balance    : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            expiration : arg0.expiration,
        }
    }

    public fun value<T0>(arg0: &Token<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<T0>(),
            expiration : 0x1::option::none<u64>(),
        }
    }

    public fun transfer<T0>(arg0: Token<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest<T0> {
        0x2::transfer::transfer<Token<T0>>(arg0, arg1);
        new_request<T0>(transfer_action(), 0x2::balance::value<T0>(&arg0.balance), arg0.expiration, 0x1::option::some<address>(arg1), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2)
    }

    public fun sender<T0>(arg0: &ActionRequest<T0>) : address {
        arg0.sender
    }

    public fun action<T0>(arg0: &ActionRequest<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun add_approval<T0, T1: drop>(arg0: T1, arg1: &mut ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.approvals, 0x1::type_name::get<T1>());
    }

    public fun add_rule_config<T0, T1: drop, T2: store>(arg0: T1, arg1: &mut TokenPolicy<T0>, arg2: &TokenPolicyCap<T0>, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg1) == arg2.for, 2);
        0x2::dynamic_field::add<RuleKey<T1>, T2>(&mut arg1.id, key<T1>(), arg3);
    }

    public fun add_rule_for_action<T0, T1: drop>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        if (!0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &arg2)) {
            allow<T0>(arg0, arg1, arg2, arg3);
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, &arg2), 0x1::type_name::get<T1>());
    }

    public fun allow<T0>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
    }

    public fun amount<T0>(arg0: &ActionRequest<T0>) : u64 {
        arg0.amount
    }

    public fun approvals<T0>(arg0: &ActionRequest<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.approvals
    }

    public fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: Token<T0>) {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : _,
        } = arg1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), v1);
        0x2::object::delete(v0);
    }

    public fun confirm_request<T0>(arg0: &TokenPolicy<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::option::Option<u64>, address, 0x1::option::Option<address>) {
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&arg1.spent_balance), 5);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &arg1.name), 0);
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            expiration    : v3,
            recipient     : v4,
            spent_balance : v5,
            approvals     : v6,
        } = arg1;
        let v7 = v6;
        let v8 = v0;
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v5);
        let v9 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &v8));
        let v10 = &v9;
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::type_name::TypeName>(v10)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v7, 0x1::vector::borrow<0x1::type_name::TypeName>(v10, v11)), 1);
            v11 = v11 + 1;
        };
        (v8, v1, v3, v2, v4)
    }

    public fun confirm_request_mut<T0>(arg0: &mut TokenPolicy<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::option::Option<u64>, address, 0x1::option::Option<address>) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &arg1.name), 0);
        assert!(0x1::option::is_some<0x2::balance::Balance<T0>>(&arg1.spent_balance), 7);
        0x2::balance::join<T0>(&mut arg0.spent_balance, 0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg1.spent_balance));
        confirm_request<T0>(arg0, arg1, arg2)
    }

    public fun confirm_with_policy_cap<T0>(arg0: &TokenPolicyCap<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::option::Option<u64>, address, 0x1::option::Option<address>) {
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&arg1.spent_balance), 5);
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            expiration    : v3,
            recipient     : v4,
            spent_balance : v5,
            approvals     : _,
        } = arg1;
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v5);
        (v0, v1, v3, v2, v4)
    }

    public fun confirm_with_treasury_cap<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::option::Option<u64>, address, 0x1::option::Option<address>) {
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            expiration    : v3,
            recipient     : v4,
            spent_balance : v5,
            approvals     : _,
        } = arg1;
        let v7 = v5;
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v7)) {
            0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v7));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v7);
        };
        (v0, v1, v3, v2, v4)
    }

    public fun disallow<T0>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, &arg2);
    }

    public fun expiration<T0>(arg0: &ActionRequest<T0>) : 0x1::option::Option<u64> {
        arg0.expiration
    }

    public fun expiration_value<T0>(arg0: &Token<T0>) : u64 {
        *0x1::option::borrow<u64>(&arg0.expiration)
    }

    public fun flush<T0>(arg0: &mut TokenPolicy<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg1), 0x2::balance::split<T0>(&mut arg0.spent_balance, 0x2::balance::value<T0>(&arg0.spent_balance)))
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (Token<T0>, ActionRequest<T0>) {
        let v0 = Token<T0>{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::coin::into_balance<T0>(arg0),
            expiration : 0x1::option::none<u64>(),
        };
        (v0, new_request<T0>(from_coin_action(), 0x2::coin::value<T0>(&arg0), 0x1::option::none<u64>(), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
    }

    public fun from_coin_action() : 0x1::string::String {
        0x1::string::utf8(b"from_coin")
    }

    public fun has_rule_config<T0, T1>(arg0: &TokenPolicy<T0>) : bool {
        0x2::dynamic_field::exists_<RuleKey<T1>>(&arg0.id, key<T1>())
    }

    public fun has_rule_config_with_type<T0, T1, T2: store>(arg0: &TokenPolicy<T0>) : bool {
        0x2::dynamic_field::exists_with_type<RuleKey<T1>, T2>(&arg0.id, key<T1>())
    }

    public fun is_allowed<T0>(arg0: &TokenPolicy<T0>, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, arg1)
    }

    fun join_with_expiration<T0>(arg0: &mut Token<T0>, arg1: Token<T0>) {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : v2,
        } = arg1;
        let v3 = v2;
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
        if (*0x1::option::borrow<u64>(&arg0.expiration) > *0x1::option::borrow<u64>(&v3)) {
            arg0.expiration = v3;
        };
    }

    fun join_without_expiration<T0>(arg0: &mut Token<T0>, arg1: Token<T0>) {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : v2,
        } = arg1;
        assert!(arg0.expiration == 0x1::option::none<u64>() && v2 == 0x1::option::none<u64>(), 8);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
    }

    public fun keep<T0>(arg0: Token<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Token<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun key<T0>() : RuleKey<T0> {
        RuleKey<T0>{is_protected: true}
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id         : 0x2::object::new(arg2),
            balance    : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(arg0), arg1),
            expiration : 0x1::option::none<u64>(),
        }
    }

    public fun mint_with_expiration<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id         : 0x2::object::new(arg4),
            balance    : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(arg0), arg2),
            expiration : 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1) + arg3),
        }
    }

    public fun new_policy<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (TokenPolicy<T0>, TokenPolicyCap<T0>) {
        let v0 = TokenPolicy<T0>{
            id            : 0x2::object::new(arg1),
            spent_balance : 0x2::balance::zero<T0>(),
            rules         : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
        };
        let v1 = TokenPolicyCap<T0>{
            id  : 0x2::object::new(arg1),
            for : 0x2::object::id<TokenPolicy<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun new_request<T0>(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<0x2::balance::Balance<T0>>, arg5: &0x2::tx_context::TxContext) : ActionRequest<T0> {
        ActionRequest<T0>{
            name          : arg0,
            amount        : arg1,
            sender        : 0x2::tx_context::sender(arg5),
            expiration    : arg2,
            recipient     : arg3,
            spent_balance : arg4,
            approvals     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun recipient<T0>(arg0: &ActionRequest<T0>) : 0x1::option::Option<address> {
        arg0.recipient
    }

    public fun remove_rule_config<T0, T1, T2: store>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : T2 {
        assert!(has_rule_config_with_type<T0, T1, T2>(arg0), 6);
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        0x2::dynamic_field::remove<RuleKey<T1>, T2>(&mut arg0.id, key<T1>())
    }

    public fun remove_rule_for_action<T0, T1: drop>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, &arg2), &v0);
    }

    public fun rule_config<T0, T1: drop, T2: store>(arg0: T1, arg1: &TokenPolicy<T0>) : &T2 {
        assert!(has_rule_config_with_type<T0, T1, T2>(arg1), 6);
        0x2::dynamic_field::borrow<RuleKey<T1>, T2>(&arg1.id, key<T1>())
    }

    public fun rule_config_mut<T0, T1: drop, T2: store>(arg0: T1, arg1: &mut TokenPolicy<T0>, arg2: &TokenPolicyCap<T0>) : &mut T2 {
        assert!(has_rule_config_with_type<T0, T1, T2>(arg1), 6);
        assert!(0x2::object::id<TokenPolicy<T0>>(arg1) == arg2.for, 2);
        0x2::dynamic_field::borrow_mut<RuleKey<T1>, T2>(&mut arg1.id, key<T1>())
    }

    public fun rules<T0>(arg0: &TokenPolicy<T0>, arg1: &0x1::string::String) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        *0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, arg1)
    }

    public fun share_policy<T0>(arg0: TokenPolicy<T0>) {
        let v0 = TokenPolicyCreated<T0>{
            id         : 0x2::object::id<TokenPolicy<T0>>(&arg0),
            is_mutable : true,
        };
        0x2::event::emit<TokenPolicyCreated<T0>>(v0);
        0x2::transfer::share_object<TokenPolicy<T0>>(arg0);
    }

    public fun spend<T0>(arg0: Token<T0>, arg1: &mut 0x2::tx_context::TxContext) : ActionRequest<T0> {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : v2,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        new_request<T0>(spend_action(), 0x2::balance::value<T0>(&v3), v2, 0x1::option::none<address>(), 0x1::option::some<0x2::balance::Balance<T0>>(v3), arg1)
    }

    public fun spend_action() : 0x1::string::String {
        0x1::string::utf8(b"spend")
    }

    public fun spent<T0>(arg0: &ActionRequest<T0>) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&arg0.spent_balance)) {
            0x1::option::some<u64>(0x2::balance::value<T0>(0x1::option::borrow<0x2::balance::Balance<T0>>(&arg0.spent_balance)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun spent_balance<T0>(arg0: &TokenPolicy<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.spent_balance)
    }

    public fun to_coin<T0>(arg0: Token<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ActionRequest<T0>) {
        let Token {
            id         : v0,
            balance    : v1,
            expiration : _,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        (0x2::coin::from_balance<T0>(v3, arg1), new_request<T0>(to_coin_action(), 0x2::balance::value<T0>(&v3), 0x1::option::none<u64>(), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
    }

    public fun to_coin_action() : 0x1::string::String {
        0x1::string::utf8(b"to_coin")
    }

    public fun transfer_action() : 0x1::string::String {
        0x1::string::utf8(b"transfer")
    }

    public fun zero_with_expiration<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<T0>(),
            expiration : 0x1::option::some<u64>(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

