module 0x77eaf5068b6b075d0595f8a6e2e1cd6947810832202c82e2b2aa061466f590b2::ma9e4a3bba597671caef14bc3 {
    public fun f2c66e1a993cff1db246120a7(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, arg2, arg3, arg4)
    }

    public fun f7bbeb44a64c48d5348039982(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

