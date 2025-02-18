module 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::tokenization {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct State has key {
        id: 0x2::object::UID,
        maturity: u64,
        hasui_balance: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    public fun burn(arg0: &mut State, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg3: &mut 0x2::coin::TreasuryCap<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg4: 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::HasuiYieldObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert!(arg0.maturity != 0, 1);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.maturity, 5);
        let v0 = 0x2::coin::value<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>(&arg2);
        assert!(v0 == 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::get_total_asset(&arg4), 0);
        0x2::coin::burn<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>(arg3, arg2);
        0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::delete(arg4);
        0x2::coin::take<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.hasui_balance, v0 * 1000000 / 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1), arg6)
    }

    public fun mint(arg0: &mut State, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0x2::coin::TreasuryCap<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::HasuiYieldObject) {
        assert!(arg0.maturity != 0, 1);
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1);
        let v1 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2) * v0 / 1000000;
        0x2::coin::put<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.hasui_balance, arg2);
        (0x2::coin::mint<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>(arg3, v1, arg4), 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::mint(v1, v0, arg4))
    }

    public fun burn_after_maturity(arg0: &mut State, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg3: &mut 0x2::coin::TreasuryCap<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert!(arg0.maturity != 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) > arg0.maturity, 3);
        0x2::coin::burn<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>(arg3, arg2);
        0x2::coin::take<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.hasui_balance, 0x2::coin::value<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>(&arg2) * 1000000 / 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1), arg5)
    }

    public fun claim_interest(arg0: &mut State, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::HasuiYieldObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        assert!(arg0.maturity != 0, 1);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.maturity, 5);
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1);
        assert!(v0 != 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::get_exchange_rate(arg2), 4);
        0x2::coin::take<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.hasui_balance, 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::get_total_asset(arg2) * (v0 - 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::get_exchange_rate(arg2)) / v0 * 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::get_exchange_rate(arg2), arg4)
    }

    public fun claim_interest_and_burn(arg0: &mut State, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg3: &mut 0x2::coin::TreasuryCap<0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::PT::PT>, arg4: 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield::HasuiYieldObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = &mut arg4;
        let v1 = claim_interest(arg0, arg1, v0, arg5, arg6);
        0x2::coin::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v1, burn(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun new_state(arg0: &Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.admin != 0x2::tx_context::sender(arg2)) {
            return
        };
        let v0 = State{
            id            : 0x2::object::new(arg2),
            maturity      : 0,
            hasui_balance : 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
        };
        0x2::transfer::share_object<State>(v0);
    }

    // decompiled from Move bytecode v6
}

