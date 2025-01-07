module 0x948181de686aeb24e145d0bccd4327032c621dd30db330f0af0e51a4c5bf3857::token {
    struct Token<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
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
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::balance::value<T0>(&v2) == 0, 4);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun join<T0>(arg0: &mut Token<T0>, arg1: Token<T0>) {
        let Token {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
    }

    public fun split<T0>(arg0: &mut Token<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Token<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 3);
        Token<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
        }
    }

    public fun value<T0>(arg0: &Token<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun transfer<T0>(arg0: Token<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = v0 * 5 / 1000;
        let v2 = v0 - v1;
        let v3 = &mut arg0;
        let v4 = split<T0>(v3, v1, arg2);
        let v5 = &mut arg0;
        let v6 = split<T0>(v5, v2, arg2);
        0x2::transfer::transfer<Token<T0>>(v4, @0xbf9d4bf36b86e74e77a439c1a954c3c96bd2412d2fb1a3197c2cd2bab65b28b);
        0x2::transfer::transfer<Token<T0>>(v6, arg1);
        0x2::transfer::transfer<Token<T0>>(arg0, @0x0);
        new_request<T0>(transfer_action(), v2, 0x1::option::some<address>(arg1), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2)
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
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), v1);
        0x2::object::delete(v0);
    }

    public fun confirm_request<T0>(arg0: &TokenPolicy<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&arg1.spent_balance), 5);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &arg1.name), 0);
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            recipient     : v3,
            spent_balance : v4,
            approvals     : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v0;
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v4);
        let v8 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &v7));
        let v9 = &v8;
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::type_name::TypeName>(v9)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v6, 0x1::vector::borrow<0x1::type_name::TypeName>(v9, v10)), 1);
            v10 = v10 + 1;
        };
        (v7, v1, v2, v3)
    }

    public fun confirm_request_mut<T0>(arg0: &mut TokenPolicy<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.rules, &arg1.name), 0);
        assert!(0x1::option::is_some<0x2::balance::Balance<T0>>(&arg1.spent_balance), 7);
        0x2::balance::join<T0>(&mut arg0.spent_balance, 0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg1.spent_balance));
        confirm_request<T0>(arg0, arg1, arg2)
    }

    public fun confirm_with_policy_cap<T0>(arg0: &TokenPolicyCap<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&arg1.spent_balance), 5);
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            recipient     : v3,
            spent_balance : v4,
            approvals     : _,
        } = arg1;
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v4);
        (v0, v1, v2, v3)
    }

    public fun confirm_with_treasury_cap<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        let ActionRequest {
            name          : v0,
            amount        : v1,
            sender        : v2,
            recipient     : v3,
            spent_balance : v4,
            approvals     : _,
        } = arg1;
        let v6 = v4;
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v6)) {
            0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v6));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v6);
        };
        (v0, v1, v2, v3)
    }

    public fun disallow<T0>(arg0: &mut TokenPolicy<T0>, arg1: &TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<TokenPolicy<T0>>(arg0) == arg1.for, 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.rules, &arg2);
    }

    public fun flush<T0>(arg0: &mut TokenPolicy<T0>, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg1), 0x2::balance::split<T0>(&mut arg0.spent_balance, 0x2::balance::value<T0>(&arg0.spent_balance)))
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (Token<T0>, ActionRequest<T0>) {
        let v0 = Token<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        (v0, new_request<T0>(from_coin_action(), 0x2::coin::value<T0>(&arg0), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
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

    public fun keep<T0>(arg0: Token<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Token<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun key<T0>() : RuleKey<T0> {
        RuleKey<T0>{is_protected: true}
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Token<T0> {
        Token<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(arg0), arg1),
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

    public fun new_request<T0>(arg0: 0x1::string::String, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<0x2::balance::Balance<T0>>, arg4: &0x2::tx_context::TxContext) : ActionRequest<T0> {
        ActionRequest<T0>{
            name          : arg0,
            amount        : arg1,
            sender        : 0x2::tx_context::sender(arg4),
            recipient     : arg2,
            spent_balance : arg3,
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
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        new_request<T0>(spend_action(), 0x2::balance::value<T0>(&v2), 0x1::option::none<address>(), 0x1::option::some<0x2::balance::Balance<T0>>(v2), arg1)
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
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        (0x2::coin::from_balance<T0>(v2, arg1), new_request<T0>(to_coin_action(), 0x2::balance::value<T0>(&v2), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
    }

    public fun to_coin_action() : 0x1::string::String {
        0x1::string::utf8(b"to_coin")
    }

    public fun transfer_action() : 0x1::string::String {
        0x1::string::utf8(b"transfer")
    }

    // decompiled from Move bytecode v6
}

