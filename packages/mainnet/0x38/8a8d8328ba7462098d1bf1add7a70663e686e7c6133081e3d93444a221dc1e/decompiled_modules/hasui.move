module 0x388a8d8328ba7462098d1bf1add7a70663e686e7c6133081e3d93444a221dc1e::hasui {
    public fun swap(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), @0x0, arg4);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, b"HASUI", 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), v1, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v2), 0);
    }

    fun swap_b2a(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0);
            return
        };
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0, arg4), arg4);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg0, b"HASUI", 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), v1, 0x2::coin::value<0x2::sui::SUI>(&v2), 0);
    }

    // decompiled from Move bytecode v7
}

