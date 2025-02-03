module 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::payment_policy {
    struct PAYMENT_POLICY has drop {
        dummy_field: bool,
    }

    struct TradeRule has drop {
        dummy_field: bool,
    }

    struct RoyalRule has drop {
        dummy_field: bool,
    }

    struct PolicyVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        policy: 0x2::transfer_policy::TransferPolicy<T0>,
        policyCap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    struct PolicyVaultCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    fun addRoyalFee<T0, T1>(arg0: &mut PolicyVault<T0>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut arg0.policy, &arg0.policyCap), 0x1::type_name::get<0x2::balance::Balance<T1>>()), arg1);
    }

    fun addRules<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicyCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000 && arg3 <= 2000, 4002);
        let v0 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, TradeRule, u64>(v0, arg1, arg0, arg3);
        let v1 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyalRule, u64>(v1, arg1, arg0, arg2);
    }

    public fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::Version, arg4: &mut 0x2::tx_context::TxContext) : PolicyVaultCap {
        0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::version::checkVersion(arg3, 1);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut v3, &v2), 0x1::type_name::get<0x2::balance::Balance<T1>>(), 0x2::balance::zero<T1>());
        let v4 = &mut v3;
        addRules<T0>(&v2, v4, arg1, arg2);
        let v5 = PolicyVault<T0>{
            id        : 0x2::object::new(arg4),
            policy    : v3,
            policyCap : v2,
        };
        0x2::transfer::public_share_object<PolicyVault<T0>>(v5);
        let v6 = PolicyVaultCap{
            id        : 0x2::object::new(arg4),
            policy_id : 0x2::object::id<PolicyVault<T0>>(&v5),
        };
        0x9d14583975011145cd0b75a85bd4c44d375d8b39f99c3bdc4a9190a34f84853c::cap_vault::createVault<PolicyVaultCap>(arg4);
        v6
    }

    fun init(arg0: PAYMENT_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun payByCoin<T0: store + key, T1>(arg0: &mut PolicyVault<T0>, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, u64, u64) {
        assert!(arg2 == 0 || arg2 <= 0x2::balance::value<T1>(arg4), 4001);
        let v0 = TradeRule{dummy_field: false};
        let v1 = RoyalRule{dummy_field: false};
        let v2 = 0x2::transfer_policy::get_rule<T0, RoyalRule, u64>(v1, &arg0.policy);
        assert!(arg5 <= *0x2::transfer_policy::get_rule<T0, TradeRule, u64>(v0, &arg0.policy), 4002);
        let v3 = if (arg2 == 0) {
            0x2::balance::value<T1>(arg4)
        } else {
            arg2
        };
        let v4 = 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::constants::max_fee();
        let v5 = 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::math::div(0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::math::mul(v3, arg5), v4);
        let v6 = 0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::math::div(0x247bfe5827672e2f31510ae86b77c8879dde40c23bc313315d3b85aaade9f0c7::math::mul(v3, *v2), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg4, v3 - v5 - v6), arg6), arg3);
        addRoyalFee<T0, T1>(arg0, 0x2::balance::split<T1>(arg4, v6));
        let v7 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TradeRule>(v7, &mut arg1);
        let v8 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyalRule>(v8, &mut arg1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg0.policy, arg1);
        (0x2::balance::split<T1>(arg4, v5), v5, v6)
    }

    fun withdrawRoyalFee<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>) : 0x2::balance::Balance<T1> {
        assert!(arg0.policy_id == 0x2::object::id<PolicyVault<T0>>(arg1), 4003);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut arg1.policy, &arg1.policyCap), 0x1::type_name::get<0x2::balance::Balance<T1>>());
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    public fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(withdrawRoyalFee<T0, T1>(arg0, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

