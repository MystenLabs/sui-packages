module 0x1e415c1f032208644798cf5f3980b3fd4f058a9b01ce191a4eca79696e799a1b::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::PartnerCap, arg2: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 0) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            arg4
        };
        0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::create_partner(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg1: &mut 0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

