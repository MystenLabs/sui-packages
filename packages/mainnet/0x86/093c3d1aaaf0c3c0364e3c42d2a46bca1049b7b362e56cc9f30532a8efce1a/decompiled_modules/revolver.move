module 0x797e41e2832fec6106cdb590357e0146bd212dc00166c1341822b6cdc005c554::revolver {
    struct SpinEvent has copy, drop {
        player: address,
        stake: u64,
        angle_deg: u16,
        win: bool,
        payout: u64,
    }

    public fun calculate_payout(arg0: u64) : u64 {
        payout_for(arg0)
    }

    public fun get_min_bet() : u64 {
        1000000
    }

    public fun get_payout_multiplier() : (u64, u64) {
        (194, 25)
    }

    public fun get_win_angle() : u16 {
        45
    }

    fun map_to_360(arg0: &mut 0x2::random::RandomGenerator) : u16 {
        (0x2::random::generate_u64_in_range(arg0, 0, 360) as u16)
    }

    fun payout_for(arg0: u64) : u64 {
        arg0 * 194 / 25
    }

    public entry fun play(arg0: &mut 0x797e41e2832fec6106cdb590357e0146bd212dc00166c1341822b6cdc005c554::casino::House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000, 2);
        let v1 = payout_for(v0);
        assert!(0x797e41e2832fec6106cdb590357e0146bd212dc00166c1341822b6cdc005c554::casino::get_house_balance(arg0) >= v1, 3);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = &mut v2;
        let v4 = map_to_360(v3);
        let v5 = v4 < 45;
        let v6 = SpinEvent{
            player    : 0x2::tx_context::sender(arg3),
            stake     : v0,
            angle_deg : v4,
            win       : v5,
            payout    : 0x797e41e2832fec6106cdb590357e0146bd212dc00166c1341822b6cdc005c554::casino::process_game_bet(arg0, arg1, v5, v1, arg3),
        };
        0x2::event::emit<SpinEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

