module 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::Vault, arg1: 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::Vault, arg2: 0x2::coin::Coin<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(arg2);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::UnstakeRequest>(0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::Vault, arg2: 0x2::coin::Coin<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(arg2);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::coin_helper::destroy_or_transfer_balance<0xb6c4bd4b1f699479458df8278ebaf6d1ea30fd808118414d540bc58c46436b06::ggsui::GGSUI>(0x73fe8d1c07a2d0c361069e884ec7df98b7cb228a87a2c7b202a31970923a9dc8::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

