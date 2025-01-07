module 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::payment_policy {
    struct PAYMENT_POLICY has drop {
        dummy_field: bool,
    }

    struct PayRule has drop {
        dummy_field: bool,
    }

    struct RuleConfig has drop, store {
        vaule: u16,
    }

    fun addPayRule<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicyCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = PayRule{dummy_field: false};
        let v1 = RuleConfig{vaule: 0};
        0x2::transfer_policy::add_rule<T0, PayRule, RuleConfig>(v0, arg1, arg0, v1);
    }

    public fun createPolicy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::version::checkVersion(arg1, 1);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        addPayRule<T0>(&v2, v4);
        let v5 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicy<T0>>(v3, v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, v5);
    }

    fun init(arg0: PAYMENT_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun payByCoin<T0: store + key, T1>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::Order, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::orderInfo(arg1);
        assert!(v1 == 0x2::transfer_policy::item<T0>(arg0), 4002);
        assert!(v3 == 0 || v3 <= 0x2::coin::value<T1>(arg2), 4001);
        let v4 = if (v3 == 0) {
            0x2::coin::value<T1>(arg2)
        } else {
            v3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg2, v4, arg3), v2);
        let v5 = PayRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PayRule>(v5, arg0);
    }

    public fun payByToken<T0: store + key, T1>(arg0: &mut 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::BirdPegVault<T1>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::Order, arg3: &mut 0x2::token::Token<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3) = 0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::public_kiosk::orderInfo(arg2);
        assert!(v1 == 0x2::transfer_policy::item<T0>(arg1), 4002);
        assert!(v3 == 0 || v3 <= 0x2::token::value<T1>(arg3), 4001);
        let v4 = if (v3 == 0) {
            0x2::token::value<T1>(arg3)
        } else {
            v3
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T1>(0xb6da6f7306ac1fb6c0679114a5ce6db3f0d9e767a1f9d81b4c6b43eb67938e4::xbird::borrowMutTreasure<T1>(arg0), 0x2::token::transfer<T1>(0x2::token::split<T1>(arg3, v4, arg4), v2, arg4), arg4);
        let v9 = PayRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PayRule>(v9, arg1);
    }

    // decompiled from Move bytecode v6
}

