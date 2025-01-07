module 0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::partner_script {
    public entry fun claim_ref_fee<T0>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::PartnerCap, arg2: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::claim_ref_fee<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_partner(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::Partners, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::create_partner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_partner_ref_fee_rate(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::Partner, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::update_ref_fee_rate(arg0, arg1, arg2, arg3);
    }

    public entry fun update_partner_time_range(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::Partner, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::partner::update_time_range(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

