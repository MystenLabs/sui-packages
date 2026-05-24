module 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::seal_policy {
    fun policy_matches(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow::PurchaseReceipt, arg2: &0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::DatasetRegistry, arg3: u64) {
        let v0 = 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::registry::seal_policy_id(arg2, arg3);
        assert!(policy_matches(&arg0, &v0), 77);
        assert!(0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow::receipt_dataset_id(arg1) == arg3, 77);
        let v1 = 0x4e61ac9692e3bd6dc69cca3d3e8a3efe8b9f46fcef9f5aaeae9d09b9ea1424ef::escrow::receipt_seal_policy_id(arg1);
        assert!(policy_matches(&arg0, &v1), 77);
    }

    // decompiled from Move bytecode v7
}

