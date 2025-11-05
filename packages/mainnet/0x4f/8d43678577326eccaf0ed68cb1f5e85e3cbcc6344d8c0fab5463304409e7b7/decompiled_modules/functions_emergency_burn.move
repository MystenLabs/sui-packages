module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::functions_emergency_burn {
    public fun emergency_burn<T0>(arg0: &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::cap_ylds_admin::YldsAdminCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::coin::burn<T0>(arg1, arg2);
        0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_admin::emit_admin_event(0x1::string::utf8(b"emergency_burn"), v0, 0x1::string::utf8(b"Emergency burn executed"));
        0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_burn::emit_burn_event(0x2::coin::value<T0>(&arg2), v0, 0x2::coin::total_supply<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

