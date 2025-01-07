module 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::generic_policy {
    struct GENERIC_POLICY has drop {
        dummy_field: bool,
    }

    struct PayRule has drop {
        dummy_field: bool,
    }

    struct PayRuleConfig has drop, store {
        vaule: u16,
    }

    fun addPayRule<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicyCap<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = PayRule{dummy_field: false};
        let v1 = PayRuleConfig{vaule: 10};
        0x2::transfer_policy::add_rule<T0, PayRule, PayRuleConfig>(v0, arg1, arg0, v1);
    }

    public fun createPolicy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        addPayRule<T0>(&v2, v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_freeze_object<0x2::transfer_policy::TransferPolicyCap<T0>>(v2);
    }

    fun init(arg0: GENERIC_POLICY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GENERIC_POLICY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun pay<T0: store + key, T1>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::public_kiosk::Order, arg2: 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0xf5c20e11b57e508db2d942575c756a5fe4af759da74d02f53ae754e72ded3dd7::public_kiosk::orderInfo(arg1);
        assert!(v0 == 0x2::transfer_policy::item<T0>(arg0), 1002);
        assert!(v2 <= 0x2::coin::value<T1>(&arg2), 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
        let v3 = PayRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, PayRule>(v3, arg0);
    }

    // decompiled from Move bytecode v6
}

