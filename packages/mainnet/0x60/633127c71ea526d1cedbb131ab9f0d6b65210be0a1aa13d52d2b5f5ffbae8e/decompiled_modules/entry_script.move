module 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::GgSuiVault, arg1: 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(arg2);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::UnstakeRequest>(0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(arg2);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::coin_helper::destroy_or_transfer_balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::ggsui::GGSUI>(0x60633127c71ea526d1cedbb131ab9f0d6b65210be0a1aa13d52d2b5f5ffbae8e::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

