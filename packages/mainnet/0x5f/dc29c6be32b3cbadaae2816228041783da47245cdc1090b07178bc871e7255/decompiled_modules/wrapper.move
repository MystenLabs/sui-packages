module 0x5fdc29c6be32b3cbadaae2816228041783da47245cdc1090b07178bc871e7255::wrapper {
    struct State has store, key {
        id: 0x2::object::UID,
        market: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        state: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::State<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    struct PT has drop {
        dummy_field: bool,
    }

    public fun add_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::LP<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::add_liquidity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun claim_interest(arg0: &mut State, arg1: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::claim_interest<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, arg3)
    }

    public fun create_new_market(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PT{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<PT>(v0, 9, b"PT", b"PT for HaSui", b"Principal token for HaSui", 0x1::option::none<0x2::url::Url>(), arg5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v2);
        let v3 = State{
            id     : 0x2::object::new(arg5),
            market : 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::create_new_market<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg2, arg3, arg4, arg5),
            state  : 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::new_state<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg5),
        };
        0x2::transfer::share_object<State>(v3);
    }

    public fun earn_interest(arg0: &State, arg1: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::earn_interest<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4);
    }

    fun get_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128), 1000000)
    }

    public fun mint(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PT>, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::mint<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_after_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::redeem_after_maturity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_before_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::redeem_before_maturity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun remove_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::LP<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PT>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::remove_liquidity<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2)
    }

    public fun swap_exact_pt_for_sy(arg0: &mut State, arg1: 0x2::coin::Coin<PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::swap_exact_pt_for_sy<PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

