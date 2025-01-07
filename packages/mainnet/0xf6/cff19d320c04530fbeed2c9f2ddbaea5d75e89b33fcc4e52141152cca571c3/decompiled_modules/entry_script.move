module 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::entry_script {
    public entry fun claim_unstaked_sui(arg0: &mut 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::DSuiVault, arg1: 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::claim_unstaked_sui(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v1, arg2);
    }

    public entry fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(arg2);
        let v1 = 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(&mut v0, arg3), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(v0, v2, arg4);
        0x2::transfer::public_transfer<0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::UnstakeRequest>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(arg2);
        let v1 = 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(&mut v0, arg3), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(v0, v2, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v3, arg4);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v2, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(v1, v3, arg4);
    }

    public entry fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0xf6cff19d320c04530fbeed2c9f2ddbaea5d75e89b33fcc4e52141152cca571c3::dsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v2, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::dsui::DSUI>(v1, v3, arg5);
    }

    // decompiled from Move bytecode v6
}

