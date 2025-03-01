module 0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::wrapper {
    struct State has store, key {
        id: 0x2::object::UID,
        market: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::Market<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        state: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::State<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    public fun add_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::LP<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::add_liquidity<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    public fun create_new_market(arg0: 0x2::coin::TreasuryCap<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, arg1: u64, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg3: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg4: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id     : 0x2::object::new(arg6),
            market : 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::create_new_market<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg2, arg3, arg4, arg5, arg6),
            state  : 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::new_state<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg6),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun remove_liquidity(arg0: &mut State, arg1: 0x2::coin::Coin<0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::LP<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::remove_liquidity<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, arg1, arg2)
    }

    public fun swap_exact_pt_for_sy(arg0: &mut State, arg1: 0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::amm::swap_exact_pt_for_sy<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.market, get_exchange_rate(arg2), arg1, arg3, arg4)
    }

    public fun claim_interest(arg0: &mut State, arg1: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::claim_interest<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, arg3)
    }

    public fun earn_interest(arg0: &State, arg1: &mut 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::earn_interest<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4);
    }

    public fun mint(arg0: &mut State, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::mint<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_after_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::redeem_after_maturity<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, get_exchange_rate(arg2), arg3, arg4)
    }

    public fun redeem_before_maturity(arg0: &mut State, arg1: 0x2::coin::Coin<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT>, arg2: 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object::YieldObject<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::manager::redeem_before_maturity<0xea10e2c7f6b8b7cf24ba35db5aabc72d659aadc996b687486e34cd60fa0006c6::PT::PT, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.state, &arg0.market, arg1, arg2, get_exchange_rate(arg3), arg4, arg5)
    }

    fun get_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0) as u128), 1000000)
    }

    // decompiled from Move bytecode v6
}

