module 0x7a9d10bd1dcd79d42966e35173f68ee0541242f7cdb89cb2e69540f2d9777965::haedal {
    public fun mint<T0>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg2, arg1, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), @0x0, arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), true, 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0));
        (v0, 0x2::balance::zero<0x2::sui::SUI>())
    }

    public fun quote<T0>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: bool) {
        let v0 = vector[];
        let v1 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            let v4 = if (arg2) {
                if (v3 < 1000000000) {
                    0
                } else {
                    0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_stsui_by_sui(arg1, v3)
                }
            } else {
                let v5 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg1, v3);
                if (v5 < 1000000000) {
                    0
                } else {
                    v5 - (((v5 as u128) * (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config::get_service_fee(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_config(arg1)) as u128) / 10000000) as u64)
                }
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), arg2, v0, vector[], vector[]);
    }

    public fun redeem<T0>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg2, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg3, arg4), arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), false, 0x2::balance::value<0x2::sui::SUI>(&v0));
        (v0, 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>())
    }

    // decompiled from Move bytecode v7
}

