module 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::entry_script {
    public entry fun claim_unstaked_sui(arg0: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg1: 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(arg2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::UnstakeRequest>(0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(arg2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

