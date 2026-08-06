module 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::drain {
    struct DrainProgressEvent has copy, drop {
        bot: address,
        games_played: u64,
        full_wins: u64,
        total_drained: u64,
        current_xup: u64,
        treasury_remaining: u64,
    }

    struct DrainBot has store, key {
        id: 0x2::object::UID,
        games_played: u64,
        full_wins: u64,
        total_drained: u64,
        profit: u64,
        treasury_remaining: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : DrainBot {
        DrainBot{
            id                 : 0x2::object::new(arg0),
            games_played       : 0,
            full_wins          : 0,
            total_drained      : 0,
            profit             : 0,
            treasury_remaining : 2707029725347,
        }
    }

    public fun current_xup(arg0: &0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState) : u64 {
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::get_amount(arg0)
    }

    public fun full_wins(arg0: &DrainBot) : u64 {
        arg0.full_wins
    }

    public fun games_played(arg0: &DrainBot) : u64 {
        arg0.games_played
    }

    public fun initial_treasury() : u64 {
        2707029725347
    }

    public fun kelly_fraction_bps() : u64 {
        310
    }

    public fun kelly_stake(arg0: &0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState, arg1: u64) : u64 {
        assert!(arg1 > 0 && arg1 < 10000, 4);
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::amount_unclaimed(arg0) * arg1 / 10000
    }

    public fun play_full_game(arg0: &mut DrainBot, arg1: &0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UpAdmin, arg2: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::UPTreasury, arg3: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState, arg4: &vector<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP> {
        assert!(arg0.treasury_remaining > 0, 1);
        let v0 = kelly_stake(arg3, arg5);
        assert!(v0 > 0, 2);
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::set_amount(arg3, 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::amount_unclaimed(arg3) - v0);
        let (v1, v2) = simulate_hard_game(v0, arg4);
        let v3 = 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::adventure::end_adventure(0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::adventure::create_adventure_with_unlock(v1, v2, v0, arg6), arg1, arg2, arg3, arg6);
        let v4 = 0x1::option::is_some<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(&v3);
        arg0.games_played = arg0.games_played + 1;
        if (v4) {
            arg0.full_wins = arg0.full_wins + 1;
            arg0.total_drained = arg0.total_drained + v1;
            arg0.profit = arg0.profit + v1;
            arg0.treasury_remaining = arg0.treasury_remaining - v1;
        };
        if (v4) {
            0x1::option::destroy_none<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(v3);
            let v5 = DrainProgressEvent{
                bot                : 0x2::tx_context::sender(arg6),
                games_played       : arg0.games_played,
                full_wins          : arg0.full_wins,
                total_drained      : arg0.total_drained,
                current_xup        : 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::get_amount(arg3),
                treasury_remaining : arg0.treasury_remaining,
            };
            0x2::event::emit<DrainProgressEvent>(v5);
            return 0x1::option::extract<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(&mut v3)
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(v3);
        0x2::coin::zero<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(arg6)
    }

    public entry fun play_round(arg0: &mut DrainBot, arg1: &0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UpAdmin, arg2: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::UPTreasury, arg3: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg5);
        0x1::vector::push_back<u64>(v1, arg6);
        0x1::vector::push_back<u64>(v1, arg7);
        0x1::vector::push_back<u64>(v1, arg8);
        0x1::vector::push_back<u64>(v1, arg9);
        let v2 = play_full_game(arg0, arg1, arg2, arg3, &v0, arg4, arg10);
        if (0x2::coin::value<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(&v2) > 0) {
            reinvest(arg3, v2, arg10);
        } else {
            0x2::coin::destroy_zero<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(v2);
        };
    }

    public fun profit(arg0: &DrainBot) : u64 {
        arg0.profit
    }

    public fun reinvest(arg0: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState, arg1: 0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(arg1, 0x2::tx_context::sender(arg2));
        let v1 = 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::get_amount(arg0);
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::set_amount(arg0, v1 + v0);
        v1 + v0
    }

    public fun simulate_hard_game(arg0: u64, arg1: &vector<u64>) : (u64, u64) {
        let v0 = vector[62, 62, 52, 52, 52];
        let v1 = vector[166, 166, 200, 200, 200];
        let v2 = vector[1, 2, 5, 10, 100];
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::vector::length<u64>(arg1);
        assert!(v5 >= 1 && v5 <= 5, 3);
        let v6 = 0;
        while (v6 < v5) {
            if (*0x1::vector::borrow<u64>(arg1, v6) <= *0x1::vector::borrow<u64>(&v0, v6)) {
                let v7 = arg0 * *0x1::vector::borrow<u64>(&v1, v6) / 100;
                arg0 = v7;
                let v8 = v7 * *0x1::vector::borrow<u64>(&v2, v6) / 100;
                v4 = v4 + v8;
                v3 = v3 + v7 - v8;
            } else {
                arg0 = 0;
                v3 = 0;
                v4 = 0;
                v6 = v5;
            };
            v6 = v6 + 1;
        };
        (v4, v3)
    }

    public fun total_drained(arg0: &DrainBot) : u64 {
        arg0.total_drained
    }

    public fun treasury_remaining(arg0: &DrainBot) : u64 {
        arg0.treasury_remaining
    }

    // decompiled from Move bytecode v7
}

