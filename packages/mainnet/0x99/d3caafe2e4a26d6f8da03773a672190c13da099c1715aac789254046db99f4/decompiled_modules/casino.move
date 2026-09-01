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

    struct PlayEvent has copy, drop {
        player: address,
        game: u8,
        outcome: u64,
        stake: u64,
        payout: u64,
        won: bool,
        round: u64,
    }

    public entry fun deposit(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AdminCap) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun dice_payout_for_test(arg0: u8) : u64 {
        9800 / (arg0 as u64)
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

    public entry fun play(arg0: &mut House, arg1: &0x2::random::Random, arg2: u8, arg3: u8, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        assert!(arg2 <= 2, 0);
        if (arg2 == 2) {
            assert!(arg3 >= 5 && arg3 <= 95, 3);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let v1 = 0x2::random::new_generator(arg1, arg6);
        let (v2, v3, v4) = if (arg2 == 0) {
            let v5 = 0x2::random::generate_u8_in_range(&mut v1, 0, 9);
            let v6 = 0x2::random::generate_u8_in_range(&mut v1, 0, 9);
            let v7 = 0x2::random::generate_u8_in_range(&mut v1, 0, 9);
            let v8 = v5 == v6 && v6 == v7;
            let v9 = if (v5 == v6) {
                true
            } else if (v6 == v7) {
                true
            } else {
                v5 == v7
            };
            let v10 = (v5 + 1) % 10 == v6 && (v6 + 1) % 10 == v7;
            let v11 = if (v8 && v5 == 7) {
                500
            } else if (v8) {
                200
            } else if (v9) {
                50
            } else if (v10) {
                33
            } else {
                0
            };
            ((v5 as u64) * 100 + (v6 as u64) * 10 + (v7 as u64), v11 > 0, v11)
        } else if (arg2 == 1) {
            let v12 = 0x2::random::generate_u8_in_range(&mut v1, 0, 11);
            let v13 = if (v12 == 0 || v12 == 8) {
                150
            } else if (v12 == 2) {
                175
            } else if (v12 == 4) {
                200
            } else if (v12 == 6) {
                300
            } else if (v12 == 10) {
                500
            } else {
                0
            };
            ((v12 as u64), v13 > 0, v13)
        } else {
            let v14 = 0x2::random::generate_u8_in_range(&mut v1, 1, 100);
            let v15 = if (arg4) {
                100 - arg3
            } else {
                arg3
            };
            let v16 = arg4 && v14 > arg3 || v14 <= arg3;
            ((v14 as u64), v16, 9800 / (v15 as u64))
        };
        let v17 = if (v4 > arg0.max_payout_bps) {
            arg0.max_payout_bps
        } else {
            v4
        };
        let v18 = if (v3) {
            v0 * v17 / 100
        } else {
            0
        };
        assert!(v18 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 4);
        arg0.round = arg0.round + 1;
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v18), arg6), 0x2::tx_context::sender(arg6));
        };
        let v19 = PlayEvent{
            player  : 0x2::tx_context::sender(arg6),
            game    : arg2,
            outcome : v2,
            stake   : v0,
            payout  : v18,
            won     : v3,
            round   : arg0.round,
        };
        0x2::event::emit<PlayEvent>(v19);
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
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

