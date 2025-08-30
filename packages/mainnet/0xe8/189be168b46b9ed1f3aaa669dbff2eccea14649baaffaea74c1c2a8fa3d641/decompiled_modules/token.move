module 0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token {
    struct MintEvent<phantom T0> has copy, drop, store {
        owner: address,
        amount: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop, store {
        owner: address,
        amount: u64,
    }

    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct PlatformCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatFormPolicy has key {
        id: 0x2::object::UID,
        default_rules: 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    struct PolicyRulesKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        supply: 0x2::balance::Supply<T0>,
        supply_limit: u64,
    }

    struct Token<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ActionRequest<phantom T0> {
        name: 0x1::ascii::String,
        amount: u64,
        sender: address,
        recipient: 0x1::option::Option<address>,
        approvals: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RuleKey<phantom T0> has copy, drop, store {
        is_protected: bool,
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

    public(friend) fun new<T0>(arg0: 0x2::balance::Supply<T0>, arg1: &mut 0x2::tx_context::TxContext) : TokenCap<T0> {
        TokenCap<T0>{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            supply       : arg0,
            supply_limit : 100 * 0x1::u64::pow(10, decimal()),
        }
    }

    public fun transfer<T0>(arg0: Token<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::transfer::transfer<Token<T0>>(arg0, arg1);
        let v1 = BurnEvent<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<BurnEvent<T0>>(v1);
        let v2 = MintEvent<T0>{
            owner  : arg1,
            amount : v0,
        };
        0x2::event::emit<MintEvent<T0>>(v2);
        new_request<T0>(transfer_action(), v0, 0x1::option::some<address>(arg1), arg2)
    }

    public fun sender<T0>(arg0: &ActionRequest<T0>) : address {
        arg0.sender
    }

    public fun action<T0>(arg0: &ActionRequest<T0>) : 0x1::ascii::String {
        arg0.name
    }

    public fun add_approval<T0, T1: drop>(arg0: T1, arg1: &mut ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.approvals, 0x1::type_name::get<T1>());
    }

    public fun add_default_rule_for_action<T0: drop>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String) {
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.default_rules, &arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.default_rules, arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.default_rules, &arg2), 0x1::type_name::get<T0>());
    }

    public fun add_policy<T0>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap) {
        let v0 = PolicyRulesKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<PolicyRulesKey<T0>, 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&mut arg0.id, v0, 0x2::vec_map::empty<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>());
    }

    public fun add_rule_config<T0: drop, T1: store>(arg0: T0, arg1: &mut PlatFormPolicy, arg2: &PlatformCap, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, key<T0>(), arg3);
    }

    public fun add_rule_for_action<T0, T1: drop>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String) {
        let v0 = policy_rules_of_mut<T0>(arg0);
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v0, &arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v0, arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v0, &arg2), 0x1::type_name::get<T1>());
    }

    public fun allow_action<T0>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(policy_rules_of_mut<T0>(arg0), arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
    }

    public fun allow_default_actipn(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.default_rules, arg2, 0x2::vec_set::empty<0x1::type_name::TypeName>());
    }

    public fun amount<T0>(arg0: &ActionRequest<T0>) : u64 {
        arg0.amount
    }

    public fun approvals<T0>(arg0: &ActionRequest<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.approvals
    }

    public fun burn<T0>(arg0: &mut TokenCap<T0>, arg1: Token<T0>, arg2: &0x2::tx_context::TxContext) {
        let Token {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = BurnEvent<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : 0x2::balance::decrease_supply<T0>(supply_mut<T0>(arg0), v1),
        };
        0x2::event::emit<BurnEvent<T0>>(v2);
    }

    public fun confirm_request<T0>(arg0: &PlatFormPolicy, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, u64, address, 0x1::option::Option<address>) {
        let v0 = policy_rules_of<T0>(arg0);
        assert!(0x2::vec_map::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v0, &arg1.name), 0);
        let ActionRequest {
            name      : v1,
            amount    : v2,
            sender    : v3,
            recipient : v4,
            approvals : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v1;
        let v8 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::vec_map::get<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(v0, &v7));
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(&v8)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v6, 0x1::vector::borrow<0x1::type_name::TypeName>(&v8, v9)), 1);
            v9 = v9 + 1;
        };
        (v7, v2, v3, v4)
    }

    public fun confirm_request_mut<T0>(arg0: &mut PlatFormPolicy, arg1: ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, u64, address, 0x1::option::Option<address>) {
        assert!(0x2::vec_map::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(policy_rules_of<T0>(arg0), &arg1.name), 0);
        confirm_request<T0>(arg0, arg1, arg2)
    }

    public fun decimal() : u8 {
        6
    }

    public fun default_rules(arg0: &PlatFormPolicy) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        &arg0.default_rules
    }

    public fun disallow_action<T0>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(policy_rules_of_mut<T0>(arg0), &arg2);
    }

    public fun disallow_default_actipn(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.default_rules, &arg2);
    }

    public fun has_rule_config<T0>(arg0: &PlatFormPolicy) : bool {
        0x2::dynamic_field::exists_<RuleKey<T0>>(&arg0.id, key<T0>())
    }

    public fun has_rule_config_with_type<T0, T1: store>(arg0: &PlatFormPolicy) : bool {
        0x2::dynamic_field::exists_with_type<RuleKey<T0>, T1>(&arg0.id, key<T0>())
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TOKEN>(arg0, arg1);
        let v0 = PlatformCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PlatformCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun keep<T0>(arg0: Token<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Token<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun key<T0>() : RuleKey<T0> {
        RuleKey<T0>{is_protected: true}
    }

    public fun mint<T0>(arg0: &mut TokenCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Token<T0> {
        let v0 = supply_mut<T0>(arg0);
        assert!(0x2::balance::supply_value<T0>(&arg0.supply) <= arg0.supply_limit, 7);
        let v1 = MintEvent<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<MintEvent<T0>>(v1);
        Token<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::increase_supply<T0>(v0, arg1),
        }
    }

    public fun new_request<T0>(arg0: 0x1::ascii::String, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &0x2::tx_context::TxContext) : ActionRequest<T0> {
        ActionRequest<T0>{
            name      : arg0,
            amount    : arg1,
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            approvals : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun owner<T0>(arg0: &TokenCap<T0>) : address {
        arg0.owner
    }

    public fun policy_rules_of<T0>(arg0: &PlatFormPolicy) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        let v0 = PolicyRulesKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<PolicyRulesKey<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<PolicyRulesKey<T0>, 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&arg0.id, v0)
        } else {
            &arg0.default_rules
        }
    }

    fun policy_rules_of_mut<T0>(arg0: &mut PlatFormPolicy) : &mut 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>> {
        let v0 = PolicyRulesKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<PolicyRulesKey<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow_mut<PolicyRulesKey<T0>, 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>>(&mut arg0.id, v0)
        } else {
            &mut arg0.default_rules
        }
    }

    public fun recipient<T0>(arg0: &ActionRequest<T0>) : 0x1::option::Option<address> {
        arg0.recipient
    }

    public fun remove_default_rule_for_action<T0: drop>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.default_rules, &arg2), &v0);
    }

    public fun remove_rule_config<T0, T1: store>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        assert!(has_rule_config_with_type<T0, T1>(arg0), 6);
        0x2::dynamic_field::remove<RuleKey<T0>, T1>(&mut arg0.id, key<T0>())
    }

    public fun remove_rule_for_action<T0, T1: drop>(arg0: &mut PlatFormPolicy, arg1: &PlatformCap, arg2: 0x1::ascii::String) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(policy_rules_of_mut<T0>(arg0), &arg2), 0x1::type_name::get<T1>());
    }

    public fun rule_config<T0: drop, T1: store>(arg0: T0, arg1: &PlatFormPolicy) : &T1 {
        assert!(has_rule_config_with_type<T0, T1>(arg1), 6);
        0x2::dynamic_field::borrow<RuleKey<T0>, T1>(&arg1.id, key<T0>())
    }

    public fun rule_config_mut<T0: drop, T1: store>(arg0: T0, arg1: &mut PlatFormPolicy, arg2: &PlatformCap) : &mut T1 {
        assert!(has_rule_config_with_type<T0, T1>(arg1), 6);
        0x2::dynamic_field::borrow_mut<RuleKey<T0>, T1>(&mut arg1.id, key<T0>())
    }

    public fun spend_action() : 0x1::ascii::String {
        0x1::ascii::string(b"spend")
    }

    public fun supply<T0>(arg0: &TokenCap<T0>) : &0x2::balance::Supply<T0> {
        &arg0.supply
    }

    public fun supply_mut<T0>(arg0: &mut TokenCap<T0>) : &mut 0x2::balance::Supply<T0> {
        &mut arg0.supply
    }

    public fun total_supply<T0>(arg0: &mut TokenCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun transfer_action() : 0x1::ascii::String {
        0x1::ascii::string(b"transfer")
    }

    public fun update_supply_limit<T0>(arg0: &mut TokenCap<T0>, arg1: u64) {
        arg0.supply_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

