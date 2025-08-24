module 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::ticket {
    struct AuthorizedTransferTicket {
        issued_to: 0x2::object::ID,
        issuer: 0x2::object::ID,
        assets: 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::AssetStore,
        account_id: 0x2::object::ID,
        policies: vector<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>,
        strategy_name: 0x1::string::String,
        last_policy_consumed: 0x1::option::Option<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>,
    }

    public fun asset_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::asset_balance<T0>(&arg0.assets, 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::create_asset_key<T0>())
    }

    public fun has_any_assets(arg0: &AuthorizedTransferTicket) : bool {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::has_any_assets(&arg0.assets)
    }

    public fun has_any_rewards(arg0: &AuthorizedTransferTicket) : bool {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::has_any_rewards(&arg0.assets)
    }

    public fun reward_balance<T0>(arg0: &AuthorizedTransferTicket) : u64 {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::reward_balance<T0>(&arg0.assets, 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::create_reward_key<T0>())
    }

    public fun withdraw_object<T0: store + key, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: &T2) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg2);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public fun withdraw_reward<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &T2, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg2, arg4)
    }

    public fun add_coin<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::coin::Coin<T0>, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_coin_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit<T0>(&mut arg0.assets, arg2);
    }

    public fun add_object<T0: store + key, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: T0, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit_object<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_object_internal<T0: store + key, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: T0) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit_object<T0>(&mut arg0.assets, arg2);
    }

    public fun add_reward<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::balance::Balance<T0>, arg3: &T2) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun add_reward_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: 0x2::balance::Balance<T0>) {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::deposit_reward_balance<T0>(&mut arg0.assets, arg2);
    }

    public(friend) fun assert_belongs_to_account(arg0: &AuthorizedTransferTicket, arg1: 0x2::object::ID) {
        assert!(arg0.account_id == arg1, 2);
    }

    public fun burn(arg0: AuthorizedTransferTicket) {
        let AuthorizedTransferTicket {
            issued_to            : _,
            issuer               : _,
            assets               : v2,
            account_id           : _,
            policies             : _,
            strategy_name        : _,
            last_policy_consumed : _,
        } = arg0;
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::destroy(v2);
    }

    public fun get_asset_keys(arg0: &AuthorizedTransferTicket) : &vector<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::AssetKey> {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::active_asset_keys(&arg0.assets)
    }

    public(friend) fun get_last_policy_consumed(arg0: &AuthorizedTransferTicket) : 0x1::option::Option<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy> {
        arg0.last_policy_consumed
    }

    public fun get_policies(arg0: &AuthorizedTransferTicket) : &vector<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy> {
        &arg0.policies
    }

    public fun get_reward_keys(arg0: &AuthorizedTransferTicket) : &vector<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::RewardKey> {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::active_reward_keys(&arg0.assets)
    }

    public(friend) fun get_strategy_name(arg0: &AuthorizedTransferTicket) : 0x1::string::String {
        arg0.strategy_name
    }

    public fun has_asset_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::has_asset_key(&arg0.assets, 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::create_asset_key<T0>())
    }

    public fun has_reward_type<T0>(arg0: &AuthorizedTransferTicket) : bool {
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::reward_exists(&arg0.assets, 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::create_reward_key<T0>())
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket {
        AuthorizedTransferTicket{
            issued_to            : arg0,
            issuer               : arg1,
            assets               : 0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::new(arg4),
            account_id           : arg2,
            policies             : 0x1::vector::empty<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>(),
            strategy_name        : arg3,
            last_policy_consumed : 0x1::option::none<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>(),
        }
    }

    public(friend) fun set_last_policy_consumed(arg0: &mut AuthorizedTransferTicket, arg1: 0x1::option::Option<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>) {
        arg0.last_policy_consumed = arg1;
    }

    public(friend) fun set_policies(arg0: &mut AuthorizedTransferTicket, arg1: vector<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>) {
        arg0.policies = arg1;
    }

    public fun verify_adapter_access<T0>(arg0: &AuthorizedTransferTicket, arg1: &T0) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>(&arg0.policies) && !v0) {
            if (0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::is_adapter_type_allowed(0x1::vector::borrow<0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::policy::Policy>(&arg0.policies, v1), 0x1::type_name::get<T0>())) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 1);
    }

    public fun withdraw_coin<T0, T1: key, T2>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &T2, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        verify_adapter_access<T2>(arg0, arg3);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw<T0>(&mut arg0.assets, arg2, arg4)
    }

    public(friend) fun withdraw_coin_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw<T0>(&mut arg0.assets, arg2, arg3)
    }

    public(friend) fun withdraw_object_internal<T0: store + key, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1) : T0 {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw_object<T0>(&mut arg0.assets)
    }

    public(friend) fun withdraw_reward_internal<T0, T1: key>(arg0: &mut AuthorizedTransferTicket, arg1: &T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<T1>(arg1) == arg0.issued_to || 0x2::object::id<T1>(arg1) == arg0.issuer, 0);
        0xc1521400f8201b85aa9e8d7a26aa28ed6b966ff9f5f4644e400cb061e29402ad::asset_store::withdraw_reward<T0>(&mut arg0.assets, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

