module 0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_haedal_lsd {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_transaction::SwapTransaction<T0, T1>, arg5: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1);
        0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_event::emit_common_swap<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::consts::LSD_HAEDAL(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_transaction::SwapTransaction<T0, T1>, arg4: &0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg0, arg1, arg2, arg5);
        let v1 = 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1);
        0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::swap_event::emit_common_swap<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xcc8b53ea0cb1cff4674fd1d2e086f6ef98c69d75a657f52114ab435cf3e140e1::consts::LSD_HAEDAL(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2), 0x2::coin::value<0x2::sui::SUI>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

