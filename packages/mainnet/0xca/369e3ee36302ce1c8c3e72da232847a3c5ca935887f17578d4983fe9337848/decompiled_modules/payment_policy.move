module 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::payment_policy {
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

    public fun createPolicy<T0: store + key, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::Version, arg4: &mut 0x2::tx_context::TxContext) : PolicyVaultCap {
        0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::version::checkVersion(arg3, 1);
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
        0xaebc18d31d451b6d2c35a335dabfe0fc81814fa2dd741a1254d30b3f693eea6d::cap_vault::createVault<PolicyVaultCap>(arg4);
        v6
    }

    fun init(arg0: PAYMENT_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun payByClt<T0: store + key, T1>(arg0: &mut 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::clt::CltVault<T1>, arg1: &mut PolicyVault<T0>, arg2: 0x2::transfer_policy::TransferRequest<T0>, arg3: &0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::public_kiosk::KOrder, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1, v2, v3) = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::public_kiosk::orderInfo(arg3);
        assert!(v1 == 0x2::transfer_policy::item<T0>(&arg2), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg4), 4001);
        assert!(arg5 <= 2000, 4003);
        let v4 = if (v3 == 0) {
            0x2::balance::value<T1>(arg4)
        } else {
            v3
        };
        let v5 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::constants::max_fee();
        let v6 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::div(0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::mul(v4, arg5), v5);
        let v7 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::div(0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::mul(v4, 1000), v5);
        0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::clt::withdrawTo<T1>(0x2::balance::split<T1>(arg4, v4 - v6 - v7), v2, arg0, arg6);
        addRoyalFee<T0, T1>(arg1, 0x2::balance::split<T1>(arg4, v7));
        let v8 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TradeRule>(v8, &mut arg2);
        let v9 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyalRule>(v9, &mut arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg1.policy, arg2);
        0x2::balance::split<T1>(arg4, v6)
    }

    public(friend) fun payByCoin<T0: store + key, T1>(arg0: &mut PolicyVault<T0>, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: &0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::public_kiosk::KOrder, arg3: &mut 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1, v2, v3) = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::public_kiosk::orderInfo(arg2);
        assert!(v1 == 0x2::transfer_policy::item<T0>(&arg1), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg3), 4001);
        assert!(arg4 <= 2000, 4003);
        let v4 = if (v3 == 0) {
            0x2::balance::value<T1>(arg3)
        } else {
            v3
        };
        let v5 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::constants::max_fee();
        let v6 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::div(0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::mul(v4, arg4), v5);
        let v7 = 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::div(0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::math::mul(v4, 1000), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v4 - v6 - v7), arg5), v2);
        addRoyalFee<T0, T1>(arg0, 0x2::balance::split<T1>(arg3, v7));
        let v8 = TradeRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TradeRule>(v8, &mut arg1);
        let v9 = RoyalRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyalRule>(v9, &mut arg1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg0.policy, arg1);
        0x2::balance::split<T1>(arg3, v6)
    }

    fun withdrawRoyalFee<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>) : 0x2::balance::Balance<T1> {
        assert!(arg0.policy_id == 0x2::object::id<PolicyVault<T0>>(arg1), 4004);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::transfer_policy::uid_mut_as_owner<T0>(&mut arg1.policy, &arg1.policyCap), 0x1::type_name::get<0x2::balance::Balance<T1>>());
        0x2::balance::split<T1>(v0, 0x2::balance::value<T1>(v0))
    }

    public fun withdrawRoyalFeeCoin<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(withdrawRoyalFee<T0, T1>(arg0, arg1), arg2)
    }

    public fun withdrawRoyalFeeToken<T0: store + key, T1>(arg0: &PolicyVaultCap, arg1: &mut PolicyVault<T0>, arg2: &mut 0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::clt::CltVault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xca369e3ee36302ce1c8c3e72da232847a3c5ca935887f17578d4983fe9337848::clt::withdrawTo<T1>(withdrawRoyalFee<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg3), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

