module 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::payment_policy {
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
        assert!(arg2 <= 1000 && arg3 <= 2000, 4003);
        let v0 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, TradeRule, u64>(v0, arg1, arg0, arg3);
        let v1 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyalRule, u64>(v1, arg1, arg0, arg2);
    }

    public fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::version::Version, arg4: &mut 0x2::tx_context::TxContext) : PolicyVaultCap {
        0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::version::checkVersion(arg3, 1);
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
        0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::cap_vault::createVault<PolicyVaultCap>(arg4);
        v6
    }

    fun init(arg0: PAYMENT_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun payByClt<T0: store + key, T1>(arg0: &mut 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::clt::CltVault<T1>, arg1: &mut PolicyVault<T0>, arg2: 0x2::transfer_policy::TransferRequest<T0>, arg3: &0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::public_kiosk::KOrder, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, u64, u64) {
        let (_, v1, v2, v3) = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::public_kiosk::orderInfo(arg3);
        assert!(v1 == 0x2::transfer_policy::item<T0>(&arg2), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg4), 4001);
        let v4 = TradeRule{dummy_field: false};
        let v5 = RoyalRule{dummy_field: false};
        let v6 = 0x2::transfer_policy::get_rule<T0, RoyalRule, u64>(v5, &arg1.policy);
        assert!(arg5 <= *0x2::transfer_policy::get_rule<T0, TradeRule, u64>(v4, &arg1.policy), 4003);
        let v7 = if (v3 == 0) {
            0x2::balance::value<T1>(arg4)
        } else {
            v3
        };
        let v8 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::constants::max_fee();
        let v9 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::div(0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::mul(v7, arg5), v8);
        let v10 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::div(0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::mul(v7, *v6), v8);
        0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::clt::withdrawTo<T1>(0x2::balance::split<T1>(arg4, v7 - v9 - v10), v2, arg0, arg6);
        addRoyalFee<T0, T1>(arg1, 0x2::balance::split<T1>(arg4, v10));
        let v11 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TradeRule>(v11, &mut arg2);
        let v12 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyalRule>(v12, &mut arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg1.policy, arg2);
        (0x2::balance::split<T1>(arg4, v9), v9, v10)
    }

    public(friend) fun payByCoin<T0: store + key, T1>(arg0: &mut PolicyVault<T0>, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::public_kiosk::KOrder, arg3: &mut 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, u64, u64) {
        let (_, v1, v2, v3) = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::public_kiosk::orderInfo(arg2);
        assert!(v1 == 0x2::transfer_policy::item<T0>(&arg1), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg3), 4001);
        let v4 = TradeRule{dummy_field: false};
        let v5 = RoyalRule{dummy_field: false};
        let v6 = 0x2::transfer_policy::get_rule<T0, RoyalRule, u64>(v5, &arg0.policy);
        assert!(arg4 <= *0x2::transfer_policy::get_rule<T0, TradeRule, u64>(v4, &arg0.policy), 4003);
        let v7 = if (v3 == 0) {
            0x2::balance::value<T1>(arg3)
        } else {
            v3
        };
        let v8 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::constants::max_fee();
        let v9 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::div(0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::mul(v7, arg4), v8);
        let v10 = 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::div(0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::math::mul(v7, *v6), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v7 - v9 - v10), arg5), v2);
        addRoyalFee<T0, T1>(arg0, 0x2::balance::split<T1>(arg3, v10));
        let v11 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TradeRule>(v11, &mut arg1);
        let v12 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyalRule>(v12, &mut arg1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg0.policy, arg1);
        (0x2::balance::split<T1>(arg3, v9), v9, v10)
    }

    fun withdrawRoyalFee<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>) : 0x2::balance::Balance<T1> {
        assert!(arg0.policy_id == 0x2::object::id<PolicyVault<T0>>(arg1), 4004);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut arg1.policy, &arg1.policyCap), 0x1::type_name::get<0x2::balance::Balance<T1>>());
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    public fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(withdrawRoyalFee<T0, T1>(arg0, arg1), arg2)
    }

    public fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>, arg2: &mut 0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x21c6cfb24d3900a514624754ebbac35498408795c3b47507ddfbc6ac0399d0fe::clt::withdrawTo<T1>(withdrawRoyalFee<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg3), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

