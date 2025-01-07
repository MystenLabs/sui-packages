module 0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg1: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::AdminCap, arg1: &0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::config::GlobalConfig, arg2: &mut 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x453940ee31f09d3a4def2928c692a5c51717127aafea6b5df4b48211d30208a2::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xd2d52783538f553919426ff09ec5dc6b7b323bc4045db9fe9650a6595a505658::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

