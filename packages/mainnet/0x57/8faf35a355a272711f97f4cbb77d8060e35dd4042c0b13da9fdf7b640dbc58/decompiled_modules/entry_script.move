module 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::Vault, arg1: 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::Vault, arg2: 0x2::coin::Coin<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::UnstakeRequest>(0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::Vault, arg2: 0x2::coin::Coin<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::ggsui::GGSUI>(0x578faf35a355a272711f97f4cbb77d8060e35dd4042c0b13da9fdf7b640dbc58::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

