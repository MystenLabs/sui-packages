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

    fun burn_house_cut(arg0: &mut CasinoShrine, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 2500 / 10000;
        if (v0 > 0 && v0 <= 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v0), arg3), @0xf630fe565e79e3b5de154eefcc17409ba7bf54f68ffeeef692ed0dee96d70730);
            let v1 = JuiBurned{
                amount : v0,
                game   : arg2,
            };
            0x2::event::emit<JuiBurned>(v1);
        };
    }

    public entry fun cast_the_dice(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        assert!(arg2 <= 3, 6);
        if (arg2 == 3) {
            assert!(arg3 >= 2 && arg3 <= 12, 6);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = make_seed(arg4, v0 ^ v1 % 999999937) % 36;
        let v3 = ((v2 / 6) as u8) + 1 + ((v2 % 6) as u8) + 1;
        let (v4, v5) = if (arg2 == 0) {
            if (v3 < 7) {
                (v0 + v0 * 11000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 1) {
            if (v3 > 7) {
                (v0 + v0 * 11000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 2) {
            if (v3 == 7) {
                let v6 = v0 * 5;
                let v4 = v6;
                if (v6 > v1 / 4) {
                    v4 = v1 / 4;
                };
                (v4, 1)
            } else {
                (0, 0)
            }
        } else if (v3 == arg3) {
            let v7 = if (arg3 == 2 || arg3 == 12) {
                30
            } else if (arg3 == 3 || arg3 == 11) {
                15
            } else if (arg3 == 4 || arg3 == 10) {
                10
            } else if (arg3 == 5 || arg3 == 9) {
                7
            } else if (arg3 == 6 || arg3 == 8) {
                6
            } else {
                5
            };
            let v8 = v0 * v7;
            let v4 = v8;
            if (v8 > v1 / 3) {
                let v9 = v1 / 3;
                v4 = v9;
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v10 = JackpotHit{
                    player : 0x2::tx_context::sender(arg4),
                    bet    : v0,
                    payout : v9,
                    game   : 2,
                };
                0x2::event::emit<JackpotHit>(v10);
            };
            (v4, 2)
        } else {
            (0, 0)
        };
        if (v4 > 0) {
            let v11 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v4, v11, arg4);
        } else {
            burn_house_cut(arg0, v0, 2, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v12 = LotsCast{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            roll       : v3,
            prediction : arg2,
            target     : arg3,
            result     : v5,
            payout     : v4,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<LotsCast>(v12);
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
        } else {
            burn_house_cut(arg0, v0, 1, arg2);
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

    public entry fun drop_shekel(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v2 = make_seed(arg2, v0 ^ v1 % 999999937) % 65536;
        let v3 = if (v2 < 17) {
            0
        } else if (v2 < 697) {
            1
        } else if (v2 < 6885) {
            2
        } else if (v2 < 26333) {
            3
        } else if (v2 < 39203) {
            4
        } else if (v2 < 58651) {
            5
        } else if (v2 < 64839) {
            6
        } else if (v2 < 65519) {
            7
        } else {
            8
        };
        let v4 = v3 == 0 || v3 == 8;
        let v5 = v3 == 1 || v3 == 7;
        let v6 = v3 == 2 || v3 == 6;
        let v7 = v3 == 3 || v3 == 5;
        let (v8, v9) = if (v4) {
            (1, 47)
        } else if (v5) {
            (1, 4)
        } else if (v6) {
            (1, 2)
        } else if (v7) {
            (10, 7)
        } else {
            (5, 1)
        };
        let v10 = v0 * v9 / v8;
        let v11 = v10;
        if (v10 > v1 / 4) {
            let v12 = v1 / 4;
            v11 = v12;
            if (v12 > 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v13 = JackpotHit{
                    player : 0x2::tx_context::sender(arg2),
                    bet    : v0,
                    payout : v12,
                    game   : 4,
                };
                0x2::event::emit<JackpotHit>(v13);
            };
        };
        if (v11 > 0) {
            let v14 = 0x2::tx_context::sender(arg2);
            pay_player(arg0, v11, v14, arg2);
        } else {
            burn_house_cut(arg0, v0, 4, arg2);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v15 = ShekelDropped{
            player     : 0x2::tx_context::sender(arg2),
            wager      : v0,
            bucket     : v3,
            mult_num   : v9,
            mult_den   : v8,
            payout     : v11,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<ShekelDropped>(v15);
    }

    public entry fun drop_shekel_v2(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        let v1 = if (arg2 == 8) {
            true
        } else if (arg2 == 10) {
            true
        } else if (arg2 == 12) {
            true
        } else if (arg2 == 14) {
            true
        } else {
            arg2 == 16
        };
        assert!(v1, 7);
        assert!(arg3 <= 2, 8);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v2 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v3 = make_seed(arg4, v0 ^ v2 % 999999937) % 65536;
        let v4 = if (arg2 == 8) {
            if (v3 < 256) {
                0
            } else if (v3 < 2304) {
                1
            } else if (v3 < 9472) {
                2
            } else if (v3 < 23808) {
                3
            } else if (v3 < 41728) {
                4
            } else if (v3 < 56064) {
                5
            } else if (v3 < 63232) {
                6
            } else if (v3 < 65280) {
                7
            } else {
                8
            }
        } else if (arg2 == 10) {
            if (v3 < 704) {
                0
            } else if (v3 < 3584) {
                1
            } else if (v3 < 11264) {
                2
            } else if (v3 < 24064) {
                3
            } else if (v3 < 36864) {
                4
            } else if (v3 < 49664) {
                5
            } else if (v3 < 61440) {
                6
            } else if (v3 < 64832) {
                7
            } else {
                8
            }
        } else if (arg2 == 12) {
            if (v3 < 1264) {
                0
            } else if (v3 < 4784) {
                1
            } else if (v3 < 12704) {
                2
            } else if (v3 < 25376) {
                3
            } else if (v3 < 40160) {
                4
            } else if (v3 < 52832) {
                5
            } else if (v3 < 60752) {
                6
            } else if (v3 < 64272) {
                7
            } else {
                8
            }
        } else if (arg2 == 14) {
            if (v3 < 1880) {
                0
            } else if (v3 < 5884) {
                1
            } else if (v3 < 13892) {
                2
            } else if (v3 < 25904) {
                3
            } else if (v3 < 39632) {
                4
            } else if (v3 < 51644) {
                5
            } else if (v3 < 59652) {
                6
            } else if (v3 < 63656) {
                7
            } else {
                8
            }
        } else if (v3 < 17) {
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
        let (v9, v10) = if (arg3 == 0) {
            if (arg2 == 8) {
                if (v5) {
                    (1, 29)
                } else if (v6) {
                    (2, 5)
                } else if (v7) {
                    (5, 9)
                } else if (v8) {
                    (4, 1)
                } else {
                    (10, 3)
                }
            } else if (arg2 == 10) {
                if (v5) {
                    (1, 80)
                } else if (v6) {
                    (2, 5)
                } else if (v7) {
                    (2, 3)
                } else if (v8) {
                    (5, 4)
                } else {
                    (5, 2)
                }
            } else if (arg2 == 12) {
                if (v5) {
                    (1, 130)
                } else if (v6) {
                    (2, 5)
                } else if (v7) {
                    (2, 3)
                } else if (v8) {
                    (10, 9)
                } else {
                    (5, 2)
                }
            } else if (arg2 == 14) {
                if (v5) {
                    (1, 480)
                } else if (v6) {
                    (2, 5)
                } else if (v7) {
                    (2, 3)
                } else if (v8) {
                    (10, 9)
                } else {
                    (5, 2)
                }
            } else if (v5) {
                (1, 120)
            } else if (v6) {
                (2, 5)
            } else if (v7) {
                (2, 3)
            } else if (v8) {
                (5, 4)
            } else {
                (5, 2)
            }
        } else if (arg3 == 1) {
            if (arg2 == 8) {
                if (v5) {
                    (1, 56)
                } else if (v6) {
                    (1, 3)
                } else if (v7) {
                    (5, 6)
                } else if (v8) {
                    (10, 1)
                } else {
                    (10, 1)
                }
            } else if (arg2 == 10) {
                if (v5) {
                    (1, 140)
                } else if (v6) {
                    (1, 4)
                } else if (v7) {
                    (1, 2)
                } else if (v8) {
                    (5, 3)
                } else {
                    (5, 1)
                }
            } else if (arg2 == 12) {
                if (v5) {
                    (1, 220)
                } else if (v6) {
                    (1, 4)
                } else if (v7) {
                    (1, 2)
                } else if (v8) {
                    (5, 4)
                } else {
                    (5, 1)
                }
            } else if (arg2 == 14) {
                if (v5) {
                    (1, 700)
                } else if (v6) {
                    (1, 4)
                } else if (v7) {
                    (1, 2)
                } else if (v8) {
                    (10, 7)
                } else {
                    (5, 1)
                }
            } else if (v5) {
                (1, 47)
            } else if (v6) {
                (1, 4)
            } else if (v7) {
                (1, 2)
            } else if (v8) {
                (10, 7)
            } else {
                (5, 1)
            }
        } else if (arg2 == 8) {
            if (v5) {
                (1, 74)
            } else if (v6) {
                (2, 7)
            } else if (v7) {
                (5, 3)
            } else if (v8) {
                (20, 1)
            } else {
                (50, 1)
            }
        } else if (arg2 == 10) {
            if (v5) {
                (1, 220)
            } else if (v6) {
                (1, 8)
            } else if (v7) {
                (1, 2)
            } else if (v8) {
                (10, 3)
            } else {
                (20, 1)
            }
        } else if (arg2 == 12) {
            if (v5) {
                (1, 450)
            } else if (v6) {
                (1, 8)
            } else if (v7) {
                (1, 2)
            } else if (v8) {
                (5, 3)
            } else {
                (20, 1)
            }
        } else if (arg2 == 14) {
            if (v5) {
                (1, 1000)
            } else if (v6) {
                (1, 8)
            } else if (v7) {
                (1, 2)
            } else if (v8) {
                (5, 3)
            } else {
                (20, 1)
            }
        } else if (v5) {
            (1, 95)
        } else if (v6) {
            (1, 8)
        } else if (v7) {
            (1, 2)
        } else if (v8) {
            (5, 3)
        } else {
            (20, 1)
        };
        let v11 = v0 * v10 / v9;
        let v12 = v11;
        if (v11 > v2 / 4) {
            let v13 = v2 / 4;
            v12 = v13;
            if (v13 > 0) {
                arg0.jackpots_hit = arg0.jackpots_hit + 1;
                let v14 = JackpotHit{
                    player : 0x2::tx_context::sender(arg4),
                    bet    : v0,
                    payout : v13,
                    game   : 4,
                };
                0x2::event::emit<JackpotHit>(v14);
            };
        };
        if (v12 > 0) {
            let v15 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v12, v15, arg4);
        } else {
            burn_house_cut(arg0, v0, 4, arg4);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v16 = ShekelDroppedV2{
            player     : 0x2::tx_context::sender(arg4),
            wager      : v0,
            rows       : arg2,
            difficulty : arg3,
            bucket     : v4,
            mult_num   : v10,
            mult_den   : v9,
            payout     : v12,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<ShekelDroppedV2>(v16);
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
        assert!(arg2 <= 8, 6);
        if (arg2 == 2) {
            assert!(arg3 <= 36, 6);
        };
        if (arg2 == 3) {
            assert!(arg3 >= 1 && arg3 <= 3, 6);
        };
        if (arg2 == 8) {
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
        } else if (arg2 == 3) {
            if (arg3 == 1 && v2 >= 1 && v2 <= 12 || arg3 == 2 && v2 >= 13 && v2 <= 24 || v2 >= 25 && v2 <= 36) {
                (v0 + v0 * 18000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 4) {
            if (v2 != 0 && v2 % 2 == 1) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 5) {
            if (v2 != 0 && v2 % 2 == 0) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 6) {
            if (v2 >= 1 && v2 <= 18) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (arg2 == 7) {
            if (v2 >= 19 && v2 <= 36) {
                (v0 + v0 * 9000 / 10000, 1)
            } else {
                (0, 0)
            }
        } else if (v2 != 0 && (arg3 == 1 && v2 % 3 == 1 || arg3 == 2 && v2 % 3 == 2 || v2 % 3 == 0)) {
            (v0 + v0 * 18000 / 10000, 1)
        } else {
            (0, 0)
        };
        if (v4 > 0) {
            let v8 = 0x2::tx_context::sender(arg4);
            pay_player(arg0, v4, v8, arg4);
        } else {
            burn_house_cut(arg0, v0, 3, arg4);
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

    public entry fun play_keno(arg0: &mut CasinoShrine, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        let v1 = 0x1::vector::length<u8>(&arg2);
        assert!(v1 >= 1 && v1 <= 10, 6);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v2 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v3 = b"";
        let v4 = make_seed(arg3, v0 ^ v2 % 999999937 ^ (v1 as u64));
        let v5 = 0;
        while (0x1::vector::length<u8>(&v3) < 10 && v5 < 200) {
            let v6 = v4 ^ v4 << 13 ^ v4 >> 7 ^ v4 << 17;
            v4 = v6;
            let v7 = ((v6 % 40) as u8) + 1;
            let v8 = false;
            let v9 = 0;
            while (v9 < 0x1::vector::length<u8>(&v3)) {
                if (*0x1::vector::borrow<u8>(&v3, v9) == v7) {
                    v8 = true;
                    break
                };
                v9 = v9 + 1;
            };
            if (!v8) {
                0x1::vector::push_back<u8>(&mut v3, v7);
            };
            v5 = v5 + 1;
        };
        let v10 = 0;
        let v11 = 0;
        while (v11 < v1) {
            let v12 = 0;
            while (v12 < 0x1::vector::length<u8>(&v3)) {
                if (*0x1::vector::borrow<u8>(&v3, v12) == *0x1::vector::borrow<u8>(&arg2, v11)) {
                    v10 = v10 + 1;
                    break
                };
                v12 = v12 + 1;
            };
            v11 = v11 + 1;
        };
        let v13 = keno_payout(v1, v10);
        let v14 = if (v13 == 0) {
            0
        } else {
            v0 * v13 / 10000
        };
        let v15 = if (v14 > v2 / 4) {
            v2 / 4
        } else {
            v14
        };
        if (v15 > 0) {
            let v16 = 0x2::tx_context::sender(arg3);
            pay_player(arg0, v15, v16, arg3);
        } else {
            burn_house_cut(arg0, v0, 5, arg3);
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v17 = KenoDrawn{
            player     : 0x2::tx_context::sender(arg3),
            wager      : v0,
            picks      : arg2,
            drawn      : v3,
            matches    : v10,
            payout     : v15,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<KenoDrawn>(v17);
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
            burn_house_cut(arg0, v5, 0, arg3);
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

