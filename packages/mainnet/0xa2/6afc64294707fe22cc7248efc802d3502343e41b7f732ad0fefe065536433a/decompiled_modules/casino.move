module 0xa26afc64294707fe22cc7248efc802d3502343e41b7f732ad0fefe065536433a::casino {
    struct CasinoShrine has key {
        id: 0x2::object::UID,
        admin: address,
        prize_pool: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
        min_bet: u64,
        total_hands: u64,
        total_volume: u64,
        jackpots_hit: u64,
    }

    struct CovenantSession has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        doubled: bool,
        active: bool,
    }

    struct CovenantSealed has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
    }

    struct MountainHasSpoken has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
        doubled: bool,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct JackpotHit has copy, drop {
        player: address,
        bet: u64,
        payout: u64,
        game: u8,
    }

    struct OracleConsulted has copy, drop {
        player: address,
        wager: u64,
        reel0: u8,
        reel1: u8,
        reel2: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct LotsCast has copy, drop {
        player: address,
        wager: u64,
        roll: u8,
        prediction: u8,
        target: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct WheelOfFateSpun has copy, drop {
        player: address,
        wager: u64,
        number: u8,
        colour: u8,
        bet_type: u8,
        bet_value: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct PoolDeposited has copy, drop {
        depositor: address,
        amount: u64,
        pool_after: u64,
    }

    public entry fun cast_the_dice(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg2 <= 2, 6);
        if (arg2 == 2) {
            assert!(arg3 >= 1 && arg3 <= 100, 6);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = ((make_seed(arg4, v0 ^ v1 % 999999937) % 100) as u8) + 1;
        let (v3, v4) = if (arg2 == 0) {
            if (v2 <= 49) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 1) {
            if (v2 >= 51) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (v2 == arg3) {
            let v5 = v0 * 90;
            let v3 = v5;
            if (v5 >= v1 / 2) {
                let v6 = v1 / 2;
                v3 = v6;
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v7 = JackpotHit{
                    player : 0x2::tx_context::sender(arg4),
                    bet    : v0,
                    payout : v6,
                    game   : 2,
                };
                0x2::event::emit<JackpotHit>(v7);
            };
            (v3, 2)
        } else {
            (0, 0)
        };
        if (v3 > 0) {
            let v8 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v3, v8, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v9 = LotsCast{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            roll       : v2,
            prediction : arg2,
            target     : arg3,
            result     : v4,
            payout     : v3,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<LotsCast>(v9);
    }

    public entry fun consult_the_oracle(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = make_seed(arg2, v0 ^ v1 % 1000000007);
        let v3 = x"000101020203030404050506";
        let v4 = *0x1::vector::borrow<u8>(&v3, ((v2 % 12) as u64));
        let v5 = *0x1::vector::borrow<u8>(&v3, (((v2 >> 16) % 12) as u64));
        let v6 = *0x1::vector::borrow<u8>(&v3, (((v2 >> 32) % 12) as u64));
        let (v7, v8) = if (v4 == v5 && v5 == v6) {
            if (v4 == 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v9 = JackpotHit{
                    player : 0x2::tx_context::sender(arg2),
                    bet    : v0,
                    payout : v1,
                    game   : 1,
                };
                0x2::event::emit<JackpotHit>(v9);
                (v1, 4)
            } else if (v4 == 6) {
                (v0 * 10, 3)
            } else if (v4 == 5 || v4 == 4) {
                (v0 * 5, 2)
            } else {
                (v0 * 2, 1)
            }
        } else if (v4 == 0 && (v5 == 0 || v6 == 0)) {
            (v0 * 2, 1)
        } else if (v5 == 0 && v6 == 0) {
            (v0 * 2, 1)
        } else {
            (0, 0)
        };
        if (v7 > 0) {
            let v10 = 0x2::tx_context::sender(arg2);
            pay_player(arg0, v7, v10, arg2);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v11 = if (v7 > v1) {
            v1
        } else {
            v7
        };
        let v12 = OracleConsulted{
            player     : 0x2::tx_context::sender(arg2),
            wager      : v0,
            reel0      : v4,
            reel1      : v5,
            reel2      : v6,
            result     : v8,
            payout     : v11,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<OracleConsulted>(v12);
    }

    public entry fun deposit_pool(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v0 = PoolDeposited{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1),
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PoolDeposited>(v0);
    }

    public entry fun double_the_offering(arg0: &mut CasinoShrine, arg1: &mut CovenantSession, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 3);
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) == arg1.bet, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        arg1.doubled = true;
    }

    public entry fun emergency_withdraw(arg0: &mut CasinoShrine, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, arg1), arg2), arg0.admin);
    }

    public entry fun enter_the_covenant(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= arg0.min_bet, 1);
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        if (v1 > 0) {
            assert!(v0 <= v1 * 2000 / 10000, 4);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v2 = CovenantSession{
            id      : 0x2::object::new(arg2),
            player  : 0x2::tx_context::sender(arg2),
            bet     : v0,
            doubled : false,
            active  : true,
        };
        let v3 = CovenantSealed{
            session_id : 0x2::object::id<CovenantSession>(&v2),
            player     : 0x2::tx_context::sender(arg2),
            bet        : v0,
        };
        0x2::event::emit<CovenantSealed>(v3);
        0x2::transfer::transfer<CovenantSession>(v2, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CasinoShrine{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            prize_pool   : 0x2::balance::zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(),
            min_bet      : 10000000000000,
            total_hands  : 0,
            total_volume : 0,
            jackpots_hit : 0,
        };
        0x2::transfer::share_object<CasinoShrine>(v0);
    }

    public entry fun invoke_providence(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg2 <= 3, 6);
        if (arg2 == 2) {
            assert!(arg3 <= 36, 6);
        };
        if (arg2 == 3) {
            assert!(arg3 >= 1 && arg3 <= 3, 6);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = ((make_seed(arg4, v0 ^ v1 % 999999893) % 37) as u8);
        let v3 = if (v2 == 0) {
            0
        } else if (is_red(v2)) {
            1
        } else {
            2
        };
        let (v4, v5) = if (arg2 == 0) {
            if (v3 == 1) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 1) {
            if (v3 == 2) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 2) {
            if (v2 == arg3) {
                let v6 = v0 * 35;
                let v4 = v6;
                if (v6 > v1 / 3) {
                    v4 = v1 / 3;
                };
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v7 = JackpotHit{
                    player : 0x2::tx_context::sender(arg4),
                    bet    : v0,
                    payout : v4,
                    game   : 3,
                };
                0x2::event::emit<JackpotHit>(v7);
                (v4, 2)
            } else {
                (0, 0)
            }
        } else if (arg3 == 1 && v2 >= 1 && v2 <= 12 || arg3 == 2 && v2 >= 13 && v2 <= 24 || v2 >= 25 && v2 <= 36) {
            (v0 + v0 * 18000 / 10000, 1)
        } else {
            (0, 0)
        };
        if (v4 > 0) {
            let v8 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v4, v8, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v9 = WheelOfFateSpun{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            number     : v2,
            colour     : v3,
            bet_type   : arg2,
            bet_value  : arg3,
            result     : v5,
            payout     : v4,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<WheelOfFateSpun>(v9);
    }

    fun is_red(arg0: u8) : bool {
        let v0 = x"01030507090c0e1012131517191b1e202224";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) == arg0) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun make_seed(arg0: &0x2::tx_context::TxContext, arg1: u64) : u64 {
        let v0 = 0x2::tx_context::digest(arg0);
        let v1 = 0x2::address::to_bytes(0x2::tx_context::sender(arg0));
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 ^ (*0x1::vector::borrow<u8>(v0, (v3 as u64)) as u64) << v3 * 8;
            v2 = v4 ^ (*0x1::vector::borrow<u8>(&v1, (v3 as u64)) as u64) << (7 - v3) * 8;
            v3 = v3 + 1;
        };
        v2 ^ arg1
    }

    fun pay_player(arg0: &mut CasinoShrine, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 > 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)) {
            0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
        } else {
            arg1
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v0), arg3), arg2);
        };
    }

    public fun pool_size(arg0: &CasinoShrine) : u64 {
        0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
    }

    public entry fun set_min_bet(arg0: &mut CasinoShrine, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.min_bet = arg1;
    }

    public entry fun the_mountain_judges(arg0: &mut CasinoShrine, arg1: CovenantSession, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg1.active, 3);
        assert!(arg2 <= 6, 5);
        let CovenantSession {
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
            pay_player(arg0, v5, v1, arg3);
            v5
        } else if (arg2 == 1 || arg2 == 4) {
            let v8 = v5 + v5 * 9000 / 10000;
            assert!(v6 >= v8, 4);
            pay_player(arg0, v8, v1, arg3);
            v8
        } else if (arg2 == 2) {
            let v9 = v5 + v5 * 15000 / 10000;
            assert!(v6 >= v9, 4);
            pay_player(arg0, v9, v1, arg3);
            v9
        } else {
            arg0.jackpots_hit = arg0.jackpots_hit + 1;
            let v10 = JackpotHit{
                player : v1,
                bet    : v5,
                payout : v6,
                game   : 0,
            };
            0x2::event::emit<JackpotHit>(v10);
            pay_player(arg0, v6, v1, arg3);
            v6
        };
        let v11 = MountainHasSpoken{
            session_id : 0x2::object::id_from_address(v1),
            player     : v1,
            bet        : v5,
            doubled    : v3,
            result     : arg2,
            payout     : v7,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<MountainHasSpoken>(v11);
    }

    public fun total_hands(arg0: &CasinoShrine) : u64 {
        arg0.total_hands
    }

    // decompiled from Move bytecode v6
}

