module 0xfe25951ca4bd9d76fd2326efc632f2f5a07ba54bc8a0d5656c95d2d0ca4b80b9::adaptor {
    struct HaedalAdaptor has drop {
        dummy_field: bool,
    }

    struct HaedalStaked has copy, drop {
        validator: address,
        sui_in: u64,
        hasui_out: u64,
    }

    struct HaedalInstantUnstaked has copy, drop {
        hasui_in: u64,
        sui_out: u64,
    }

    public fun stake(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = HaedalAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<HaedalAdaptor, 0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<HaedalAdaptor, 0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0, arg3, arg4), arg6);
        let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg1, arg2, v1, arg5, arg6);
        let v4 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3);
        let v5 = HaedalAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<HaedalAdaptor, 0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, v2, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<HaedalAdaptor, 0x2::sui::SUI, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v5, arg3, v4), v3);
        let v6 = HaedalStaked{
            validator : arg5,
            sui_in    : arg3,
            hasui_out : v4,
        };
        0x2::event::emit<HaedalStaked>(v6);
    }

    public fun unstake_instant(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = HaedalAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<HaedalAdaptor, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<HaedalAdaptor, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(v0, arg3, arg4), arg5);
        let v3 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg1, arg2, v1, arg5);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = HaedalAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<HaedalAdaptor, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(arg0, v2, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<HaedalAdaptor, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>(v5, arg3, v4), v3);
        let v6 = HaedalInstantUnstaked{
            hasui_in : arg3,
            sui_out  : v4,
        };
        0x2::event::emit<HaedalInstantUnstaked>(v6);
    }

    // decompiled from Move bytecode v7
}

