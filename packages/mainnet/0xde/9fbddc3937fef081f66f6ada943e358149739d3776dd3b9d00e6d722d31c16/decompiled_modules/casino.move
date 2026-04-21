module 0x9f01c4e45d80a37ef1053b341bbbe5dcc84a02a09e1a7f4fb59e5806b5da22b5::casino {
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

    struct ShekelDropped has copy, drop {
        player: address,
        wager: u64,
        bucket: u8,
        mult_num: u64,
        mult_den: u64,
        payout: u64,
        pool_after: u64,
    }

    struct ShekelDroppedV2 has copy, drop {
        player: address,
        wager: u64,
        rows: u8,
        difficulty: u8,
        bucket: u8,
        mult_num: u64,
        mult_den: u64,
        payout: u64,
        pool_after: u64,
    }

    struct KenoDrawn has copy, drop {
        player: address,
        wager: u64,
        picks: vector<u8>,
        drawn: vector<u8>,
        matches: u8,
        payout: u64,
        pool_after: u64,
    }

    struct PoolDeposited has copy, drop {
        depositor: address,
        amount: u64,
        pool_after: u64,
    }

    struct JuiBurned has copy, drop {
        amount: u64,
        game: u8,
    }

    struct JuiBuyback has copy, drop {
        amount: u64,
        game: u8,
    }

    struct FreeSpinsAccrued has copy, drop {
        amount: u64,
        game: u8,
    }

    struct BuybackKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BurnKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FreespinsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EmergencyWithdraw has copy, drop {
        admin: address,
        amount: u64,
        pool_after: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct JuiBuybackBurned has copy, drop {
        amount: u64,
    }

    struct HouseDistributed has copy, drop {
        burned: u64,
        freespins: u64,
        buyback: u64,
    }

    struct LimboResult has copy, drop {
        player: address,
        wager: u64,
        target_bps: u64,
        result_bps: u64,
        won: bool,
        payout: u64,
        pool_after: u64,
    }

    struct HiLoResult has copy, drop {
        player: address,
        wager: u64,
        card1: u8,
        card2: u8,
        prediction: u8,
        result: u8,
        payout_bps: u64,
        payout: u64,
        pool_after: u64,
    }

    struct HiLoSession has key {
        id: 0x2::object::UID,
        player: address,
        card1: u8,
        wager: u64,
        funds: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
    }

    struct HiLoDeal has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        card1: u8,
    }

    struct HiLoPlayed has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        wager: u64,
        card1: u8,
        card2: u8,
        prediction: u8,
        result: u8,
        payout_bps: u64,
        payout: u64,
        pool_after: u64,
    }

    struct BaccaratResult has copy, drop {
        player: address,
        wager: u64,
        bet_on: u8,
        p_card1: u8,
        p_card2: u8,
        p_card3: u8,
        b_card1: u8,
        b_card2: u8,
        b_card3: u8,
        p_total: u8,
        b_total: u8,
        outcome: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct MinesSession has key {
        id: 0x2::object::UID,
        player: address,
        wager: u64,
        funds: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
        mine_count: u8,
        mines: vector<u8>,
        revealed: vector<u8>,
        cashed_out: bool,
    }

    struct MinesStarted has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        wager: u64,
        mine_count: u8,
    }

    struct MinesRevealed has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        tile: u8,
        is_mine: bool,
        revealed_count: u8,
        payout: u64,
        pool_after: u64,
    }

    struct MinesCashedOut has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        wager: u64,
        revealed_count: u8,
        payout: u64,
        pool_after: u64,
    }

    fun burn_house_cut(arg0: &mut CasinoShrine, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 100 / 10000;
        let v1 = arg1 * 25 / 10000;
        let v2 = arg1 * 25 / 10000;
        let v3 = v0 + v1 + v2;
        if (v3 == 0 || 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) < 1000000000000000 + v3) {
            return
        };
        let v4 = 0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v0);
        let v5 = 0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v1);
        let v6 = 0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v2);
        let v7 = BurnKey{dummy_field: false};
        df_accumulate<BurnKey>(arg0, v7, v4);
        let v8 = BuybackKey{dummy_field: false};
        df_accumulate<BuybackKey>(arg0, v8, v5);
        let v9 = FreespinsKey{dummy_field: false};
        df_accumulate<FreespinsKey>(arg0, v9, v6);
        let v10 = JuiBurned{
            amount : v0,
            game   : arg2,
        };
        0x2::event::emit<JuiBurned>(v10);
        let v11 = JuiBuyback{
            amount : v1,
            game   : arg2,
        };
        0x2::event::emit<JuiBuyback>(v11);
        let v12 = FreeSpinsAccrued{
            amount : v2,
            game   : arg2,
        };
        0x2::event::emit<FreeSpinsAccrued>(v12);
    }

    public fun buyback_reserve_size(arg0: &CasinoShrine) : u64 {
        let v0 = BuybackKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<BuybackKey>(&arg0.id, v0)) {
            let v2 = BuybackKey{dummy_field: false};
            0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::dynamic_field::borrow<BuybackKey, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&arg0.id, v2))
        } else {
            0
        }
    }

    fun card_value(arg0: u8) : u8 {
        if (arg0 >= 10) {
            0
        } else {
            arg0
        }
    }

    public entry fun cast_the_dice(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 <= 3, 6);
        if (arg3 == 3) {
            assert!(arg4 >= 2 && arg4 <= 12, 6);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = 0x2::random::generate_u64(&mut v2) % 36;
        let v4 = ((v3 / 6) as u8) + 1 + ((v3 % 6) as u8) + 1;
        let (v5, v6) = if (arg3 == 0) {
            if (v4 < 7) {
                (v0 + v0 * 12800 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 1) {
            if (v4 > 7) {
                (v0 + v0 * 12800 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 2) {
            if (v4 == 7) {
                let v7 = v0 * 57000 / 10000;
                let v5 = v7;
                if (v7 > v1 / 10) {
                    v5 = v1 / 10;
                };
                (v5, 1)
            } else {
                (0, 0)
            }
        } else if (v4 == arg4) {
            let v8 = if (arg4 == 2 || arg4 == 12) {
                340000
            } else if (arg4 == 3 || arg4 == 11) {
                170000
            } else if (arg4 == 4 || arg4 == 10) {
                110000
            } else if (arg4 == 5 || arg4 == 9) {
                85000
            } else if (arg4 == 6 || arg4 == 8) {
                65000
            } else {
                57000
            };
            let v9 = v0 * v8 / 10000;
            let v5 = v9;
            if (v9 > v1 / 10) {
                let v10 = v1 / 10;
                v5 = v10;
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v11 = JackpotHit{
                    player : 0x2::tx_context::sender(arg5),
                    bet    : v0,
                    payout : v10,
                    game   : 2,
                };
                0x2::event::emit<JackpotHit>(v11);
            };
            (v5, 2)
        } else {
            (0, 0)
        };
        burn_house_cut(arg0, v0, 2, arg5);
        if (v5 > 0) {
            let v12 = 0x2::tx_context::sender(arg5);
            pay_player(arg0, v5, v12, arg5);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v13 = LotsCast{
            player     : 0x2::tx_context::sender(arg5),
            wager      : v0,
            roll       : v4,
            prediction : arg3,
            target     : arg4,
            result     : v6,
            payout     : v5,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<LotsCast>(v13);
    }

    fun comb(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg1 == arg0) {
            return 1
        };
        let v0 = if (arg1 > arg0 - arg1) {
            arg0 - arg1
        } else {
            arg1
        };
        let v1 = 1;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v1 * (arg0 - v2);
            v1 = v3 / (v2 + 1);
            v2 = v2 + 1;
        };
        v1
    }

    public entry fun consult_the_oracle(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = 0x2::random::new_generator(arg1, arg3);
        let v3 = x"000101020203030404050506";
        let v4 = *0x1::vector::borrow<u8>(&v3, ((0x2::random::generate_u64(&mut v2) % 12) as u64));
        let v5 = *0x1::vector::borrow<u8>(&v3, ((0x2::random::generate_u64(&mut v2) % 12) as u64));
        let v6 = *0x1::vector::borrow<u8>(&v3, ((0x2::random::generate_u64(&mut v2) % 12) as u64));
        let (v7, v8) = if (v4 == v5 && v5 == v6) {
            if (v4 == 0) {
                let v9 = 500000000000000;
                let v10 = v1 / 10;
                let v11 = if (v10 < v9) {
                    v10
                } else {
                    v9
                };
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v12 = JackpotHit{
                    player : 0x2::tx_context::sender(arg3),
                    bet    : v0,
                    payout : v11,
                    game   : 1,
                };
                0x2::event::emit<JackpotHit>(v12);
                (v11, 4)
            } else if (v4 == 6) {
                (v0 * 10, 3)
            } else if (v4 == 5 || v4 == 4) {
                (v0 * 5, 2)
            } else {
                (v0 * 2, 1)
            }
        } else {
            let v13 = if (v4 == v5) {
                true
            } else if (v5 == v6) {
                true
            } else {
                v4 == v6
            };
            if (v13) {
                (v0 + v0 / 2, 1)
            } else {
                (0, 0)
            }
        };
        burn_house_cut(arg0, v0, 1, arg3);
        if (v7 > 0) {
            let v14 = 0x2::tx_context::sender(arg3);
            pay_player(arg0, v7, v14, arg3);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v15 = if (v7 > v1) {
            v1
        } else {
            v7
        };
        let v16 = OracleConsulted{
            player     : 0x2::tx_context::sender(arg3),
            wager      : v0,
            reel0      : v4,
            reel1      : v5,
            reel2      : v6,
            result     : v8,
            payout     : v15,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<OracleConsulted>(v16);
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

    fun df_accumulate<T0: copy + drop + store>(arg0: &mut CasinoShrine, arg1: T0, arg2: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>) {
        if (0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)) {
            0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::dynamic_field::borrow_mut<T0, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, arg1), arg2);
        } else {
            0x2::dynamic_field::add<T0, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, arg1, arg2);
        };
    }

    public entry fun double_the_offering(arg0: &mut CasinoShrine, arg1: &mut CovenantSession, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 3);
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) == arg1.bet, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        arg1.doubled = true;
    }

    public entry fun drop_shekel(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = 0x2::random::new_generator(arg1, arg3);
        let v3 = 0x2::random::generate_u64(&mut v2) % 65536;
        let v4 = if (v3 < 17) {
            0
        } else if (v3 < 697) {
            1
        } else if (v3 < 6885) {
            2
        } else if (v3 < 26333) {
            3
        } else if (v3 < 39203) {
            4
        } else if (v3 < 58651) {
            5
        } else if (v3 < 64839) {
            6
        } else if (v3 < 65519) {
            7
        } else {
            8
        };
        let v5 = v4 == 0 || v4 == 8;
        let v6 = v4 == 1 || v4 == 7;
        let v7 = v4 == 2 || v4 == 6;
        let v8 = v4 == 3 || v4 == 5;
        let (v9, v10) = if (v5) {
            (1, 47)
        } else if (v6) {
            (1, 4)
        } else if (v7) {
            (1, 2)
        } else if (v8) {
            (10, 7)
        } else {
            (5, 1)
        };
        let v11 = v0 * v10 / v9;
        let v12 = v11;
        if (v11 > v1 / 10) {
            let v13 = v1 / 10;
            v12 = v13;
            if (v13 > 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v14 = JackpotHit{
                    player : 0x2::tx_context::sender(arg3),
                    bet    : v0,
                    payout : v13,
                    game   : 4,
                };
                0x2::event::emit<JackpotHit>(v14);
            };
        };
        burn_house_cut(arg0, v0, 4, arg3);
        if (v12 > 0) {
            let v15 = 0x2::tx_context::sender(arg3);
            pay_player(arg0, v12, v15, arg3);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v16 = ShekelDropped{
            player     : 0x2::tx_context::sender(arg3),
            wager      : v0,
            bucket     : v4,
            mult_num   : v10,
            mult_den   : v9,
            payout     : v12,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<ShekelDropped>(v16);
    }

    public entry fun drop_shekel_v2(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        let v1 = if (arg3 == 8) {
            true
        } else if (arg3 == 10) {
            true
        } else if (arg3 == 12) {
            true
        } else if (arg3 == 14) {
            true
        } else {
            arg3 == 16
        };
        assert!(v1, 7);
        assert!(arg4 <= 2, 8);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v2 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v3 = 0x2::random::new_generator(arg1, arg5);
        let v4 = 0x2::random::generate_u64(&mut v3) % 65536;
        let v5 = if (arg3 == 8) {
            if (v4 < 256) {
                0
            } else if (v4 < 2304) {
                1
            } else if (v4 < 9472) {
                2
            } else if (v4 < 23808) {
                3
            } else if (v4 < 41728) {
                4
            } else if (v4 < 56064) {
                5
            } else if (v4 < 63232) {
                6
            } else if (v4 < 65280) {
                7
            } else {
                8
            }
        } else if (arg3 == 10) {
            if (v4 < 704) {
                0
            } else if (v4 < 3584) {
                1
            } else if (v4 < 11264) {
                2
            } else if (v4 < 24064) {
                3
            } else if (v4 < 36864) {
                4
            } else if (v4 < 49664) {
                5
            } else if (v4 < 61440) {
                6
            } else if (v4 < 64832) {
                7
            } else {
                8
            }
        } else if (arg3 == 12) {
            if (v4 < 1264) {
                0
            } else if (v4 < 4784) {
                1
            } else if (v4 < 12704) {
                2
            } else if (v4 < 25376) {
                3
            } else if (v4 < 40160) {
                4
            } else if (v4 < 52832) {
                5
            } else if (v4 < 60752) {
                6
            } else if (v4 < 64272) {
                7
            } else {
                8
            }
        } else if (arg3 == 14) {
            if (v4 < 1880) {
                0
            } else if (v4 < 5884) {
                1
            } else if (v4 < 13892) {
                2
            } else if (v4 < 25904) {
                3
            } else if (v4 < 39632) {
                4
            } else if (v4 < 51644) {
                5
            } else if (v4 < 59652) {
                6
            } else if (v4 < 63656) {
                7
            } else {
                8
            }
        } else if (v4 < 17) {
            0
        } else if (v4 < 697) {
            1
        } else if (v4 < 6885) {
            2
        } else if (v4 < 26333) {
            3
        } else if (v4 < 39203) {
            4
        } else if (v4 < 58651) {
            5
        } else if (v4 < 64839) {
            6
        } else if (v4 < 65519) {
            7
        } else {
            8
        };
        let v6 = v5 == 0 || v5 == 8;
        let v7 = v5 == 1 || v5 == 7;
        let v8 = v5 == 2 || v5 == 6;
        let v9 = v5 == 3 || v5 == 5;
        let (v10, v11) = if (arg4 == 0) {
            if (arg3 == 8) {
                if (v6) {
                    (10, 83)
                } else if (v7) {
                    (10, 26)
                } else if (v8) {
                    (10, 14)
                } else if (v9) {
                    (100, 62)
                } else {
                    (100, 52)
                }
            } else if (arg3 == 10) {
                if (v6) {
                    (10, 66)
                } else if (v7) {
                    (10, 21)
                } else if (v8) {
                    (10, 12)
                } else if (v9) {
                    (10, 5)
                } else {
                    (100, 41)
                }
            } else if (arg3 == 12) {
                if (v6) {
                    (10, 61)
                } else if (v7) {
                    (10, 19)
                } else if (v8) {
                    (10, 11)
                } else if (v9) {
                    (100, 46)
                } else {
                    (100, 38)
                }
            } else if (arg3 == 14) {
                if (v6) {
                    (10, 54)
                } else if (v7) {
                    (10, 17)
                } else if (v8) {
                    (100, 94)
                } else if (v9) {
                    (10, 4)
                } else {
                    (100, 34)
                }
            } else if (v6) {
                (10, 32)
            } else if (v7) {
                (10, 18)
            } else if (v8) {
                (10, 13)
            } else if (v9) {
                (100, 98)
            } else {
                (100, 76)
            }
        } else if (arg4 == 1) {
            if (arg3 == 8) {
                if (v6) {
                    (10, 204)
                } else if (v7) {
                    (10, 34)
                } else if (v8) {
                    (10, 17)
                } else if (v9) {
                    (100, 34)
                } else {
                    (100, 25)
                }
            } else if (arg3 == 10) {
                if (v6) {
                    (10, 150)
                } else if (v7) {
                    (10, 24)
                } else if (v8) {
                    (10, 13)
                } else if (v9) {
                    (100, 24)
                } else {
                    (100, 19)
                }
            } else if (arg3 == 12) {
                if (v6) {
                    (10, 112)
                } else if (v7) {
                    (10, 19)
                } else if (v8) {
                    (100, 93)
                } else if (v9) {
                    (100, 19)
                } else {
                    (100, 14)
                }
            } else if (arg3 == 14) {
                if (v6) {
                    (10, 89)
                } else if (v7) {
                    (10, 15)
                } else if (v8) {
                    (100, 75)
                } else if (v9) {
                    (100, 15)
                } else {
                    (100, 11)
                }
            } else if (v6) {
                (10, 70)
            } else if (v7) {
                (10, 29)
            } else if (v8) {
                (10, 15)
            } else if (v9) {
                (100, 82)
            } else {
                (100, 64)
            }
        } else if (arg3 == 8) {
            if (v6) {
                (10, 340)
            } else if (v7) {
                (10, 51)
            } else if (v8) {
                (10, 17)
            } else if (v9) {
                (100, 12)
            } else {
                (100, 5)
            }
        } else if (arg3 == 10) {
            if (v6) {
                (10, 195)
            } else if (v7) {
                (10, 30)
            } else if (v8) {
                (100, 98)
            } else if (v9) {
                (100, 6)
            } else {
                (100, 3)
            }
        } else if (arg3 == 12) {
            if (v6) {
                (10, 148)
            } else if (v7) {
                (10, 22)
            } else if (v8) {
                (100, 74)
            } else if (v9) {
                (100, 5)
            } else {
                (100, 2)
            }
        } else if (arg3 == 14) {
            if (v6) {
                (10, 113)
            } else if (v7) {
                (10, 17)
            } else if (v8) {
                (100, 57)
            } else if (v9) {
                (100, 4)
            } else {
                (100, 2)
            }
        } else if (v6) {
            (10, 127)
        } else if (v7) {
            (10, 42)
        } else if (v8) {
            (10, 19)
        } else if (v9) {
            (100, 74)
        } else {
            (100, 57)
        };
        let v12 = v0 * v11 / v10;
        let v13 = v12;
        if (v12 > v2 / 10) {
            let v14 = v2 / 10;
            v13 = v14;
            if (v14 > 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v15 = JackpotHit{
                    player : 0x2::tx_context::sender(arg5),
                    bet    : v0,
                    payout : v14,
                    game   : 4,
                };
                0x2::event::emit<JackpotHit>(v15);
            };
        };
        burn_house_cut(arg0, v0, 4, arg5);
        if (v13 > 0) {
            let v16 = 0x2::tx_context::sender(arg5);
            pay_player(arg0, v13, v16, arg5);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v17 = ShekelDroppedV2{
            player     : 0x2::tx_context::sender(arg5),
            wager      : v0,
            rows       : arg3,
            difficulty : arg4,
            bucket     : v5,
            mult_num   : v11,
            mult_den   : v10,
            payout     : v13,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<ShekelDroppedV2>(v17);
    }

    public entry fun emergency_withdraw(arg0: &mut CasinoShrine, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        assert!(v1 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v1), arg2), arg0.admin);
        let v2 = EmergencyWithdraw{
            admin      : arg0.admin,
            amount     : v1,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<EmergencyWithdraw>(v2);
    }

    public entry fun enter_the_covenant(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= arg0.min_bet, 1);
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        if (v1 > 0) {
            assert!(v0 <= v1 * 500 / 10000, 4);
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
        0x2::transfer::share_object<CovenantSession>(v2);
    }

    public entry fun execute_buyback_burn(arg0: &mut CasinoShrine, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = BuybackKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BuybackKey>(&arg0.id, v0)) {
            return
        };
        let v1 = BuybackKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BuybackKey, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v2);
        if (v3 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v2, v3), arg1), @0x0);
        let v4 = JuiBuybackBurned{amount: v3};
        0x2::event::emit<JuiBuybackBurned>(v4);
    }

    public entry fun execute_house_distributions(arg0: &mut CasinoShrine, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        let v0 = BurnKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<BurnKey>(&arg0.id, v0)) {
            let v2 = BurnKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<BurnKey, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, v2);
            let v4 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v3);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v3, v4), arg1), @0x0);
                let v5 = JuiBuybackBurned{amount: v4};
                0x2::event::emit<JuiBuybackBurned>(v5);
            };
            v4
        } else {
            0
        };
        let v6 = FreespinsKey{dummy_field: false};
        let v7 = if (0x2::dynamic_field::exists_<FreespinsKey>(&arg0.id, v6)) {
            let v8 = FreespinsKey{dummy_field: false};
            let v9 = 0x2::dynamic_field::borrow_mut<FreespinsKey, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, v8);
            let v10 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v9);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v9, v10), arg1), @0x1d0b928283710e702c5d1a5e4b4de6eb07705bd347c43400ae24dfa7df927f11);
            };
            v10
        } else {
            0
        };
        let v11 = BuybackKey{dummy_field: false};
        let v12 = if (0x2::dynamic_field::exists_<BuybackKey>(&arg0.id, v11)) {
            let v13 = BuybackKey{dummy_field: false};
            let v14 = 0x2::dynamic_field::borrow_mut<BuybackKey, 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, v13);
            let v15 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v14);
            if (v15 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v14, v15), arg1), @0x0);
            };
            v15
        } else {
            0
        };
        let v16 = if (v1 > 0) {
            true
        } else if (v7 > 0) {
            true
        } else {
            v12 > 0
        };
        if (v16) {
            let v17 = HouseDistributed{
                burned    : v1,
                freespins : v7,
                buyback   : v12,
            };
            0x2::event::emit<HouseDistributed>(v17);
        };
    }

    fun hand_total(arg0: u8, arg1: u8, arg2: u8) : u8 {
        ((((card_value(arg0) as u64) + (card_value(arg1) as u64) + (card_value(arg2) as u64)) % 10) as u8)
    }

    public entry fun hilo_deal(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v3 = HiLoSession{
            id     : 0x2::object::new(arg3),
            player : 0x2::tx_context::sender(arg3),
            card1  : v2,
            wager  : v0,
            funds  : 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2),
        };
        let v4 = HiLoDeal{
            session_id : 0x2::object::id<HiLoSession>(&v3),
            player     : 0x2::tx_context::sender(arg3),
            card1      : v2,
        };
        0x2::event::emit<HiLoDeal>(v4);
        0x2::transfer::transfer<HiLoSession>(v3, 0x2::tx_context::sender(arg3));
    }

    public entry fun hilo_play_v2(arg0: &mut CasinoShrine, arg1: HiLoSession, arg2: &0x2::random::Random, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 2, 6);
        let HiLoSession {
            id     : v0,
            player : v1,
            card1  : v2,
            wager  : v3,
            funds  : v4,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::tx_context::sender(arg4), 0);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v4);
        let v5 = 0x2::random::new_generator(arg2, arg4);
        let v6 = ((0x2::random::generate_u64(&mut v5) % 13) as u8) + 1;
        let v7 = 0;
        let (v8, v9) = if (arg3 == 0 && v2 == 13 || arg3 == 1 && v2 == 1) {
            pay_player(arg0, v3, v1, arg4);
            v7 = v3;
            (100, 2)
        } else if (arg3 == 2) {
            if (v6 == v2) {
                let v10 = v3 * 12;
                let v11 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v12 = if (v10 > v11) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v13 = JackpotHit{
                        player : v1,
                        bet    : v3,
                        payout : v11,
                        game   : 8,
                    };
                    0x2::event::emit<JackpotHit>(v13);
                    v11
                } else {
                    v10
                };
                v7 = v12;
                if (v12 > 0) {
                    pay_player(arg0, v12, v1, arg4);
                };
                (1200, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 0) {
            let v14 = 126100 / ((13 - v2) as u64) * 100;
            let v9 = if (v6 > v2) {
                let v15 = v3 * v14 / 100;
                let v16 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v17 = if (v15 > v16) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v18 = JackpotHit{
                        player : v1,
                        bet    : v3,
                        payout : v16,
                        game   : 8,
                    };
                    0x2::event::emit<JackpotHit>(v18);
                    v16
                } else {
                    v15
                };
                v7 = v17;
                if (v17 > 0) {
                    pay_player(arg0, v17, v1, arg4);
                };
                1
            } else {
                0
            };
            (v14, v9)
        } else {
            let v19 = 126100 / ((v2 - 1) as u64) * 100;
            let v9 = if (v6 < v2) {
                let v20 = v3 * v19 / 100;
                let v21 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v22 = if (v20 > v21) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v23 = JackpotHit{
                        player : v1,
                        bet    : v3,
                        payout : v21,
                        game   : 8,
                    };
                    0x2::event::emit<JackpotHit>(v23);
                    v21
                } else {
                    v20
                };
                v7 = v22;
                if (v22 > 0) {
                    pay_player(arg0, v22, v1, arg4);
                };
                1
            } else {
                0
            };
            (v19, v9)
        };
        burn_house_cut(arg0, v3, 8, arg4);
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v3;
        let v24 = HiLoPlayed{
            session_id : 0x2::object::id_from_address(@0x0),
            player     : v1,
            wager      : v3,
            card1      : v2,
            card2      : v6,
            prediction : arg3,
            result     : v9,
            payout_bps : v8,
            payout     : v7,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<HiLoPlayed>(v24);
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

    public entry fun invoke_providence(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 <= 8, 6);
        if (arg3 == 2) {
            assert!(arg4 <= 36, 6);
        };
        if (arg3 == 3) {
            assert!(arg4 >= 1 && arg4 <= 3, 6);
        };
        if (arg3 == 8) {
            assert!(arg4 >= 1 && arg4 <= 3, 6);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = ((0x2::random::generate_u64(&mut v2) % 37) as u8);
        let v4 = if (v3 == 0) {
            0
        } else if (is_red(v3)) {
            1
        } else {
            2
        };
        let (v5, v6) = if (arg3 == 0) {
            if (v4 == 1) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 1) {
            if (v4 == 2) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 2) {
            if (v3 == arg4) {
                let v7 = v0 * 35;
                let v5 = v7;
                if (v7 > v1 / 10) {
                    let v8 = v1 / 10;
                    v5 = v8;
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v9 = JackpotHit{
                        player : 0x2::tx_context::sender(arg5),
                        bet    : v0,
                        payout : v8,
                        game   : 3,
                    };
                    0x2::event::emit<JackpotHit>(v9);
                };
                (v5, 2)
            } else {
                (0, 0)
            }
        } else if (arg3 == 3) {
            if (arg4 == 1 && v3 >= 1 && v3 <= 12 || arg4 == 2 && v3 >= 13 && v3 <= 24 || v3 >= 25 && v3 <= 36) {
                (v0 + v0 * 18000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 4) {
            if (v3 != 0 && v3 % 2 == 1) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 5) {
            if (v3 != 0 && v3 % 2 == 0) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 6) {
            if (v3 >= 1 && v3 <= 18) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 7) {
            if (v3 >= 19 && v3 <= 36) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (v3 != 0 && (arg4 == 1 && v3 % 3 == 1 || arg4 == 2 && v3 % 3 == 2 || v3 % 3 == 0)) {
            (v0 + v0 * 18000 / 10000, 1)
        } else {
            (0, 0)
        };
        burn_house_cut(arg0, v0, 3, arg5);
        if (v5 > 0) {
            let v10 = 0x2::tx_context::sender(arg5);
            pay_player(arg0, v5, v10, arg5);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v11 = WheelOfFateSpun{
            player     : 0x2::tx_context::sender(arg5),
            wager      : v0,
            number     : v3,
            colour     : v4,
            bet_type   : arg3,
            bet_value  : arg4,
            result     : v6,
            payout     : v5,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<WheelOfFateSpun>(v11);
    }

    fun is_mine(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
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

    fun is_revealed(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun keno_payout(arg0: u64, arg1: u8) : u64 {
        let v0 = (arg1 as u64);
        if (arg0 == 1) {
            if (v0 == 1) {
                28000
            } else {
                0
            }
        } else if (arg0 == 2) {
            if (v0 == 2) {
                60000
            } else {
                0
            }
        } else if (arg0 == 3) {
            if (v0 == 2) {
                10000
            } else if (v0 == 3) {
                250000
            } else {
                0
            }
        } else if (arg0 == 4) {
            if (v0 == 2) {
                5000
            } else if (v0 == 3) {
                30000
            } else if (v0 == 4) {
                600000
            } else {
                0
            }
        } else if (arg0 == 5) {
            if (v0 == 3) {
                10000
            } else if (v0 == 4) {
                90000
            } else if (v0 == 5) {
                800000
            } else {
                0
            }
        } else if (arg0 == 6) {
            if (v0 == 3) {
                5000
            } else if (v0 == 4) {
                20000
            } else if (v0 == 5) {
                500000
            } else if (v0 == 6) {
                2000000
            } else {
                0
            }
        } else if (arg0 == 7) {
            if (v0 == 3) {
                3000
            } else if (v0 == 4) {
                10000
            } else if (v0 == 5) {
                80000
            } else if (v0 == 6) {
                700000
            } else if (v0 == 7) {
                5000000
            } else {
                0
            }
        } else if (arg0 == 8) {
            if (v0 == 4) {
                5000
            } else if (v0 == 5) {
                30000
            } else if (v0 == 6) {
                200000
            } else if (v0 == 7) {
                1000000
            } else if (v0 == 8) {
                10000000
            } else {
                0
            }
        } else if (arg0 == 9) {
            if (v0 == 4) {
                2000
            } else if (v0 == 5) {
                15000
            } else if (v0 == 6) {
                80000
            } else if (v0 == 7) {
                500000
            } else if (v0 == 8) {
                3000000
            } else if (v0 == 9) {
                25000000
            } else {
                0
            }
        } else if (v0 == 4) {
            1000
        } else if (v0 == 5) {
            10000
        } else if (v0 == 6) {
            50000
        } else if (v0 == 7) {
            300000
        } else if (v0 == 8) {
            2000000
        } else if (v0 == 9) {
            15000000
        } else if (v0 == 10) {
            100000000
        } else {
            0
        }
    }

    public entry fun mines_cashout(arg0: &mut CasinoShrine, arg1: MinesSession, arg2: &mut 0x2::tx_context::TxContext) {
        let MinesSession {
            id         : v0,
            player     : v1,
            wager      : v2,
            funds      : v3,
            mine_count : v4,
            mines      : _,
            revealed   : v6,
            cashed_out : v7,
        } = arg1;
        let v8 = v6;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::tx_context::sender(arg2), 0);
        assert!(!v7, 3);
        let v9 = (0x1::vector::length<u8>(&v8) as u8);
        assert!(v9 > 0, 6);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v3);
        let v10 = mines_payout(v2, v4, v9);
        let v11 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
        let v12 = if (v10 > v11) {
            v11
        } else {
            v10
        };
        if (v12 > 0) {
            pay_player(arg0, v12, v1, arg2);
        };
        burn_house_cut(arg0, v2, 10, arg2);
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v2;
        let v13 = MinesCashedOut{
            session_id     : 0x2::object::id_from_address(@0x0),
            player         : v1,
            wager          : v2,
            revealed_count : v9,
            payout         : v12,
            pool_after     : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<MinesCashedOut>(v13);
    }

    fun mines_payout(arg0: u64, arg1: u8, arg2: u8) : u64 {
        let v0 = (arg1 as u64);
        let v1 = comb(25 - (arg2 as u64), v0);
        if (v1 == 0) {
            return arg0 * 50
        };
        let v2 = comb(25, v0) / v1;
        let v3 = if (v2 > 5208) {
            5208
        } else {
            v2
        };
        arg0 / 10000 * v3 * 9600
    }

    public entry fun mines_reveal(arg0: &mut CasinoShrine, arg1: &mut MinesSession, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(!arg1.cashed_out, 3);
        assert!(arg2 < 25, 6);
        assert!(!is_revealed(&arg1.revealed, arg2), 6);
        if (is_mine(&arg1.mines, arg2)) {
            arg1.cashed_out = true;
            0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::balance::withdraw_all<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.funds));
            burn_house_cut(arg0, arg1.wager, 10, arg3);
            arg0.total_hands = arg0.total_hands + 1;
            arg0.total_volume = arg0.total_volume + arg1.wager;
            let v0 = MinesRevealed{
                session_id     : 0x2::object::id<MinesSession>(arg1),
                player         : 0x2::tx_context::sender(arg3),
                tile           : arg2,
                is_mine        : true,
                revealed_count : (0x1::vector::length<u8>(&arg1.revealed) as u8),
                payout         : 0,
                pool_after     : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
            };
            0x2::event::emit<MinesRevealed>(v0);
        } else {
            0x1::vector::push_back<u8>(&mut arg1.revealed, arg2);
            let v1 = (0x1::vector::length<u8>(&arg1.revealed) as u8);
            let v2 = mines_payout(arg1.wager, arg1.mine_count, v1);
            let v3 = (0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) + 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.funds)) / 10;
            let v4 = if (v2 > v3) {
                v3
            } else {
                v2
            };
            let v5 = MinesRevealed{
                session_id     : 0x2::object::id<MinesSession>(arg1),
                player         : 0x2::tx_context::sender(arg3),
                tile           : arg2,
                is_mine        : false,
                revealed_count : v1,
                payout         : v4,
                pool_after     : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
            };
            0x2::event::emit<MinesRevealed>(v5);
        };
    }

    public entry fun mines_start(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 >= 1 && arg3 <= 24, 6);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = &mut v1;
        let v3 = MinesSession{
            id         : 0x2::object::new(arg4),
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            funds      : 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2),
            mine_count : arg3,
            mines      : place_mines(v2, arg3),
            revealed   : b"",
            cashed_out : false,
        };
        let v4 = MinesStarted{
            session_id : 0x2::object::id<MinesSession>(&v3),
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            mine_count : arg3,
        };
        0x2::event::emit<MinesStarted>(v4);
        0x2::transfer::transfer<MinesSession>(v3, 0x2::tx_context::sender(arg4));
    }

    fun pay_player(arg0: &mut CasinoShrine, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v1 = if (v0 > 1000000000000000) {
            v0 - 1000000000000000
        } else {
            0
        };
        let v2 = if (arg1 > v1) {
            v1
        } else {
            arg1
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v2), arg3), arg2);
        };
    }

    fun place_mines(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = ((v2 + ((0x2::random::generate_u64(arg0) % ((25 - v2) as u64)) as u8)) as u64);
            *0x1::vector::borrow_mut<u8>(&mut v0, (v2 as u64)) = *0x1::vector::borrow<u8>(&v0, v3);
            *0x1::vector::borrow_mut<u8>(&mut v0, v3) = *0x1::vector::borrow<u8>(&v0, (v2 as u64));
            v2 = v2 + 1;
        };
        let v4 = b"";
        let v5 = 0;
        while (v5 < (arg1 as u64)) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public entry fun play_baccarat(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 <= 2, 6);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v3 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v4 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v5 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v6 = (card_value(v2) + card_value(v4)) % 10;
        let v7 = (card_value(v3) + card_value(v5)) % 10;
        let v8 = v6 >= 8 || v7 >= 8;
        let v9 = 0;
        let v10 = 0;
        if (!v8) {
            if (v6 <= 5) {
                v9 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
            };
            if (v9 == 0) {
                if (v7 <= 5) {
                    v10 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
                };
            } else {
                let v11 = card_value(v9);
                if (v7 <= 2 || v7 == 3 && v11 != 8 || v7 == 4 && v11 >= 2 && v11 <= 7 || v7 == 5 && v11 >= 4 && v11 <= 7 || v7 == 6 && (v11 == 6 || v11 == 7)) {
                    v10 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
                };
            };
        };
        let v12 = hand_total(v2, v4, v9);
        let v13 = hand_total(v3, v5, v10);
        let v14 = if (v12 > v13) {
            0
        } else if (v13 > v12) {
            1
        } else {
            2
        };
        let v15 = 0;
        let v16 = if (v14 == 2) {
            if (arg3 == 2) {
                let v17 = v0 * 8;
                let v18 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v19 = if (v17 > v18) {
                    v18
                } else {
                    v17
                };
                v15 = v19;
                if (v19 > 0) {
                    let v20 = 0x2::tx_context::sender(arg4);
                    pay_player(arg0, v19, v20, arg4);
                };
                1
            } else {
                let v21 = 0x2::tx_context::sender(arg4);
                pay_player(arg0, v0, v21, arg4);
                v15 = v0;
                2
            }
        } else if (arg3 == (v14 as u8)) {
            if (arg3 == 0) {
                let v22 = v0 * 190 / 100;
                let v23 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v24 = if (v22 > v23) {
                    v23
                } else {
                    v22
                };
                v15 = v24;
            } else {
                let v25 = v0 * 185 / 100;
                let v26 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v27 = if (v25 > v26) {
                    v26
                } else {
                    v25
                };
                v15 = v27;
            };
            if (v15 > 0) {
                let v28 = 0x2::tx_context::sender(arg4);
                pay_player(arg0, v15, v28, arg4);
            };
            1
        } else {
            0
        };
        burn_house_cut(arg0, v0, 9, arg4);
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v29 = BaccaratResult{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            bet_on     : arg3,
            p_card1    : v2,
            p_card2    : v4,
            p_card3    : v9,
            b_card1    : v3,
            b_card2    : v5,
            b_card3    : v10,
            p_total    : v12,
            b_total    : v13,
            outcome    : v14,
            result     : v16,
            payout     : v15,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<BaccaratResult>(v29);
    }

    public entry fun play_hilo(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 <= 2, 6);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v3 = ((0x2::random::generate_u64(&mut v1) % 13) as u8) + 1;
        let v4 = 0;
        let v5 = arg3 == 0 && v2 == 13 || arg3 == 1 && v2 == 1;
        let (v6, v7) = if (v5) {
            let v8 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v0, v8, arg4);
            v4 = v0;
            (100, 2)
        } else if (arg3 == 2) {
            if (v3 == v2) {
                let v9 = v0 * 12;
                let v10 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v11 = if (v9 > v10) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v12 = JackpotHit{
                        player : 0x2::tx_context::sender(arg4),
                        bet    : v0,
                        payout : v10,
                        game   : 7,
                    };
                    0x2::event::emit<JackpotHit>(v12);
                    v10
                } else {
                    v9
                };
                v4 = v11;
                if (v11 > 0) {
                    let v13 = 0x2::tx_context::sender(arg4);
                    pay_player(arg0, v11, v13, arg4);
                };
                (1200, 1)
            } else {
                (0, 0)
            }
        } else if (arg3 == 0) {
            let v14 = 126100 / ((13 - v2) as u64) * 100;
            let v7 = if (v3 > v2) {
                let v15 = v0 * v14 / 100;
                let v16 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v17 = if (v15 > v16) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v18 = JackpotHit{
                        player : 0x2::tx_context::sender(arg4),
                        bet    : v0,
                        payout : v16,
                        game   : 7,
                    };
                    0x2::event::emit<JackpotHit>(v18);
                    v16
                } else {
                    v15
                };
                v4 = v17;
                if (v17 > 0) {
                    let v19 = 0x2::tx_context::sender(arg4);
                    pay_player(arg0, v17, v19, arg4);
                };
                1
            } else {
                0
            };
            (v14, v7)
        } else {
            let v20 = 126100 / ((v2 - 1) as u64) * 100;
            let v7 = if (v3 < v2) {
                let v21 = v0 * v20 / 100;
                let v22 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
                let v23 = if (v21 > v22) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v24 = JackpotHit{
                        player : 0x2::tx_context::sender(arg4),
                        bet    : v0,
                        payout : v22,
                        game   : 7,
                    };
                    0x2::event::emit<JackpotHit>(v24);
                    v22
                } else {
                    v21
                };
                v4 = v23;
                if (v23 > 0) {
                    let v25 = 0x2::tx_context::sender(arg4);
                    pay_player(arg0, v23, v25, arg4);
                };
                1
            } else {
                0
            };
            (v20, v7)
        };
        if (!v5) {
            burn_house_cut(arg0, v0, 7, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v26 = HiLoResult{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            card1      : v2,
            card2      : v3,
            prediction : arg3,
            result     : v7,
            payout_bps : v6,
            payout     : v4,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<HiLoResult>(v26);
    }

    public entry fun play_keno(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v1 >= 1 && v1 <= 10, 6);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg3, v2);
            assert!(v3 >= 1 && v3 <= 40, 6);
            let v4 = v2 + 1;
            while (v4 < v1) {
                assert!(*0x1::vector::borrow<u8>(&arg3, v4) != v3, 6);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v5 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v6 = 0x2::random::new_generator(arg1, arg4);
        let v7 = b"";
        let v8 = 0x2::random::generate_u64(&mut v6);
        let v9 = 0;
        while (0x1::vector::length<u8>(&v7) < 10 && v9 < 200) {
            let v10 = v8 ^ v8 << 13 ^ v8 >> 7 ^ v8 << 17;
            v8 = v10;
            let v11 = ((v10 % 40) as u8) + 1;
            let v12 = false;
            let v13 = 0;
            while (v13 < 0x1::vector::length<u8>(&v7)) {
                if (*0x1::vector::borrow<u8>(&v7, v13) == v11) {
                    v12 = true;
                    break
                };
                v13 = v13 + 1;
            };
            if (!v12) {
                0x1::vector::push_back<u8>(&mut v7, v11);
            };
            v9 = v9 + 1;
        };
        let v14 = 0;
        let v15 = 0;
        while (v15 < v1) {
            let v16 = 0;
            while (v16 < 0x1::vector::length<u8>(&v7)) {
                if (*0x1::vector::borrow<u8>(&v7, v16) == *0x1::vector::borrow<u8>(&arg3, v15)) {
                    v14 = v14 + 1;
                    break
                };
                v16 = v16 + 1;
            };
            v15 = v15 + 1;
        };
        let v17 = keno_payout(v1, v14);
        let v18 = if (v17 == 0) {
            0
        } else {
            v0 * v17 / 10000
        };
        let v19 = if (v18 > v5 / 10) {
            let v20 = v5 / 10;
            arg0.jackpots_hit = arg0.jackpots_hit + 1;
            let v21 = JackpotHit{
                player : 0x2::tx_context::sender(arg4),
                bet    : v0,
                payout : v20,
                game   : 5,
            };
            0x2::event::emit<JackpotHit>(v21);
            v20
        } else {
            v18
        };
        burn_house_cut(arg0, v0, 5, arg4);
        if (v19 > 0) {
            let v22 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v19, v22, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v23 = KenoDrawn{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            picks      : arg3,
            drawn      : v7,
            matches    : v14,
            payout     : v19,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<KenoDrawn>(v23);
    }

    public entry fun play_limbo(arg0: &mut CasinoShrine, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg3 >= 101 && arg3 <= 5000, 6);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = 950400 / (0x2::random::generate_u64(&mut v1) % 9900 + 1);
        let v3 = v2 >= arg3;
        let v4 = 0;
        if (v3) {
            let v5 = v0 * arg3 / 100;
            let v6 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) / 10;
            let v7 = if (v5 > v6) {
                v6
            } else {
                v5
            };
            v4 = v7;
            if (v7 > 0) {
                if (v5 > v6) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                    let v8 = JackpotHit{
                        player : 0x2::tx_context::sender(arg4),
                        bet    : v0,
                        payout : v7,
                        game   : 6,
                    };
                    0x2::event::emit<JackpotHit>(v8);
                };
                let v9 = 0x2::tx_context::sender(arg4);
                pay_player(arg0, v7, v9, arg4);
            };
        };
        burn_house_cut(arg0, v0, 6, arg4);
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v10 = LimboResult{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            target_bps : arg3,
            result_bps : v2,
            won        : v3,
            payout     : v4,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<LimboResult>(v10);
    }

    public fun pool_size(arg0: &CasinoShrine) : u64 {
        0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
    }

    public entry fun receive_lost_coin(arg0: &mut CasinoShrine, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, arg1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v0));
        let v1 = PoolDeposited{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v0),
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PoolDeposited>(v1);
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
        burn_house_cut(arg0, v5, 0, arg3);
        let v7 = if (arg2 == 0 || arg2 == 5) {
            0
        } else if (arg2 == 3) {
            pay_player(arg0, v5, v1, arg3);
            v5
        } else if (arg2 == 1 || arg2 == 4) {
            let v8 = v5 + v5 * 10000 / 10000;
            assert!(v6 >= v8, 4);
            pay_player(arg0, v8, v1, arg3);
            v8
        } else if (arg2 == 2) {
            let v9 = v5 + v5 * 15000 / 10000;
            assert!(v6 >= v9, 4);
            pay_player(arg0, v9, v1, arg3);
            v9
        } else {
            let v10 = 500000000000000;
            let v11 = v6 / 10;
            let v12 = if (v11 < v10) {
                v11
            } else {
                v10
            };
            arg0.jackpots_hit = arg0.jackpots_hit + 1;
            let v13 = JackpotHit{
                player : v1,
                bet    : v5,
                payout : v12,
                game   : 0,
            };
            0x2::event::emit<JackpotHit>(v13);
            pay_player(arg0, v12, v1, arg3);
            v12
        };
        let v14 = MountainHasSpoken{
            session_id : 0x2::object::id<CovenantSession>(&arg1),
            player     : v1,
            bet        : v5,
            doubled    : v3,
            result     : arg2,
            payout     : v7,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<MountainHasSpoken>(v14);
    }

    public fun total_hands(arg0: &CasinoShrine) : u64 {
        arg0.total_hands
    }

    public entry fun transfer_admin(arg0: &mut CasinoShrine, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg1 != @0x0, 0);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    // decompiled from Move bytecode v7
}

