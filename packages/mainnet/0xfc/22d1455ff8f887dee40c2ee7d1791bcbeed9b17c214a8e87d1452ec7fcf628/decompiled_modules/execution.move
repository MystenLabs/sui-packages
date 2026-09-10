module 0xfc22d1455ff8f887dee40c2ee7d1791bcbeed9b17c214a8e87d1452ec7fcf628::execution {
    public fun maybe_mint(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg2), @0x0, arg3))
    }

    public fun maybe_redeem(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x1::option::Option<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(arg2), arg3))
    }

    // decompiled from Move bytecode v7
}

