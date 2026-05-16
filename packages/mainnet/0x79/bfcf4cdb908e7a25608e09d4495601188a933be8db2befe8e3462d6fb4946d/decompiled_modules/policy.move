module 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::policy {
    public entry fun seal_approve_owner_only(arg0: vector<u8>, arg1: &0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::Form, arg2: &0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::FormAdminCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::Form>(arg1) == 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::admin_cap_form(arg2), 1);
    }

    public entry fun seal_approve_owner_timelock(arg0: vector<u8>, arg1: &0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::Form, arg2: &0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::FormAdminCap, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::Form>(arg1) == 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::admin_cap_form(arg2), 1);
        let v0 = 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::unlocks_at_ms(arg1);
        assert!(v0 != 0, 3);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0, 2);
    }

    public entry fun seal_approve_timelock(arg0: vector<u8>, arg1: &0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::Form, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::form::unlocks_at_ms(arg1);
        assert!(v0 != 0, 3);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0, 2);
    }

    // decompiled from Move bytecode v7
}

