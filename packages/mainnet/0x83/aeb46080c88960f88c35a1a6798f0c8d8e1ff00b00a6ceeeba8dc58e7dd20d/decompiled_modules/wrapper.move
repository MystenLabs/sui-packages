module 0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::wrapper {
    struct State has store, key {
        id: 0x2::object::UID,
        market: 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::Market<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        registry: 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::Registry<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    public fun add_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::LP<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::add_liquidity<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun claim_fee(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::claim_fee<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1)
    }

    public fun claim_interest(arg0: &mut State, arg1: &mut 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::claim_interest<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, arg2, arg3)
    }

    public fun create_new_state(arg0: &mut 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::Factory, arg1: 0x2::coin::TreasuryCap<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, arg2: u64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id       : 0x2::object::new(arg7),
            market   : 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::create_new_market<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg3, arg4, arg5, arg6, arg7),
            registry : 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::create_new_registry<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg7),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun earn_interest(arg0: &State, arg1: &mut 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock) {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::earn_interest<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, get_exchange_rate(arg2), arg3);
    }

    public fun get_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128), 1000000)
    }

    public fun merge(arg0: &mut State, arg1: &mut 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::merge<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, arg2, get_exchange_rate(arg3));
    }

    public fun mint(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::mint<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_after_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::redeem_after_maturity<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_before_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, arg2: 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::redeem_before_maturity<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun remove_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::LP<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::remove_liquidity<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2)
    }

    public fun split(arg0: &mut State, arg1: &mut 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object::YieldObject<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::sy_tokenization::split<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, arg2, arg3)
    }

    public fun swap_exact_pt_for_sy(arg0: &mut State, arg1: 0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::swap_exact_pt_for_sy<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4)
    }

    public fun swap_sy_for_exact_pt(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT> {
        0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::amm::swap_sy_for_exact_pt<0x83aeb46080c88960f88c35a1a6798f0c8d8e1ff00b00a6ceeeba8dc58e7dd20d::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

