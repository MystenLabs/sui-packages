module 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::entry_script {
    public entry fun claim_unstaked_sui(arg0: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg1: 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::claim_unstaked_sui(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v1, arg2);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public entry fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg2: 0x2::coin::Coin<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(arg2);
        let v1 = 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(&mut v0, arg3), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(v0, v2, arg4);
        0x2::transfer::public_transfer<0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::UnstakeRequest>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg2: 0x2::coin::Coin<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(arg2);
        let v1 = 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(&mut v0, arg3), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(v0, v2, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v3, arg4);
    }

    public entry fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v2, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(v1, v3, arg4);
    }

    public entry fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v2, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>(v1, v3, arg5);
    }

    // decompiled from Move bytecode v6
}

