module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet {
    struct AgentWallet<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        cap_id: 0x2::object::ID,
        budget: 0x2::balance::Balance<T0>,
        spent: u64,
        expires_at_ms: u64,
        revoked: bool,
        policy: SpendPolicy,
    }

    struct SpendPolicy has store {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RuleKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        wallet: 0x2::object::ID,
    }

    struct SpendRequest {
        wallet: 0x2::object::ID,
        amount: u64,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct WalletCreated has copy, drop {
        wallet: 0x2::object::ID,
        owner: address,
        agent: address,
        budget: u64,
        expires_at_ms: u64,
    }

    struct Spent has copy, drop {
        wallet: 0x2::object::ID,
        amount: u64,
        spent_total: u64,
        remaining: u64,
    }

    struct ToppedUp has copy, drop {
        wallet: 0x2::object::ID,
        amount: u64,
        remaining: u64,
    }

    struct Revoked has copy, drop {
        wallet: 0x2::object::ID,
        reclaimed: u64,
    }

    struct AgentRotated has copy, drop {
        wallet: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
        old_cap: 0x2::object::ID,
        new_cap: 0x2::object::ID,
    }

    struct ConfigChanged has copy, drop {
        wallet: 0x2::object::ID,
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
    }

    struct RuleAdded has copy, drop {
        wallet: 0x2::object::ID,
        rule: 0x1::type_name::TypeName,
    }

    struct RuleRemoved has copy, drop {
        wallet: 0x2::object::ID,
        rule: 0x1::type_name::TypeName,
    }

    public fun add_receipt<T0, T1: drop>(arg0: T1, arg1: &AgentWallet<T0>, arg2: &mut SpendRequest) {
        assert!(0x2::object::id<AgentWallet<T0>>(arg1) == arg2.wallet, 9);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg2.receipts, 0x1::type_name::with_defining_ids<T1>());
    }

    public fun add_rule<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &mut AgentWallet<T0>, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: T2, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.policy.rules, &v0), 11);
        let v1 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T1>, T2>(&mut arg1.policy.id, v1, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.policy.rules, v0);
        let v2 = RuleAdded{
            wallet : 0x2::object::id<AgentWallet<T0>>(arg1),
            rule   : v0,
        };
        0x2::event::emit<RuleAdded>(v2);
    }

    public fun agent<T0>(arg0: &AgentWallet<T0>) : address {
        arg0.agent
    }

    public fun cap_id<T0>(arg0: &AgentWallet<T0>) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun confirm_spend<T0>(arg0: &mut AgentWallet<T0>, arg1: SpendRequest, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        let SpendRequest {
            wallet   : v0,
            amount   : v1,
            receipts : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<AgentWallet<T0>>(arg0), 9);
        assert!(!arg0.revoked, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at_ms, 3);
        let v3 = &arg0.policy.rules;
        assert!(!0x2::vec_set::is_empty<0x1::type_name::TypeName>(v3), 10);
        let v4 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v2);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v4) == 0x2::vec_set::length<0x1::type_name::TypeName>(v3), 10);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v4)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v3, &v5), 10);
        };
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.budget), 4);
        arg0.spent = arg0.spent + v1;
        let v6 = Spent{
            wallet      : 0x2::object::id<AgentWallet<T0>>(arg0),
            amount      : v1,
            spent_total : arg0.spent,
            remaining   : 0x2::balance::value<T0>(&arg0.budget),
        };
        0x2::event::emit<Spent>(v6);
        0x2::coin::take<T0>(&mut arg0.budget, v1, arg4)
    }

    public fun create_wallet<T0>(arg0: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = AgentCap{
            id     : 0x2::object::new(arg4),
            wallet : v3,
        };
        let v5 = SpendPolicy{
            id    : 0x2::object::new(arg4),
            rules : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v6 = AgentWallet<T0>{
            id            : v2,
            owner         : v0,
            agent         : arg2,
            cap_id        : 0x2::object::id<AgentCap>(&v4),
            budget        : v1,
            spent         : 0,
            expires_at_ms : arg3,
            revoked       : false,
            policy        : v5,
        };
        let v7 = WalletCreated{
            wallet        : v3,
            owner         : v0,
            agent         : arg2,
            budget        : 0x2::balance::value<T0>(&v1),
            expires_at_ms : arg3,
        };
        0x2::event::emit<WalletCreated>(v7);
        0x2::transfer::transfer<AgentCap>(v4, arg2);
        0x2::transfer::share_object<AgentWallet<T0>>(v6);
    }

    public fun expires_at_ms<T0>(arg0: &AgentWallet<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun extend_expiry<T0>(arg0: &mut AgentWallet<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 > arg0.expires_at_ms, 8);
        arg0.expires_at_ms = arg1;
        let v0 = ConfigChanged{
            wallet    : 0x2::object::id<AgentWallet<T0>>(arg0),
            field     : b"expires_at_ms",
            old_value : arg0.expires_at_ms,
            new_value : arg1,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun has_rule<T0, T1: drop>(arg0: &AgentWallet<T0>) : bool {
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists<RuleKey<T1>>(&arg0.policy.id, v0)
    }

    public fun is_active<T0>(arg0: &AgentWallet<T0>, arg1: &0x2::clock::Clock) : bool {
        !arg0.revoked && 0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms
    }

    public fun owner<T0>(arg0: &AgentWallet<T0>) : address {
        arg0.owner
    }

    public fun policy_rules<T0>(arg0: &AgentWallet<T0>) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.policy.rules)
    }

    public fun remaining<T0>(arg0: &AgentWallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.budget)
    }

    public fun remove_rule<T0, T1: drop, T2: drop + store>(arg0: &mut AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T1>, T2>(&mut arg0.policy.id, v1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.policy.rules, &v0);
        let v2 = RuleRemoved{
            wallet : 0x2::object::id<AgentWallet<T0>>(arg0),
            rule   : v0,
        };
        0x2::event::emit<RuleRemoved>(v2);
    }

    public fun request_amount(arg0: &SpendRequest) : u64 {
        arg0.amount
    }

    public fun request_spend<T0>(arg0: &AgentWallet<T0>, arg1: &AgentCap, arg2: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : SpendRequest {
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::check_is_valid(arg2);
        assert!(arg1.wallet == 0x2::object::id<AgentWallet<T0>>(arg0), 5);
        assert!(0x2::object::id<AgentCap>(arg1) == arg0.cap_id, 5);
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 7);
        assert!(!arg0.revoked, 2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at_ms, 3);
        assert!(arg3 > 0, 6);
        assert!(arg3 <= 0x2::balance::value<T0>(&arg0.budget), 4);
        SpendRequest{
            wallet   : 0x2::object::id<AgentWallet<T0>>(arg0),
            amount   : arg3,
            receipts : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun request_wallet(arg0: &SpendRequest) : 0x2::object::ID {
        arg0.wallet
    }

    public fun revoke<T0>(arg0: &mut AgentWallet<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.revoked = true;
        let v0 = 0x2::balance::value<T0>(&arg0.budget);
        let v1 = Revoked{
            wallet    : 0x2::object::id<AgentWallet<T0>>(arg0),
            reclaimed : v0,
        };
        0x2::event::emit<Revoked>(v1);
        0x2::coin::take<T0>(&mut arg0.budget, v0, arg1)
    }

    public fun rotate_agent<T0>(arg0: &mut AgentWallet<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = AgentCap{
            id     : 0x2::object::new(arg2),
            wallet : 0x2::object::id<AgentWallet<T0>>(arg0),
        };
        let v1 = 0x2::object::id<AgentCap>(&v0);
        arg0.agent = arg1;
        arg0.cap_id = v1;
        let v2 = AgentRotated{
            wallet    : 0x2::object::id<AgentWallet<T0>>(arg0),
            old_agent : arg0.agent,
            new_agent : arg1,
            old_cap   : arg0.cap_id,
            new_cap   : v1,
        };
        0x2::event::emit<AgentRotated>(v2);
        0x2::transfer::transfer<AgentCap>(v0, arg1);
    }

    public fun rule_config<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &AgentWallet<T0>) : &T2 {
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T1>, T2>(&arg1.policy.id, v0)
    }

    public fun rule_config_mut<T0, T1: drop, T2: drop + store>(arg0: T1, arg1: &mut AgentWallet<T0>) : &mut T2 {
        let v0 = RuleKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RuleKey<T1>, T2>(&mut arg1.policy.id, v0)
    }

    public fun spent<T0>(arg0: &AgentWallet<T0>) : u64 {
        arg0.spent
    }

    public fun top_up<T0>(arg0: &mut AgentWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::balance::join<T0>(&mut arg0.budget, 0x2::coin::into_balance<T0>(arg1));
        let v0 = ToppedUp{
            wallet    : 0x2::object::id<AgentWallet<T0>>(arg0),
            amount    : 0x2::coin::value<T0>(&arg1),
            remaining : 0x2::balance::value<T0>(&arg0.budget),
        };
        0x2::event::emit<ToppedUp>(v0);
    }

    // decompiled from Move bytecode v7
}

