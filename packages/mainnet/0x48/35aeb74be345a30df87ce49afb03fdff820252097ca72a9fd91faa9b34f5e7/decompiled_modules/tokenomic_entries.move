module 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic_entries {
    public entry fun change_admin(arg0: 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TAdminCap, arg1: address, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::change_admin(arg0, arg1, arg2);
    }

    public entry fun change_fund_owner<T0>(arg0: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TokenomicPie<T0>, arg1: address, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::change_fund_owner<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim<T0>(arg0: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TokenomicPie<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        if (0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::check<T0>(arg0, arg1, arg2, arg3)) {
            0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::claim<T0>(arg0, arg1, arg2, arg3);
        };
    }

    public entry fun claim2<T0>(arg0: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TokenomicPie<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::claim2<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun init_tokenomic<T0>(arg0: &0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TAdminCap, arg1: u128, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::init_tokenomic<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun addFund<T0>(arg0: &0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TAdminCap, arg1: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::TokenomicPie<T0>, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::version::Version, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        0xa00d14642a0faa3236f80a990568447a57a51d057ca4dc79f623db5b7334f58d::tokenomic::addFund2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    // decompiled from Move bytecode v6
}

