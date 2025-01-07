module 0xa4ceb3319e8790520c53aef2e1197a41c18c4bfedaf05bcef490bee7fd436f59::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::PartnerCap, arg2: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::create_partner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::Partner, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::config::GlobalConfig, arg1: &mut 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

