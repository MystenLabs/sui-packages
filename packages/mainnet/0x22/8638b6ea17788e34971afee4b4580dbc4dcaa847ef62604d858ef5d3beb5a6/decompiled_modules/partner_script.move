module 0x228638b6ea17788e34971afee4b4580dbc4dcaa847ef62604d858ef5d3beb5a6::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::PartnerCap, arg2: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 0) {
            0x2::clock::timestamp_ms(arg7) / 1000
        } else {
            arg4
        };
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::create_partner(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

