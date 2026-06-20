module 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::policy {
    struct DelegationPolicy has store {
        version: u64,
        auth_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        caveat_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct SpendRequest {
        wallet_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        policy_version: u64,
        auth_receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        caveat_receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PolicyInitialized has copy, drop {
        wallet_id: 0x2::object::ID,
        version: u64,
    }

    struct AuthRuleChanged has copy, drop {
        wallet_id: 0x2::object::ID,
        rule: 0x1::type_name::TypeName,
        added: bool,
    }

    struct CaveatRuleChanged has copy, drop {
        wallet_id: 0x2::object::ID,
        rule: 0x1::type_name::TypeName,
        added: bool,
    }

    struct PolicyRevoked has copy, drop {
        wallet_id: 0x2::object::ID,
        new_version: u64,
    }

    struct SpendConfirmed has copy, drop {
        wallet_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        policy_version: u64,
    }

    fun borrow(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : &DelegationPolicy {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid(arg0);
        assert!(0x2::dynamic_field::exists<vector<u8>>(v0, b"delegation_policy"), 1);
        0x2::dynamic_field::borrow<vector<u8>, DelegationPolicy>(v0, b"delegation_policy")
    }

    fun borrow_mut(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : &mut DelegationPolicy {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid_mut(arg0);
        assert!(0x2::dynamic_field::exists<vector<u8>>(v0, b"delegation_policy"), 1);
        0x2::dynamic_field::borrow_mut<vector<u8>, DelegationPolicy>(v0, b"delegation_policy")
    }

    public fun add_auth_receipt<T0: drop>(arg0: T0, arg1: &mut SpendRequest) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.auth_receipts, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.auth_receipts, v0);
        };
    }

    public fun add_auth_rule<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.auth_rules, &v1)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2.auth_rules, v1);
        };
        let v3 = AuthRuleChanged{
            wallet_id : v0,
            rule      : v1,
            added     : true,
        };
        0x2::event::emit<AuthRuleChanged>(v3);
    }

    public fun add_caveat_receipt<T0: drop>(arg0: T0, arg1: &mut SpendRequest) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.caveat_receipts, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.caveat_receipts, v0);
        };
    }

    public fun add_caveat_rule<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.caveat_rules, &v1)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2.caveat_rules, v1);
        };
        let v3 = CaveatRuleChanged{
            wallet_id : v0,
            rule      : v1,
            added     : true,
        };
        0x2::event::emit<CaveatRuleChanged>(v3);
    }

    fun all_present(arg0: &0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) : bool {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun any_present(arg0: &0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) : bool {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1))) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun auth_rule_count(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&borrow(arg0).auth_rules)
    }

    public fun begin_spend<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: address) : SpendRequest {
        SpendRequest{
            wallet_id       : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            coin            : 0x1::type_name::with_defining_ids<T0>(),
            amount          : arg1,
            recipient       : arg2,
            policy_version  : borrow(arg0).version,
            auth_receipts   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            caveat_receipts : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun caveat_rule_count(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&borrow(arg0).caveat_rules)
    }

    public fun confirm_spend<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: SpendRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(confirm_spend_into<T0>(arg0, arg1, arg2), arg1.recipient);
    }

    public fun confirm_spend_into<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: SpendRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SpendRequest {
            wallet_id       : v0,
            coin            : v1,
            amount          : v2,
            recipient       : v3,
            policy_version  : v4,
            auth_receipts   : v5,
            caveat_receipts : v6,
        } = arg1;
        let v7 = v6;
        let v8 = v5;
        assert!(v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0), 6);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 7);
        let v9 = borrow(arg0);
        assert!(v4 == v9.version, 5);
        assert!(any_present(&v9.auth_rules, &v8), 3);
        assert!(all_present(&v9.caveat_rules, &v7), 4);
        let v10 = SpendConfirmed{
            wallet_id      : v0,
            coin           : v1,
            amount         : v2,
            recipient      : v3,
            policy_version : v4,
        };
        0x2::event::emit<SpendConfirmed>(v10);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_policy<T0>(arg0, v2, arg2)
    }

    public fun has_auth_receipt<T0>(arg0: &SpendRequest) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.auth_receipts, &v0)
    }

    public fun has_auth_rule<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&borrow(arg0).auth_rules, &v0)
    }

    public fun has_caveat_receipt<T0>(arg0: &SpendRequest) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.caveat_receipts, &v0)
    }

    public fun has_caveat_rule<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&borrow(arg0).caveat_rules, &v0)
    }

    public fun initialize(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists<vector<u8>>(v0, b"delegation_policy"), 2);
        let v1 = DelegationPolicy{
            version      : 1,
            auth_rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            caveat_rules : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<vector<u8>, DelegationPolicy>(v0, b"delegation_policy", v1);
        let v2 = PolicyInitialized{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            version   : 1,
        };
        0x2::event::emit<PolicyInitialized>(v2);
    }

    public fun is_initialized(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : bool {
        0x2::dynamic_field::exists<vector<u8>>(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::uid(arg0), b"delegation_policy")
    }

    public fun remove_auth_rule<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.auth_rules, &v1)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v2.auth_rules, &v1);
        };
        let v3 = AuthRuleChanged{
            wallet_id : v0,
            rule      : v1,
            added     : false,
        };
        0x2::event::emit<AuthRuleChanged>(v3);
    }

    public fun remove_caveat_rule<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_mut(arg0);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.caveat_rules, &v1)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v2.caveat_rules, &v1);
        };
        let v3 = CaveatRuleChanged{
            wallet_id : v0,
            rule      : v1,
            added     : false,
        };
        0x2::event::emit<CaveatRuleChanged>(v3);
    }

    public fun revoke_all(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::tx_context::TxContext) {
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::assert_owner(arg0, arg1);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = borrow_mut(arg0);
        v1.version = v1.version + 1;
        let v2 = PolicyRevoked{
            wallet_id   : v0,
            new_version : v1.version,
        };
        0x2::event::emit<PolicyRevoked>(v2);
    }

    public fun spend_amount(arg0: &SpendRequest) : u64 {
        arg0.amount
    }

    public fun spend_coin(arg0: &SpendRequest) : 0x1::type_name::TypeName {
        arg0.coin
    }

    public fun spend_policy_version(arg0: &SpendRequest) : u64 {
        arg0.policy_version
    }

    public fun spend_recipient(arg0: &SpendRequest) : address {
        arg0.recipient
    }

    public fun spend_wallet_id(arg0: &SpendRequest) : 0x2::object::ID {
        arg0.wallet_id
    }

    public fun version(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet) : u64 {
        borrow(arg0).version
    }

    // decompiled from Move bytecode v7
}

