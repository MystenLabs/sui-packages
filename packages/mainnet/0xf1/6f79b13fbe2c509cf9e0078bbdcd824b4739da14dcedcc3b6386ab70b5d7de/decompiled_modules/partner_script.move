module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::PartnerCap, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 0) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            arg4
        };
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::create_partner(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

