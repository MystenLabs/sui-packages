module 0x72b0192f760dd62db6df8d40dc9867e84d9e95628b100c405dcf145c60244656::wheel {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseFlag has key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury: address,
        burn_address: address,
        max_bet: u64,
        total_rounds: u64,
        unclaimed_reserves: u64,
    }

    struct Round has key {
        id: 0x2::object::UID,
        round_number: u64,
        start_time: u64,
        status: u8,
        winning_slot: u8,
        total_bets: u64,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        round_number: u64,
        player: address,
        slot: u8,
        amount: u64,
        claimed: bool,
        is_winner: bool,
    }

    struct RoundOpened has copy, drop {
        round_number: u64,
        start_time: u64,
    }

    struct BetPlaced has copy, drop {
        round_number: u64,
        player: address,
        slot: u8,
        amount: u64,
    }

    struct RoundResolved has copy, drop {
        round_number: u64,
        winning_slot: u8,
    }

    struct VaultPaused has copy, drop {
        vault_id: address,
    }

    struct VaultUnpaused has copy, drop {
        vault_id: address,
    }

    struct WinClaimed has copy, drop {
        round_number: u64,
        player: address,
        amount: u64,
    }

    public fun claim_win<T0>(arg0: &mut Vault<T0>, arg1: &Round, arg2: &mut Bet, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 8);
        assert!(!arg2.claimed, 7);
        assert!(arg2.slot == arg1.winning_slot, 6);
        arg2.claimed = true;
        let v0 = arg2.amount * get_multiplier(arg2.slot) / 10;
        let (v1, v2) = if (arg2.slot == 0) {
            (0, 0)
        } else {
            let v3 = v0 * 200 / 10000;
            let v4 = v3 * 25 / 100;
            (v3 - v4, v4)
        };
        let v5 = v0 - v1 - v2;
        arg0.unclaimed_reserves = arg0.unclaimed_reserves - v0;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v2, arg3), arg0.burn_address);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg3), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v5, arg3), 0x2::tx_context::sender(arg3));
        let v6 = WinClaimed{
            round_number : arg1.round_number,
            player       : 0x2::tx_context::sender(arg3),
            amount       : v5,
        };
        0x2::event::emit<WinClaimed>(v6);
    }

    public fun close_betting(arg0: &mut Round, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 1);
        arg0.status = 1;
    }

    public fun create_pause_flag(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseFlag{
            id     : 0x2::object::new(arg1),
            paused : false,
        };
        0x2::transfer::share_object<PauseFlag>(v0);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                 : 0x2::object::new(arg3),
            balance            : 0x2::balance::zero<T0>(),
            treasury           : arg1,
            burn_address       : arg2,
            max_bet            : 5000000000,
            total_rounds       : 0,
            unclaimed_reserves : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun fund_vault<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    fun get_multiplier(arg0: u8) : u64 {
        if (arg0 == 0) {
            15
        } else if (arg0 == 1) {
            30
        } else if (arg0 == 2) {
            50
        } else if (arg0 == 3) {
            80
        } else if (arg0 == 4) {
            150
        } else {
            200
        }
    }

    public fun get_vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun open_round<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            id           : 0x2::object::new(arg2),
            round_number : arg0.total_rounds + 1,
            start_time   : 0x2::clock::timestamp_ms(arg1),
            status       : 0,
            winning_slot : 0,
            total_bets   : 0,
        };
        arg0.total_rounds = arg0.total_rounds + 1;
        let v1 = RoundOpened{
            round_number : v0.round_number,
            start_time   : v0.start_time,
        };
        0x2::event::emit<RoundOpened>(v1);
        0x2::transfer::share_object<Round>(v0);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut PauseFlag) {
        arg1.paused = true;
        let v0 = VaultPaused{vault_id: 0x2::object::id_address<PauseFlag>(arg1)};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun place_bet<T0>(arg0: &mut Vault<T0>, arg1: &PauseFlag, arg2: &mut Round, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 1);
        assert!(arg2.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg5) - arg2.start_time < 60000, 1);
        assert!(arg4 <= 5, 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 <= arg0.max_bet, 3);
        let v1 = v0 * get_multiplier(arg4) / 10;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.unclaimed_reserves + v1, 5);
        if (arg4 != 0) {
            let v2 = v0 * 400 / 10000;
            let v3 = v2 * 25 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg6), arg0.burn_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2 - v3, arg6), arg0.treasury);
        };
        let v4 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        arg0.unclaimed_reserves = arg0.unclaimed_reserves + v1;
        arg2.total_bets = arg2.total_bets + v4;
        let v5 = Bet{
            id           : 0x2::object::new(arg6),
            round_number : arg2.round_number,
            player       : 0x2::tx_context::sender(arg6),
            slot         : arg4,
            amount       : v4,
            claimed      : false,
            is_winner    : false,
        };
        let v6 = BetPlaced{
            round_number : arg2.round_number,
            player       : 0x2::tx_context::sender(arg6),
            slot         : arg4,
            amount       : v4,
        };
        0x2::event::emit<BetPlaced>(v6);
        0x2::transfer::transfer<Bet>(v5, 0x2::tx_context::sender(arg6));
    }

    public fun resolve_round(arg0: &mut Round, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 8);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 23);
        let v2 = if (v1 == 0) {
            0
        } else if (v1 == 1) {
            1
        } else if (v1 == 2) {
            0
        } else if (v1 == 3) {
            2
        } else if (v1 == 4) {
            0
        } else if (v1 == 5) {
            1
        } else if (v1 == 6) {
            0
        } else if (v1 == 7) {
            3
        } else if (v1 == 8) {
            0
        } else if (v1 == 9) {
            1
        } else if (v1 == 10) {
            0
        } else if (v1 == 11) {
            2
        } else if (v1 == 12) {
            0
        } else if (v1 == 13) {
            4
        } else if (v1 == 14) {
            0
        } else if (v1 == 15) {
            1
        } else if (v1 == 16) {
            0
        } else if (v1 == 17) {
            3
        } else if (v1 == 18) {
            0
        } else if (v1 == 19) {
            2
        } else if (v1 == 20) {
            0
        } else if (v1 == 21) {
            1
        } else if (v1 == 22) {
            0
        } else {
            5
        };
        arg0.winning_slot = v2;
        arg0.status = 2;
        let v3 = RoundResolved{
            round_number : arg0.round_number,
            winning_slot : v2,
        };
        0x2::event::emit<RoundResolved>(v3);
    }

    public fun round_status(arg0: &Round) : u8 {
        arg0.status
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut PauseFlag) {
        arg1.paused = false;
        let v0 = VaultUnpaused{vault_id: 0x2::object::id_address<PauseFlag>(arg1)};
        0x2::event::emit<VaultUnpaused>(v0);
    }

    public fun update_burn_address<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address) {
        arg1.burn_address = arg2;
    }

    public fun update_max_bet<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.max_bet = arg2;
    }

    public fun vault_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun winning_slot(arg0: &Round) : u8 {
        arg0.winning_slot
    }

    public fun withdraw_vault<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

