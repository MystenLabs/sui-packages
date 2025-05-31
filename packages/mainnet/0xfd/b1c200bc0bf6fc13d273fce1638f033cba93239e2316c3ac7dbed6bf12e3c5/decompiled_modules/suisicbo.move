module 0xfdb1c200bc0bf6fc13d273fce1638f033cba93239e2316c3ac7dbed6bf12e3c5::suisicbo {
    struct PlayerBet has copy, drop, store {
        player: address,
        bet_type: u8,
        amount: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        creator: address,
        joiner: 0x1::option::Option<address>,
        bets: vector<PlayerBet>,
        state: u8,
        dice_result: 0x1::option::Option<DiceResult>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DiceResult has copy, drop, store {
        d1: u8,
        d2: u8,
        d3: u8,
    }

    public entry fun cancel_game(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.creator, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::value<0x2::sui::SUI>(&arg0.pot)), arg1), v0);
        arg0.state = 3;
    }

    public entry fun create_game(arg0: u64, arg1: u8, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 0);
        assert!(arg0 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = PlayerBet{
            player   : v1,
            bet_type : arg1,
            amount   : arg0,
        };
        let v3 = Game{
            id          : 0x2::object::new(arg3),
            creator     : v1,
            joiner      : 0x1::option::none<address>(),
            bets        : 0x1::vector::empty<PlayerBet>(),
            state       : 0,
            dice_result : 0x1::option::none<DiceResult>(),
            pot         : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg0, arg3)),
        };
        0x1::vector::push_back<PlayerBet>(&mut v3.bets, v2);
        0x2::transfer::share_object<Game>(v3);
    }

    public entry fun join_game(arg0: &mut Game, arg1: u64, arg2: u8, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 1);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0);
        assert!(arg1 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 != arg0.creator, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg1, arg4)));
        let v2 = PlayerBet{
            player   : v1,
            bet_type : arg2,
            amount   : arg1,
        };
        0x1::vector::push_back<PlayerBet>(&mut arg0.bets, v2);
        arg0.joiner = 0x1::option::some<address>(v1);
        arg0.state = 1;
    }

    fun pseudo_random_dice(arg0: &0x2::tx_context::TxContext) : (u8, u8, u8) {
        let v0 = (0x2::tx_context::epoch(arg0) as u8);
        (((v0 % 6 + 1) as u8), ((v0 * 3 % 6 + 1) as u8), ((v0 * 7 % 6 + 1) as u8))
    }

    public entry fun roll_and_settle(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 1);
        let (v0, v1, v2) = pseudo_random_dice(arg1);
        let v3 = DiceResult{
            d1 : v0,
            d2 : v1,
            d3 : v2,
        };
        arg0.dice_result = 0x1::option::some<DiceResult>(v3);
        let v4 = 0x1::vector::empty<PlayerBet>();
        let v5 = 0x1::vector::empty<PlayerBet>();
        let v6 = v0 + v1 + v2;
        let v7 = v0 == v1 && v1 == v2;
        let v8 = 0;
        while (v8 < 0x1::vector::length<PlayerBet>(&arg0.bets)) {
            let v9 = 0x1::vector::borrow<PlayerBet>(&arg0.bets, v8);
            let v10 = if (v9.bet_type == 0) {
                if (!v7) {
                    if (v6 >= 11) {
                        v6 <= 17
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else if (v9.bet_type == 1) {
                if (!v7) {
                    if (v6 >= 4) {
                        v6 <= 10
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                v7
            };
            if (v10) {
                0x1::vector::push_back<PlayerBet>(&mut v4, *v9);
            } else {
                0x1::vector::push_back<PlayerBet>(&mut v5, *v9);
            };
            v8 = v8 + 1;
        };
        let v11 = 0;
        let v12 = 0;
        let v13 = 0x1::vector::length<PlayerBet>(&v4);
        let v14 = 0x1::vector::length<PlayerBet>(&v5);
        let v15 = 0;
        while (v15 < v13) {
            v11 = v11 + 0x1::vector::borrow<PlayerBet>(&v4, v15).amount;
            v15 = v15 + 1;
        };
        let v16 = 0;
        while (v16 < v14) {
            v12 = v12 + 0x1::vector::borrow<PlayerBet>(&v5, v16).amount;
            v16 = v16 + 1;
        };
        let v17 = if (v11 < v12) {
            v11
        } else {
            v12
        };
        let v18 = v17 * 500 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v18), arg1), @0x12f5df2d20f6a9d3d58d144a57a100c2d72f8241e4df657ab39e0e9986d87a17);
        let v19 = 0;
        let v20 = 0;
        while (v20 < v13 && v19 < v17) {
            let v21 = 0x1::vector::borrow<PlayerBet>(&v4, v20);
            let v22 = v17 - v19;
            let v23 = if (v21.amount <= v22) {
                v21.amount
            } else {
                v22
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, (v17 - v18) * v23 / v17), arg1), v21.player);
            v19 = v19 + v23;
            v20 = v20 + 1;
        };
        let v24 = 0;
        let v25 = 0;
        while (v25 < v14 && v24 < v17) {
            let v26 = 0x1::vector::borrow<PlayerBet>(&v5, v25);
            let v27 = v17 - v24;
            let v28 = if (v26.amount <= v27) {
                v24 = v24 + v26.amount;
                0
            } else {
                v24 = v17;
                v26.amount - v27
            };
            if (v28 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v28), arg1), v26.player);
            };
            v25 = v25 + 1;
        };
        let v29 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v29 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v29), arg1), arg0.creator);
        };
        arg0.state = 2;
    }

    // decompiled from Move bytecode v6
}

