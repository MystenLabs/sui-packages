module 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::hsui {
    public fun s_h(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, u64) {
        let v0 = 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::merge_all<0x2::sui::SUI>(arg2, arg5);
        0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help::transfer<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg5));
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg3, arg5), arg4, arg5);
        (v1, 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1))
    }

    public fun s_h1(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, u64) {
        let (v0, v1) = s_h(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

