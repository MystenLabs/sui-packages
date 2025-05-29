module 0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::PartnerCap, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 0) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            arg4
        };
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::create_partner(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

