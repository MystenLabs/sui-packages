module 0x5575cdf3e12b6b28284d3f9ae3e28b502325c317da18c719c78a9612c6b9f553::slots {
    struct CasinoPool<phantom T0> has key {
        id: 0x2::object::UID,
        rtp_pool: 0x2::balance::Balance<T0>,
        jackpot_pool: 0x2::balance::Balance<T0>,
        admin: address,
        total_spins: u64,
        total_wagered: u64,
        total_paid_out: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SpinResult has copy, drop {
        player: address,
        reel0: u8,
        reel1: u8,
        reel2: u8,
        bet: u64,
        win: u64,
        is_jackpot: bool,
    }

    entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CasinoPool<T0>{
            id             : 0x2::object::new(arg0),
            rtp_pool       : 0x2::balance::zero<T0>(),
            jackpot_pool   : 0x2::balance::zero<T0>(),
            admin          : 0x2::tx_context::sender(arg0),
            total_spins    : 0,
            total_wagered  : 0,
            total_paid_out : 0,
        };
        0x2::transfer::share_object<CasinoPool<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun fund_pool<T0>(arg0: &mut CasinoPool<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 3);
        0x2::balance::join<T0>(&mut arg0.rtp_pool, 0x2::coin::into_balance<T0>(arg2));
    }

    fun get_payout(arg0: u8) : u64 {
        if (arg0 == 0) {
            15
        } else if (arg0 == 1) {
            20
        } else if (arg0 == 2) {
            30
        } else if (arg0 == 3) {
            50
        } else if (arg0 == 4) {
            100
        } else if (arg0 == 5) {
            250
        } else {
            0
        }
    }

    public fun jackpot_pool_balance<T0>(arg0: &CasinoPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.jackpot_pool)
    }

    fun pick_symbol(arg0: u8) : u8 {
        if (arg0 < 40) {
            0
        } else if (arg0 < 40 + 28) {
            1
        } else if (arg0 < 40 + 28 + 14) {
            2
        } else if (arg0 < 40 + 28 + 14 + 8) {
            3
        } else if (arg0 < 40 + 28 + 14 + 8 + 6) {
            4
        } else if (arg0 < 40 + 28 + 14 + 8 + 6 + 3) {
            5
        } else {
            6
        }
    }

    public fun rtp_pool_balance<T0>(arg0: &CasinoPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rtp_pool)
    }

    public fun spin<T0>(arg0: &mut CasinoPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.jackpot_pool, 0x2::balance::split<T0>(&mut v1, v0 * 5 / 100));
        0x2::balance::join<T0>(&mut arg0.rtp_pool, v1);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = pick_symbol(0x2::random::generate_u8_in_range(&mut v2, 0, 99));
        let v4 = pick_symbol(0x2::random::generate_u8_in_range(&mut v2, 0, 99));
        let v5 = pick_symbol(0x2::random::generate_u8_in_range(&mut v2, 0, 99));
        arg0.total_spins = arg0.total_spins + 1;
        arg0.total_wagered = arg0.total_wagered + v0;
        let v6 = 0;
        let v7 = false;
        if (v3 == v4 && v4 == v5) {
            if (v3 == 6) {
                let v8 = 0x2::balance::value<T0>(&arg0.jackpot_pool);
                if (v8 >= 1000000000) {
                    v6 = v8 * 30 / 100;
                    v7 = true;
                };
            } else {
                v6 = v0 * get_payout(v3) / 10;
            };
        };
        if (v6 > 0) {
            let v9 = if (v7) {
                0x2::balance::value<T0>(&arg0.jackpot_pool)
            } else {
                0x2::balance::value<T0>(&arg0.rtp_pool)
            };
            assert!(v9 >= v6, 2);
            let v10 = if (v7) {
                0x2::balance::split<T0>(&mut arg0.jackpot_pool, v6)
            } else {
                0x2::balance::split<T0>(&mut arg0.rtp_pool, v6)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg3), 0x2::tx_context::sender(arg3));
            arg0.total_paid_out = arg0.total_paid_out + v6;
        };
        let v11 = SpinResult{
            player     : 0x2::tx_context::sender(arg3),
            reel0      : v3,
            reel1      : v4,
            reel2      : v5,
            bet        : v0,
            win        : v6,
            is_jackpot : v7,
        };
        0x2::event::emit<SpinResult>(v11);
    }

    public fun total_spins<T0>(arg0: &CasinoPool<T0>) : u64 {
        arg0.total_spins
    }

    // decompiled from Move bytecode v7
}

