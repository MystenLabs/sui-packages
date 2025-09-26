module 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::GgSuiVault, arg1: 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x2::sui::SUI>(0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(arg2);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::UnstakeRequest>(0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(arg2);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x2::sui::SUI>(0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::destroy_or_transfer_balance<0x8d5e5cd3b629acb06a554609888f9acdc80698d5a9900f037ec38fb9da14a78e::ggsui::GGSUI>(0x995b48d907dd8de619bb68352971ccbe01ef2eaed40a51f761454a925ab6c816::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

