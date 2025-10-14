module 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::Vault, arg1: 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::Vault, arg2: 0x2::coin::Coin<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(arg2);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::UnstakeRequest>(0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::Vault, arg2: 0x2::coin::Coin<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(arg2);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::coin_helper::destroy_or_transfer_balance<0xd5f9fa35639f08e6ba3b82672439fa66d7f8c9272fc451944dee090aee7284f6::ggsui::GGSUI>(0xe9a08c0eda32a010a8061c773c6e9fa334b9caa30efce4ce3d0f7726543f8f46::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

