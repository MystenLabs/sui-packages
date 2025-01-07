module 0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_rule {
    struct WithdrawRule has drop {
        dummy_field: bool,
    }

    struct WithdrawConfig has drop, store {
        warehouse_id: 0x2::object::ID,
    }

    struct DepositRule has drop {
        dummy_field: bool,
    }

    struct DepositConfig has drop, store {
        warehouse_id: 0x2::object::ID,
    }

    public entry fun add_deposit<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>) {
        let v0 = DepositRule{dummy_field: false};
        let v1 = DepositConfig{warehouse_id: 0x2::object::id<0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>>(arg2)};
        0x2::transfer_policy::add_rule<T0, DepositRule, DepositConfig>(v0, arg0, arg1, v1);
    }

    public entry fun add_withdraw<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>) {
        let v0 = WithdrawRule{dummy_field: false};
        let v1 = WithdrawConfig{warehouse_id: 0x2::object::id<0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>>(arg2)};
        0x2::transfer_policy::add_rule<T0, WithdrawRule, WithdrawConfig>(v0, arg0, arg1, v1);
    }

    public fun prove_deposit<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>, arg3: T0) {
        0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::deposit<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse::Warehouse<T0>>(arg2);
        assert!(0x2::transfer_policy::from<T0>(arg1) == v0, 0);
        let v1 = DepositRule{dummy_field: false};
        assert!(v0 == 0x2::transfer_policy::get_rule<T0, DepositRule, DepositConfig>(v1, arg0).warehouse_id, 1);
        let v2 = DepositRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, DepositRule>(v2, arg1);
    }

    public fun prove_withdraw<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = WithdrawRule{dummy_field: false};
        assert!(0x2::transfer_policy::from<T0>(arg1) == 0x2::transfer_policy::get_rule<T0, WithdrawRule, WithdrawConfig>(v0, arg0).warehouse_id, 1);
        let v1 = WithdrawRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, WithdrawRule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

