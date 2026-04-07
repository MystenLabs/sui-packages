module 0x85da581db41d0b4b7ca0f6a43b0564da50d7bd6c68ff1986c51a994603de5cbd::blackjack {
    struct GameState has key {
        id: 0x2::object::UID,
        admin: address,
        prize_pool: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
        min_bet: u64,
        total_hands: u64,
        total_volume: u64,
        jackpots_hit: u64,
    }

    struct GameSession has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        doubled: bool,
        active: bool,
    }

    struct BetPlaced has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
    }

    struct HandSettled has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
        doubled: bool,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct JackpotHit has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
        payout: u64,
    }

    struct PoolDeposited has copy, drop {
        depositor: address,
        amount: u64,
        pool_after: u64,
    }

    struct MinBetUpdated has copy, drop {
        old_min: u64,
        new_min: u64,
    }

    struct SpinResult has copy, drop {
        player: address,
        wager: u64,
        reel0: u8,
        reel1: u8,
        reel2: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    public entry fun deposit_pool(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v0 = PoolDeposited{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1),
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PoolDeposited>(v0);
    }

    public entry fun double_down(arg0: &mut GameState, arg1: &mut GameSession, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 3);
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) == arg1.bet, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        arg1.doubled = true;
    }

    public entry fun emergency_withdraw(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, arg1), arg2), arg0.admin);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            prize_pool   : 0x2::balance::zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(),
            min_bet      : 10000000000000,
            total_hands  : 0,
            total_volume : 0,
            jackpots_hit : 0,
        };
        0x2::transfer::share_object<GameState>(v0);
    }

    public fun min_bet(arg0: &GameState) : u64 {
        arg0.min_bet
    }

    public entry fun place_bet(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= arg0.min_bet, 1);
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        if (v1 > 0) {
            assert!(v0 <= v1 * 2000 / 10000, 4);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v2 = GameSession{
            id      : 0x2::object::new(arg2),
            player  : 0x2::tx_context::sender(arg2),
            bet     : v0,
            doubled : false,
            active  : true,
        };
        let v3 = BetPlaced{
            session_id : 0x2::object::id<GameSession>(&v2),
            player     : 0x2::tx_context::sender(arg2),
            bet        : v0,
        };
        0x2::event::emit<BetPlaced>(v3);
        0x2::transfer::transfer<GameSession>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun pool_size(arg0: &GameState) : u64 {
        0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
    }

    public entry fun set_min_bet(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.min_bet = arg1;
        let v0 = MinBetUpdated{
            old_min : arg0.min_bet,
            new_min : arg1,
        };
        0x2::event::emit<MinBetUpdated>(v0);
    }

    public entry fun settle(arg0: &mut GameState, arg1: GameSession, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1.active, 3);
        assert!(arg2 <= 6, 5);
        let GameSession {
            id      : v0,
            player  : v1,
            bet     : v2,
            doubled : v3,
            active  : _,
        } = arg1;
        0x2::object::delete(v0);
        let v5 = if (v3) {
            v2 * 2
        } else {
            v2
        };
        let v6 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v5;
        let v7 = if (arg2 == 0 || arg2 == 5) {
            0
        } else if (arg2 == 3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v5), arg3), v1);
            v5
        } else if (arg2 == 1 || arg2 == 4) {
            let v8 = v5 + v5 * 9000 / 10000;
            assert!(v6 >= v8, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v8), arg3), v1);
            v8
        } else if (arg2 == 2) {
            let v9 = v5 + v5 * 15000 / 10000;
            assert!(v6 >= v9, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v9), arg3), v1);
            v9
        } else {
            arg0.jackpots_hit = arg0.jackpots_hit + 1;
            let v10 = JackpotHit{
                session_id : 0x2::object::id_from_address(v1),
                player     : v1,
                bet        : v5,
                payout     : v6,
            };
            0x2::event::emit<JackpotHit>(v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v6), arg3), v1);
            v6
        };
        let v11 = HandSettled{
            session_id : 0x2::object::id_from_address(v1),
            player     : v1,
            bet        : v5,
            doubled    : v3,
            result     : arg2,
            payout     : v7,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<HandSettled>(v11);
    }

    public entry fun spin(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = 0x2::tx_context::digest(arg2);
        let v3 = 0x2::address::to_bytes(0x2::tx_context::sender(arg2));
        let v4 = 0;
        let v5 = 0;
        while (v5 < 8) {
            let v6 = v4 ^ (*0x1::vector::borrow<u8>(v2, (v5 as u64)) as u64) << v5 * 8;
            v4 = v6 ^ (*0x1::vector::borrow<u8>(&v3, (v5 as u64)) as u64) << (7 - v5) * 8;
            v5 = v5 + 1;
        };
        let v7 = v4 ^ v0 ^ v1 % 1000000007;
        let v8 = x"000101020203030404050506";
        let v9 = *0x1::vector::borrow<u8>(&v8, ((v7 % 12) as u64));
        let v10 = *0x1::vector::borrow<u8>(&v8, (((v7 >> 16) % 12) as u64));
        let v11 = *0x1::vector::borrow<u8>(&v8, (((v7 >> 32) % 12) as u64));
        let (v12, v13) = if (v9 == v10 && v10 == v11) {
            if (v9 == 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                (v1, 4)
            } else if (v9 == 6) {
                (v0 * 10, 3)
            } else if (v9 == 5 || v9 == 4) {
                (v0 * 5, 2)
            } else {
                (v0 * 2, 1)
            }
        } else {
            let v14 = if (v9 == v10) {
                true
            } else if (v10 == v11) {
                true
            } else {
                v9 == v11
            };
            if (v14) {
                let v15 = if (v9 == 0) {
                    true
                } else if (v10 == 0) {
                    true
                } else {
                    v11 == 0
                };
                if (v15) {
                    (v0 * 2, 1)
                } else {
                    (0, 0)
                }
            } else {
                (0, 0)
            }
        };
        if (v12 > 0) {
            let v16 = if (v12 > 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)) {
                0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
            } else {
                v12
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v16), arg2), 0x2::tx_context::sender(arg2));
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v17 = if (v12 > 0) {
            if (v12 > v1) {
                v1
            } else {
                v12
            }
        } else {
            0
        };
        let v18 = SpinResult{
            player     : 0x2::tx_context::sender(arg2),
            wager      : v0,
            reel0      : v9,
            reel1      : v10,
            reel2      : v11,
            result     : v13,
            payout     : v17,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<SpinResult>(v18);
    }

    public fun total_hands(arg0: &GameState) : u64 {
        arg0.total_hands
    }

    // decompiled from Move bytecode v6
}

