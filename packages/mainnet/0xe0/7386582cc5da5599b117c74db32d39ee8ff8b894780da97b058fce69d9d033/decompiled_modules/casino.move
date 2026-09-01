module 0x99d3caafe2e4a26d6f8da03773a672190c13da099c1715aac789254046db99f4::casino {
    struct House has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        min_bet: u64,
        max_bet: u64,
        max_payout_bps: u64,
        paused: bool,
        round: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RevenueConfig has key {
        id: 0x2::object::UID,
        recipient: address,
        fee_bps: u64,
    }

    struct PlayEvent has copy, drop {
        player: address,
        game: u8,
        outcome: u64,
        stake: u64,
        payout: u64,
        won: bool,
        round: u64,
    }

    struct RevenueEvent has copy, drop {
        player: address,
        recipient: address,
        game: u8,
        stake: u64,
        fee: u64,
        round: u64,
    }

    struct HouseWithdrawalEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun create_revenue_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevenueConfig{
            id        : 0x2::object::new(arg1),
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            fee_bps   : 250,
        };
        0x2::transfer::share_object<RevenueConfig>(v0);
    }

    public entry fun deposit(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AdminCap) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun dice_payout_for_test(arg0: u8, arg1: bool) : u64 {
        let v0 = if (arg1) {
            100 - arg0
        } else {
            arg0
        };
        9800 / (v0 as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id             : 0x2::object::new(arg0),
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            min_bet        : 1000000,
            max_bet        : 10000000000,
            max_payout_bps : 1960,
            paused         : false,
            round          : 0,
        };
        0x2::transfer::share_object<House>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun jackpot_payout_for_test(arg0: u8, arg1: u8, arg2: u8) : u64 {
        let v0 = arg0 == arg1 && arg1 == arg2;
        let v1 = if (arg0 == arg1) {
            true
        } else if (arg1 == arg2) {
            true
        } else {
            arg0 == arg2
        };
        let v2 = (arg0 + 1) % 10 == arg1 && (arg1 + 1) % 10 == arg2;
        if (v0 && arg0 == 7) {
            500
        } else if (v0) {
            200
        } else if (v1) {
            50
        } else if (v2) {
            33
        } else {
            0
        }
    }

    public entry fun play(arg0: &mut House, arg1: &0x2::random::Random, arg2: u8, arg3: u8, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    entry fun play_with_revenue(arg0: &mut House, arg1: &RevenueConfig, arg2: &0x2::random::Random, arg3: u8, arg4: u8, arg5: bool, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg1.fee_bps == 250, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        assert!(arg3 <= 2, 0);
        if (arg3 == 2) {
            assert!(arg4 >= 5 && arg4 <= 95, 3);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v1 = v0 * arg1.fee_bps / 10000;
        assert!(v1 > 0, 1);
        let v2 = 0x2::random::new_generator(arg2, arg7);
        let v3 = &mut v2;
        let (v4, v5, v6) = resolve_round(v3, arg3, arg4, arg5);
        let v7 = if (v6 > arg0.max_payout_bps) {
            arg0.max_payout_bps
        } else {
            v6
        };
        let v8 = if (v5) {
            v0 * v7 / 100
        } else {
            0
        };
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        assert!(v8 <= v9, 4);
        assert!(v1 <= v9 - v8, 4);
        arg0.round = arg0.round + 1;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v8), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg7), arg1.recipient);
        let v10 = PlayEvent{
            player  : 0x2::tx_context::sender(arg7),
            game    : arg3,
            outcome : v4,
            stake   : v0,
            payout  : v8,
            won     : v5,
            round   : arg0.round,
        };
        0x2::event::emit<PlayEvent>(v10);
        let v11 = RevenueEvent{
            player    : 0x2::tx_context::sender(arg7),
            recipient : arg1.recipient,
            game      : arg3,
            stake     : v0,
            fee       : v1,
            round     : arg0.round,
        };
        0x2::event::emit<RevenueEvent>(v11);
    }

    fun resolve_round(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u8, arg3: bool) : (u64, bool, u64) {
        if (arg1 == 0) {
            let v3 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v4 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v5 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v6 = v3 == v4 && v4 == v5;
            let v7 = if (v3 == v4) {
                true
            } else if (v4 == v5) {
                true
            } else {
                v3 == v5
            };
            let v8 = (v3 + 1) % 10 == v4 && (v4 + 1) % 10 == v5;
            let v9 = if (v6 && v3 == 7) {
                500
            } else if (v6) {
                200
            } else if (v7) {
                50
            } else if (v8) {
                33
            } else {
                0
            };
            ((v3 as u64) * 100 + (v4 as u64) * 10 + (v5 as u64), v9 > 0, v9)
        } else if (arg1 == 1) {
            let v10 = 0x2::random::generate_u8_in_range(arg0, 0, 11);
            let v11 = if (v10 == 0 || v10 == 8) {
                150
            } else if (v10 == 2) {
                175
            } else if (v10 == 4) {
                200
            } else if (v10 == 6) {
                300
            } else if (v10 == 10) {
                500
            } else {
                0
            };
            ((v10 as u64), v11 > 0, v11)
        } else {
            let v12 = 0x2::random::generate_u8_in_range(arg0, 1, 100);
            let v13 = if (arg3) {
                100 - arg2
            } else {
                arg2
            };
            let v14 = arg3 && v12 > arg2 || v12 <= arg2;
            ((v12 as u64), v14, 9800 / (v13 as u64))
        }
    }

    fun revenue_fee_for_test(arg0: u64) : u64 {
        arg0 * 250 / 10000
    }

    public entry fun set_limits(arg0: &mut House, arg1: u64, arg2: u64, arg3: u64, arg4: &AdminCap) {
        let v0 = if (arg1 >= 1000000) {
            if (arg2 >= arg1) {
                if (arg2 <= 100000000000) {
                    if (arg3 > 0) {
                        arg3 <= 2500
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        arg0.min_bet = arg1;
        arg0.max_bet = arg2;
        arg0.max_payout_bps = arg3;
    }

    public entry fun set_paused(arg0: &mut House, arg1: bool, arg2: &AdminCap) {
        arg0.paused = arg1;
    }

    fun wheel_payout_for_test(arg0: u8) : u64 {
        if (arg0 == 0 || arg0 == 8) {
            150
        } else if (arg0 == 2) {
            175
        } else if (arg0 == 4) {
            200
        } else if (arg0 == 6) {
            300
        } else if (arg0 == 10) {
            500
        } else {
            0
        }
    }

    public entry fun withdraw(arg0: &mut House, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 6);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        let v0 = HouseWithdrawalEvent{
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            amount    : arg1,
        };
        0x2::event::emit<HouseWithdrawalEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

