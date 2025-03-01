module 0xa07ef28a0ebe76e7ff826ab344f28d8dfa5f355fdca7e2481f093cb19160582c::wrapper {
    struct State has store, key {
        id: 0x2::object::UID,
        market: 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::MarketState<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        state: 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::State<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    struct PT has drop {
        dummy_field: bool,
    }

    public fun add_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::LP<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::add_liquidity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun create_new_market(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PT{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<PT>(v0, 9, b"PT", b"PT for HaSui", b"Principal token for HaSui", 0x1::option::none<0x2::url::Url>(), arg5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v2);
        let v3 = State{
            id     : 0x2::object::new(arg5),
            market : 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::create_new_market<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg2, arg3, arg4, arg5),
            state  : 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::new_state<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg5),
        };
        0x2::transfer::share_object<State>(v3);
    }

    public fun remove_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::LP<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PT>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::remove_liquidity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2)
    }

    public fun swap_exact_pt_for_sy(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::amm::swap_exact_pt_for_sy<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4)
    }

    public fun claim_interest(arg0: &mut State, arg1: &mut 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::claim_interest<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, arg3)
    }

    public fun earn_interest(arg0: &State, arg1: &mut 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::earn_interest<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4);
    }

    public fun mint(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PT>, 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::mint<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_after_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::redeem_after_maturity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_before_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: 0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x401d55beb5c238551fd0b397d822bc5894547bfb656213ed505a6f77fa640b9f::manager::redeem_before_maturity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    fun get_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128), 1000000)
    }

    // decompiled from Move bytecode v6
}

