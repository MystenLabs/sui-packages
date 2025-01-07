module 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::payment_policy {
    struct PAYMENT_POLICY has drop {
        dummy_field: bool,
    }

    struct PayRule has drop {
        dummy_field: bool,
    }

    struct RuleConfig has drop, store {
        vaule: u64,
        owner: address,
    }

    fun addPayRule<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicyCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = PayRule{dummy_field: false};
        let v1 = RuleConfig{
            vaule : 100,
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer_policy::add_rule<T0, PayRule, RuleConfig>(v0, arg1, arg0, v1);
    }

    public fun createPolicy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::version::Version, arg2: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::version::checkVersion(arg1, 1);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        addPayRule<T0>(&v2, v4, arg2);
        (v3, v2)
    }

    fun init(arg0: PAYMENT_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun payByCoin<T0: store + key, T1>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::public_kiosk::POrder, arg2: &mut 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1, v2, v3) = 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::public_kiosk::orderInfo(arg1);
        assert!(v1 == 0x2::transfer_policy::item<T0>(arg0), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg2), 4001);
        let v4 = if (v3 == 0) {
            0x2::balance::value<T1>(arg2)
        } else {
            v3
        };
        let v5 = 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::math::div(0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::math::mul(v4, arg3), 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::constants::max_fee());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg2, v4 - v5), arg4), v2);
        let v6 = PayRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PayRule>(v6, arg0);
        0x2::balance::split<T1>(arg2, v5)
    }

    public fun payByToken<T0: store + key, T1>(arg0: &mut 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::xbird::PegVault<T1>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::public_kiosk::POrder, arg3: &mut 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1, v2, v3) = 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::public_kiosk::orderInfo(arg2);
        assert!(v1 == 0x2::transfer_policy::item<T0>(arg1), 4002);
        assert!(v3 == 0 || v3 <= 0x2::balance::value<T1>(arg3), 4001);
        let v4 = if (v3 == 0) {
            0x2::balance::value<T1>(arg3)
        } else {
            v3
        };
        let v5 = 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::math::div(0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::math::mul(v4, arg4), 0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::constants::max_fee());
        let (v6, v7) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v4 - v5), arg5), arg5);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T1>(0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::xbird::treasureMut<T1>(arg0), v7, arg5);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T1>(0x49fcb8d8bb0292f1e1275d46e50e68ebc198169af3cda6ef382af83efb2e7f75::xbird::treasureMut<T1>(arg0), 0x2::token::transfer<T1>(v6, v2, arg5), arg5);
        let v16 = PayRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PayRule>(v16, arg1);
        0x2::balance::split<T1>(arg3, v5)
    }

    // decompiled from Move bytecode v6
}

