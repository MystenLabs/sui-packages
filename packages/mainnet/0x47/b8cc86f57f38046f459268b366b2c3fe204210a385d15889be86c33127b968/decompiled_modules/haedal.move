module 0x47b8cc86f57f38046f459268b366b2c3fe204210a385d15889be86c33127b968::haedal {
    struct HedalSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b(arg0: &mut 0x47b8cc86f57f38046f459268b366b2c3fe204210a385d15889be86c33127b968::config::Config, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg1, arg3, @0x0, arg4);
        let v1 = HedalSwapEvent{
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            amount_out : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0),
            coin_a     : 0x1::type_name::get<0x2::sui::SUI>(),
            coin_b     : 0x1::type_name::get<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
        };
        0x2::event::emit<HedalSwapEvent>(v1);
        let (v2, _) = 0x47b8cc86f57f38046f459268b366b2c3fe204210a385d15889be86c33127b968::config::pay_fee<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, v0, arg4);
        v2
    }

    // decompiled from Move bytecode v6
}

