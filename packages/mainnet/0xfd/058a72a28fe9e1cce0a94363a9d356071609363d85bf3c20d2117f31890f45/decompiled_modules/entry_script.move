module 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::entry_script {
    public fun claim_unstaked_sui(arg0: &mut 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::GgSuiVault, arg1: 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::claim_unstaked_sui(arg0, arg1, arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::GgSuiVault, arg2: 0x2::coin::Coin<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(arg2);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0x2::transfer::public_transfer<0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::UnstakeRequest>(0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::request_delayed_unstake(arg0, arg1, 0x2::balance::split<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::GgSuiVault, arg2: 0x2::coin::Coin<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(arg2);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::request_instant_unstake(arg0, arg1, 0x2::balance::split<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(&mut v0, arg3), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4), arg4);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::none<address>(), arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::GgSuiVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5), arg5);
        0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::coin_helper::destroy_or_transfer_balance<0xad6250f65de431428516f8e0d2e28dcf1a2e6da5681b39fe2e99215c46a2becf::ggsui::GGSUI>(0xfd058a72a28fe9e1cce0a94363a9d356071609363d85bf3c20d2117f31890f45::vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg3), 0x1::option::some<address>(arg4), arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    // decompiled from Move bytecode v6
}

