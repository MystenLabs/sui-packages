module 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt_cancellation {
    struct ReceiptCanBeCancelledFieldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReceiptCanBeCancelled has store {
        can_be_cancelled: bool,
    }

    struct VaultReceiptCanBeCancelled has store {
        receipt_can_be_cancelled: 0x2::table::Table<address, bool>,
    }

    public fun add_dynamic_field_to_receipt(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt) {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        let v1 = ReceiptCanBeCancelled{can_be_cancelled: true};
        0x2::dynamic_field::add<ReceiptCanBeCancelledFieldKey, ReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_id_mut(arg0), v0, v1);
    }

    public(friend) fun add_dynamic_field_to_vault<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultReceiptCanBeCancelled{receipt_can_be_cancelled: 0x2::table::new<address, bool>(arg1)};
        let v1 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        0x2::dynamic_field::add<ReceiptCanBeCancelledFieldKey, VaultReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id_mut<T0>(arg0), v1, v0);
    }

    public fun assert_receipt_can_be_cancelled(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt) {
        assert!(receipt_can_be_cancelled(arg0), 6002);
    }

    public fun assert_receipt_can_be_cancelled_from_vault<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: address) {
        assert!(vault_receipt_info_can_be_cancelled<T0>(arg0, arg1), 6002);
    }

    public fun assert_receipt_can_not_be_cancelled(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt) {
        assert!(!receipt_can_be_cancelled(arg0), 6001);
    }

    public fun assert_receipt_can_not_be_cancelled_from_vault<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: address) {
        assert!(!vault_receipt_info_can_be_cancelled<T0>(arg0, arg1), 6001);
    }

    public fun receipt_can_be_cancelled(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt) : bool {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        let v1 = true;
        if (0x2::dynamic_field::exists_<ReceiptCanBeCancelledFieldKey>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_uid(arg0), v0)) {
            v1 = 0x2::dynamic_field::borrow<ReceiptCanBeCancelledFieldKey, ReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_uid(arg0), v0).can_be_cancelled;
        };
        v1
    }

    public fun set_receipt_can_be_cancelled<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt, arg1: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ReceiptCanBeCancelledFieldKey, ReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_id_mut(arg0), v0).can_be_cancelled = true;
        set_vault_receipt_info_can_be_cancelled<T0>(arg1, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_id(arg0), true);
    }

    public fun set_receipt_can_not_be_cancelled<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::Receipt, arg1: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ReceiptCanBeCancelledFieldKey, ReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_id_mut(arg0), v0).can_be_cancelled = false;
        set_vault_receipt_info_can_be_cancelled<T0>(arg1, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::receipt::receipt_id(arg0), false);
    }

    public(friend) fun set_vault_receipt_info_can_be_cancelled<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: address, arg2: bool) {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ReceiptCanBeCancelledFieldKey, VaultReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id_mut<T0>(arg0), v0);
        if (!0x2::table::contains<address, bool>(&v1.receipt_can_be_cancelled, arg1)) {
            0x2::table::add<address, bool>(&mut v1.receipt_can_be_cancelled, arg1, false);
        };
        *0x2::table::borrow_mut<address, bool>(&mut v1.receipt_can_be_cancelled, arg1) = arg2;
    }

    public fun vault_receipt_info_can_be_cancelled<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: address) : bool {
        let v0 = ReceiptCanBeCancelledFieldKey{dummy_field: false};
        let v1 = true;
        if (0x2::dynamic_field::exists_<ReceiptCanBeCancelledFieldKey>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_uid<T0>(arg0), v0)) {
            let v2 = 0x2::dynamic_field::borrow<ReceiptCanBeCancelledFieldKey, VaultReceiptCanBeCancelled>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_uid<T0>(arg0), v0);
            if (0x2::table::contains<address, bool>(&v2.receipt_can_be_cancelled, arg1)) {
                v1 = *0x2::table::borrow<address, bool>(&v2.receipt_can_be_cancelled, arg1);
            } else {
                v1 = true;
            };
        };
        v1
    }

    // decompiled from Move bytecode v6
}

