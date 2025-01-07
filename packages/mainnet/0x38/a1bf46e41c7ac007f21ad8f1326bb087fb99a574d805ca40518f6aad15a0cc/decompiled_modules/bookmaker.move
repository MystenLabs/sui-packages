module 0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::bookmaker {
    struct Markets has store, key {
        id: 0x2::object::UID,
        volume: u64,
        market_created: u64,
        active: vector<0x1::string::String>,
        waiting: vector<0x1::string::String>,
        history: vector<0x1::string::String>,
        balance: 0x2::balance::Balance<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>,
    }

    struct MarketInfo has store {
        name: 0x1::string::String,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
        description: 0x1::string::String,
        league: 0x1::string::String,
        discipline: 0x1::string::String,
        player_A: 0x1::string::String,
        player_B: 0x1::string::String,
        status: u8,
        winner: u8,
        event_timestamp: u64,
        img_A: 0x1::string::String,
        img_B: 0x1::string::String,
        lp: LP,
    }

    struct LP has store {
        id: 0x2::object::UID,
        a: u128,
        b: u128,
        k: u128,
        fee_percent: u64,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        result: u8,
        amount: u128,
        payout: u128,
        better: address,
        status: u8,
    }

    public entry fun add_liquidity(arg0: &mut Markets, arg1: 0x2::coin::Coin<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(&mut arg0.balance, 0x2::coin::into_balance<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(arg1));
    }

    public entry fun claim_win(arg0: Bet, arg1: 0x1::string::String, arg2: &mut Markets, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_market(arg1, arg2);
        assert!(v0.status == 2, 2);
        assert!(v0.winner == arg0.result, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>>(0x2::coin::take<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(&mut arg2.balance, ((arg0.amount + arg0.payout) as u64), arg3), 0x2::tx_context::sender(arg3));
        let Bet {
            id     : v1,
            result : _,
            amount : _,
            payout : _,
            better : _,
            status : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun close_event(arg0: u8, arg1: 0x1::string::String, arg2: &mut Markets, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_market(arg1, arg2);
        assert!(v0.status == 1, 2);
        v0.status = 2;
        v0.winner = arg0;
    }

    public entry fun create_market(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u128, arg11: u64, arg12: &mut Markets, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = LP{
            id          : 0x2::object::new(arg13),
            a           : arg10 * 1000000,
            b           : arg10 * 1000000,
            k           : arg10 * arg10 * 1000000 * 1000000,
            fee_percent : 0,
        };
        let v1 = Market{
            id              : 0x2::object::new(arg13),
            name            : arg0,
            type            : arg2,
            description     : arg3,
            league          : arg6,
            discipline      : arg7,
            player_A        : arg4,
            player_B        : arg5,
            status          : 1,
            winner          : 2,
            event_timestamp : arg11,
            img_A           : arg8,
            img_B           : arg9,
            lp              : v0,
        };
        arg12.market_created = arg12.market_created + 1;
        0x1::vector::push_back<0x1::string::String>(&mut arg12.active, arg1);
        0x2::dynamic_object_field::add<0x1::string::String, Market>(&mut arg12.id, arg1, v1);
    }

    public fun get_market(arg0: 0x1::string::String, arg1: &mut Markets) : &mut Market {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Market>(&mut arg1.id, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Markets{
            id             : 0x2::object::new(arg0),
            volume         : 0,
            market_created : 0,
            active         : 0x1::vector::empty<0x1::string::String>(),
            waiting        : 0x1::vector::empty<0x1::string::String>(),
            history        : 0x1::vector::empty<0x1::string::String>(),
            balance        : 0x2::balance::zero<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(),
        };
        0x2::transfer::share_object<Markets>(v0);
    }

    public entry fun make_bet(arg0: u8, arg1: u64, arg2: 0x2::coin::Coin<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>, arg3: 0x1::string::String, arg4: &mut Markets, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0 || arg0 == 1, 5);
        let v0 = get_market(arg3, arg4);
        assert!(v0.event_timestamp > 0x2::clock::timestamp_ms(arg5), 2);
        let v1 = v0.lp.a;
        let v2 = v0.lp.a;
        let v3 = v0.lp.k;
        let v4 = if (arg0 == 0) {
            v0.lp.b = v2 + (arg1 as u128);
            v0.lp.a = v3 / v0.lp.b;
            v1 - v3 / (v2 + (arg1 as u128))
        } else {
            v0.lp.a = v1 + (arg1 as u128);
            v0.lp.b = v3 / v0.lp.a;
            v2 - v3 / (v1 + (arg1 as u128))
        };
        let v5 = Bet{
            id     : 0x2::object::new(arg6),
            result : arg0,
            amount : (arg1 as u128),
            payout : v4,
            better : 0x2::tx_context::sender(arg6),
            status : 0,
        };
        0x2::transfer::public_transfer<Bet>(v5, 0x2::tx_context::sender(arg6));
        0x2::balance::join<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(&mut arg4.balance, 0x2::coin::into_balance<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(0x2::coin::split<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(&mut arg2, arg1, arg6)));
        return_remaining_coin<0x38a1bf46e41c7ac007f21ad8f1326bb087fb99a574d805ca40518f6aad15a0cc::wsd::WSD>(arg2, arg6);
    }

    fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun start_event(arg0: 0x1::string::String, arg1: &mut Markets, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_market(arg0, arg1);
        assert!(v0.status == 0, 2);
        v0.status = 1;
    }

    // decompiled from Move bytecode v6
}

