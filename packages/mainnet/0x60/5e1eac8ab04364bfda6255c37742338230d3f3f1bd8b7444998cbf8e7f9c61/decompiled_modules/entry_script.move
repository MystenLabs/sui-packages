module 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::GgSuiVault, arg1: 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::GgSuiVault, arg2: 0x2::coin::Coin<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(arg2);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::UnstakeRequest>(0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::GgSuiVault, arg2: 0x2::coin::Coin<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(arg2);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::coin_helper::destroy_or_transfer_balance<0xbac22372b7fcc8a59874b9a541df297e751f34c666960395081964df9efff4bb::ggsui::GGSUI>(0x605e1eac8ab04364bfda6255c37742338230d3f3f1bd8b7444998cbf8e7f9c61::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

