module 0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::wrapper {
    struct State has store, key {
        id: 0x2::object::UID,
        market: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::Market<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        registry: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::Registry<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    public fun add_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::LP<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::add_liquidity<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun borrow_pt(arg0: &mut State, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::SellYoBorrowPt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::borrow_pt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, arg3)
    }

    public fun borrow_sy(arg0: &mut State, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::BuyYoBorrowSy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::borrow_sy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, arg3)
    }

    public fun claim_fee(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::claim_fee<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1)
    }

    public fun claim_interest(arg0: &mut State, arg1: &mut 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::claim_interest<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, arg2, arg3)
    }

    public fun create_new_state(arg0: &mut 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::Factory, arg1: 0x2::coin::TreasuryCap<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg2: u64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id       : 0x2::object::new(arg7),
            market   : 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::create_new_market<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg2, arg3, arg4, arg5, arg6, arg7),
            registry : 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::create_new_registry<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg7),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun earn_interest(arg0: &State, arg1: &mut 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::earn_interest<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, get_exchange_rate(arg2), arg3);
    }

    public fun get_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128), 1000000)
    }

    public fun merge(arg0: &mut State, arg1: &mut 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::merge<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, arg2, get_exchange_rate(arg3));
    }

    public fun mint(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::mint<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_after_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::redeem_after_maturity<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_before_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg2: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::redeem_before_maturity<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.registry, &arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun refund_pt(arg0: &mut State, arg1: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::SellYoBorrowPt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::refund_pt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2);
    }

    public fun refund_sy(arg0: &mut State, arg1: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::BuyYoBorrowSy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::refund_sy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2);
    }

    public fun remove_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::LP<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::remove_liquidity<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2)
    }

    public fun split(arg0: &mut State, arg1: &mut 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::yield_object::YieldObject<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::sy_tokenization::split<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, arg2, arg3)
    }

    public fun swap_exact_pt_for_sy(arg0: &mut State, arg1: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::swap_exact_pt_for_sy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4)
    }

    public fun swap_exact_pt_for_sy_with_hot_potato(arg0: &mut State, arg1: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::BuyYoBorrowSy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::BuyYoBorrowSy<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::swap_exact_pt_for_sy_with_hot_potato<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, get_exchange_rate(arg3), arg2, arg4, arg5)
    }

    public fun swap_sy_for_exact_pt(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::swap_sy_for_exact_pt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4, arg5)
    }

    public fun swap_sy_for_exact_pt_with_hot_potato(arg0: &mut State, arg1: 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::SellYoBorrowPt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, 0x2::coin::Coin<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT>, 0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::SellYoBorrowPt<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0xb153cf1dcef744d282bff9c1783b99e3e1889e2de64b8987257328e3fe574780::amm::swap_sy_for_exact_pt_with_hot_potato<0x96df5f4a9d5224afa158a51577b189494a5cce1999b99cbd9c0878ad9e3fe867::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, get_exchange_rate(arg3), arg2, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

