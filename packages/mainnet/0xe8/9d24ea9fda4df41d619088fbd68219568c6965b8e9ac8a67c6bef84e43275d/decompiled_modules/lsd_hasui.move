module 0xe89d24ea9fda4df41d619088fbd68219568c6965b8e9ac8a67c6bef84e43275d::lsd_hasui {
    public fun swap(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), @0x0, arg4)));
    }

    fun swap_b2a(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg3);
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0);
            return
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0, arg4), arg4)));
    }

    // decompiled from Move bytecode v7
}

