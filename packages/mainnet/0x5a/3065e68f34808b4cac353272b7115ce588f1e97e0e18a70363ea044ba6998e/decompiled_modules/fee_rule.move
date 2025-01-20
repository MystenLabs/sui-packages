module 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::fee_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct VaultConfig has drop, store {
        fee_bp: u16,
        min_amount: u64,
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, VaultConfig>(v0, arg0);
        let v2 = (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (v1.fee_bp as u128) / 10000) as u64);
        let v3 = v2;
        if (v2 < v1.min_amount) {
            v3 = v1.min_amount;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 1);
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v4, arg0, arg2);
        let v5 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v5, arg1);
    }

    public fun set_fee<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        if (0x2::transfer_policy::has_rule<T0, Rule>(arg0)) {
            0x2::transfer_policy::remove_rule<T0, Rule, VaultConfig>(arg0, arg1);
        };
        let v0 = Rule{dummy_field: false};
        let v1 = VaultConfig{
            fee_bp     : arg2,
            min_amount : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, VaultConfig>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

