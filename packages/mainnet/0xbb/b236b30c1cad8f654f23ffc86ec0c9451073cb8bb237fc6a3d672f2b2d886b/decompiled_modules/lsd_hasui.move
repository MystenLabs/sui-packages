module 0xbbb236b30c1cad8f654f23ffc86ec0c9451073cb8bb237fc6a3d672f2b2d886b::lsd_hasui {
    public fun swap(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), @0x0, arg5)));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<0x2::sui::SUI>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<0x2::sui::SUI>(arg0), arg5);
        };
    }

    fun swap_b2a(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg3);
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0);
            return
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0, arg5), arg5)));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0), arg5);
        };
    }

    // decompiled from Move bytecode v7
}

