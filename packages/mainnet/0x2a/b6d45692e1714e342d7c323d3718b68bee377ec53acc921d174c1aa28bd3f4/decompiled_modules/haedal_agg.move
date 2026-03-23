module 0x2ab6d45692e1714e342d7c323d3718b68bee377ec53acc921d174c1aa28bd3f4::haedal_agg {
    struct HaedalAgg has drop {
        dummy_field: bool,
    }

    public fun swap(arg0: &0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::router::Router, arg1: &mut 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::SwapContext, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let v0 = HaedalAgg{dummy_field: false};
            let v1 = swap_a2b(arg2, arg3, 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<HaedalAgg, 0x2::sui::SUI>(arg1, arg0, v0, arg5), arg6);
            if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1) > 0) {
                0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, v1);
            } else {
                0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1);
            };
        } else {
            let v2 = HaedalAgg{dummy_field: false};
            let v3 = swap_b2a(arg2, arg3, 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<HaedalAgg, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg0, v2, arg5), arg6);
            if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
                0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<0x2::sui::SUI>(arg1, v3);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            };
        };
    }

    fun swap_a2b(arg0: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
            return 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()
        };
        0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg1, arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg3), @0x0, arg3))
    }

    fun swap_b2a(arg0: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2) == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        0x2::coin::into_balance<0x2::sui::SUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg1, arg0, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg3), arg3))
    }

    // decompiled from Move bytecode v6
}

