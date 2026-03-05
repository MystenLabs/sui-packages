module 0x7f1eef14855bea19a66d5de5dde8f47e620c61f14b8f41cc29d3646005a3ee6f::game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        round_duration_ms: u64,
        buffer_ms: u64,
        current_target_ms: u64,
        rounds: 0x2::table::Table<u64, Round>,
        vault: 0x2::balance::Balance<T0>,
        project_wallet: address,
        fee_bps: u64,
        min_bet: u64,
        max_bet: u64,
        bet_cap: u64,
        is_paused: bool,
        total_rounds: u64,
        total_volume: u64,
        total_users: u64,
        player_stats: 0x2::table::Table<address, PlayerStats>,
        referral_codes: 0x2::table::Table<0x1::string::String, address>,
        player_referral_code: 0x2::table::Table<address, 0x1::string::String>,
        distribute_delay_ms: u64,
        distribute_paused: bool,
    }

    struct Round has store {
        target_ms: u64,
        is_revealed: bool,
        system_choice: u8,
        total_wagered: u64,
        user_bets: 0x2::table::Table<address, UserBet>,
        bet_addresses: vector<address>,
        distributed: bool,
        distribute_after_ms: u64,
    }

    struct UserBet has drop, store {
        choice: u8,
        amount: u64,
        claimed: bool,
    }

    struct PlayerStats has store {
        total_bets: u64,
        total_wagered: u64,
        total_won: u64,
        win_count: u64,
        lose_count: u64,
        tie_count: u64,
        current_streak: u64,
        max_streak: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct GameCreated has copy, drop {
        game_id: address,
        first_target_ms: u64,
        project_wallet: address,
    }

    struct BetPlaced has copy, drop {
        game_id: address,
        user: address,
        round_target_ms: u64,
        choice: u8,
        amount: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct RoundRevealed has copy, drop {
        game_id: address,
        round_target_ms: u64,
        system_choice: u8,
        next_target_ms: u64,
        total_wagered: u64,
        player_count: u64,
    }

    struct PayoutDistributed has copy, drop {
        game_id: address,
        user: address,
        round_target_ms: u64,
        payout_amount: u64,
    }

    struct UserClaimed has copy, drop {
        game_id: address,
        user: address,
        round_target_ms: u64,
        payout_amount: u64,
    }

    struct RoundDestroyed has copy, drop {
        game_id: address,
        round_target_ms: u64,
    }

    struct ReferralCodeRegistered has copy, drop {
        game_id: address,
        user: address,
        code: 0x1::string::String,
    }

    struct VaultDeposited has copy, drop {
        amount: u64,
    }

    struct VaultWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    struct GamePausedEvent has copy, drop {
        dummy_field: bool,
    }

    struct GameUnpausedEvent has copy, drop {
        dummy_field: bool,
    }

    fun calculate_payout(arg0: u64, arg1: u8, arg2: u8, arg3: u64) : u64 {
        let v0 = get_result(arg1, arg2);
        if (v0 == 1) {
            arg0 * (20000 - arg3) / 10000
        } else if (v0 == 0) {
            arg0 * (10000 - arg3) / 10000
        } else {
            0
        }
    }

    public entry fun claim<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        assert!(!arg0.distribute_paused, 28);
        assert!(0x2::table::contains<u64, Round>(&arg0.rounds, arg1), 5);
        let v0 = 0x2::table::borrow<u64, Round>(&arg0.rounds, arg1);
        assert!(v0.is_revealed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.distribute_after_ms, 27);
        let v1 = v0.system_choice;
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserBet>(&v0.user_bets, v2), 19);
        let v3 = 0x2::table::borrow<address, UserBet>(&v0.user_bets, v2);
        assert!(!v3.claimed, 13);
        let v4 = calculate_payout(v3.amount, v3.choice, v1, arg0.fee_bps);
        0x2::table::borrow_mut<address, UserBet>(&mut 0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).user_bets, v2).claimed = true;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v4), arg3), v2);
        };
        let v5 = 0x2::table::borrow<address, UserBet>(&0x2::table::borrow<u64, Round>(&arg0.rounds, arg1).user_bets, v2);
        if (0x2::table::contains<address, PlayerStats>(&arg0.player_stats, v2)) {
            let v6 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.player_stats, v2);
            update_player_stats(v6, v5, v1, v4);
        };
        let v7 = UserClaimed{
            game_id         : 0x2::object::uid_to_address(&arg0.id),
            user            : v2,
            round_target_ms : arg1,
            payout_amount   : v4,
        };
        0x2::event::emit<UserClaimed>(v7);
    }

    public entry fun create_game<T0>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id                   : 0x2::object::new(arg5),
            round_duration_ms    : 3600000,
            buffer_ms            : 300000,
            current_target_ms    : arg1,
            rounds               : 0x2::table::new<u64, Round>(arg5),
            vault                : 0x2::balance::zero<T0>(),
            project_wallet       : arg2,
            fee_bps              : 200,
            min_bet              : 1000000,
            max_bet              : 0,
            bet_cap              : arg3,
            is_paused            : false,
            total_rounds         : 1,
            total_volume         : 0,
            total_users          : 0,
            player_stats         : 0x2::table::new<address, PlayerStats>(arg5),
            referral_codes       : 0x2::table::new<0x1::string::String, address>(arg5),
            player_referral_code : 0x2::table::new<address, 0x1::string::String>(arg5),
            distribute_delay_ms  : arg4,
            distribute_paused    : false,
        };
        0x2::table::add<u64, Round>(&mut v0.rounds, arg1, new_round(arg1, arg1 + arg4, arg5));
        0x2::transfer::share_object<Game<T0>>(v0);
        let v1 = GameCreated{
            game_id         : 0x2::object::uid_to_address(&v0.id),
            first_target_ms : arg1,
            project_wallet  : arg2,
        };
        0x2::event::emit<GameCreated>(v1);
    }

    public entry fun deposit_vault<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.vault, 0x2::coin::into_balance<T0>(arg2));
        let v0 = VaultDeposited{amount: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<VaultDeposited>(v0);
    }

    public entry fun destroy_empty_round<T0>(arg0: &mut Game<T0>, arg1: u64) {
        assert!(0x2::table::contains<u64, Round>(&arg0.rounds, arg1), 5);
        let v0 = 0x2::table::borrow<u64, Round>(&arg0.rounds, arg1);
        assert!(v0.is_revealed, 6);
        assert!(v0.distributed || 0x1::vector::length<address>(&v0.bet_addresses) == 0, 14);
        let Round {
            target_ms           : _,
            is_revealed         : _,
            system_choice       : _,
            total_wagered       : _,
            user_bets           : v5,
            bet_addresses       : v6,
            distributed         : _,
            distribute_after_ms : _,
        } = 0x2::table::remove<u64, Round>(&mut arg0.rounds, arg1);
        let v9 = v6;
        let v10 = 0;
        let v11 = v5;
        while (v10 < 0x1::vector::length<address>(&v9)) {
            let v12 = *0x1::vector::borrow<address>(&v9, v10);
            if (0x2::table::contains<address, UserBet>(&v11, v12)) {
                0x2::table::remove<address, UserBet>(&mut v11, v12);
            };
            v10 = v10 + 1;
        };
        0x2::table::destroy_empty<address, UserBet>(v11);
        let v13 = RoundDestroyed{
            game_id         : 0x2::object::uid_to_address(&arg0.id),
            round_target_ms : arg1,
        };
        0x2::event::emit<RoundDestroyed>(v13);
    }

    public entry fun distribute<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        assert!(!arg0.distribute_paused, 28);
        assert!(0x2::table::contains<u64, Round>(&arg0.rounds, arg1), 5);
        let v0 = 0x2::table::borrow<u64, Round>(&arg0.rounds, arg1);
        assert!(v0.is_revealed, 6);
        assert!(!v0.distributed, 14);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.distribute_after_ms, 27);
        let v1 = v0.bet_addresses;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            distribute_one<T0>(arg0, arg1, *0x1::vector::borrow<address>(&v1, v2), v0.system_choice, arg3);
            v2 = v2 + 1;
        };
        0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).distributed = true;
    }

    public entry fun distribute_batch<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        assert!(!arg0.distribute_paused, 28);
        assert!(0x2::table::contains<u64, Round>(&arg0.rounds, arg1), 5);
        let v0 = 0x2::table::borrow<u64, Round>(&arg0.rounds, arg1);
        assert!(v0.is_revealed, 6);
        assert!(!v0.distributed, 14);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.distribute_after_ms, 27);
        let v1 = v0.bet_addresses;
        let v2 = 0x1::vector::length<address>(&v1);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2 && v3 < arg2) {
            let v5 = *0x1::vector::borrow<address>(&v1, v4);
            if (!0x2::table::borrow<address, UserBet>(&0x2::table::borrow<u64, Round>(&arg0.rounds, arg1).user_bets, v5).claimed) {
                distribute_one<T0>(arg0, arg1, v5, v0.system_choice, arg4);
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        if (v4 >= v2) {
            0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).distributed = true;
        };
    }

    fun distribute_one<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<address, UserBet>(&0x2::table::borrow<u64, Round>(&arg0.rounds, arg1).user_bets, arg2);
        if (v0.claimed) {
            return
        };
        let v1 = calculate_payout(v0.amount, v0.choice, arg3, arg0.fee_bps);
        0x2::table::borrow_mut<address, UserBet>(&mut 0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1).user_bets, arg2).claimed = true;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v1), arg4), arg2);
        };
        let v2 = 0x2::table::borrow<address, UserBet>(&0x2::table::borrow<u64, Round>(&arg0.rounds, arg1).user_bets, arg2);
        if (0x2::table::contains<address, PlayerStats>(&arg0.player_stats, arg2)) {
            let v3 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.player_stats, arg2);
            update_player_stats(v3, v2, arg3, v1);
        };
        let v4 = PayoutDistributed{
            game_id         : 0x2::object::uid_to_address(&arg0.id),
            user            : arg2,
            round_target_ms : arg1,
            payout_amount   : v1,
        };
        0x2::event::emit<PayoutDistributed>(v4);
    }

    fun get_result(arg0: u8, arg1: u8) : u8 {
        if (arg0 == arg1) {
            return 0
        };
        let v0 = if (arg0 == 0 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 0) {
            true
        } else {
            arg0 == 2 && arg1 == 1
        };
        if (v0) {
            return 1
        };
        2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun new_round(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Round {
        Round{
            target_ms           : arg0,
            is_revealed         : false,
            system_choice       : 0,
            total_wagered       : 0,
            user_bets           : 0x2::table::new<address, UserBet>(arg2),
            bet_addresses       : 0x1::vector::empty<address>(),
            distributed         : false,
            distribute_after_ms : arg1,
        }
    }

    public entry fun pause_distribute<T0>(arg0: &AdminCap, arg1: &mut Game<T0>) {
        arg1.distribute_paused = true;
    }

    public entry fun pause_game<T0>(arg0: &AdminCap, arg1: &mut Game<T0>) {
        arg1.is_paused = true;
        let v0 = GamePausedEvent{dummy_field: false};
        0x2::event::emit<GamePausedEvent>(v0);
    }

    public entry fun place_bet<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        place_bet_internal<T0>(arg0, arg1, arg2, arg3, 0x1::option::none<address>(), arg4);
    }

    fun place_bet_internal<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        assert!(arg2 <= 2, 9);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x1::option::is_some<address>(&arg4)) {
            if (*0x1::option::borrow<address>(&arg4) == v0) {
                arg4 = 0x1::option::none<address>();
            };
        };
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= arg0.min_bet, 10);
        if (arg0.max_bet > 0) {
            assert!(v1 <= arg0.max_bet, 11);
        };
        assert!(v1 % 1000000 == 0, 12);
        let v2 = arg0.current_target_ms;
        assert!(0x2::clock::timestamp_ms(arg1) < v2 - arg0.buffer_ms, 1);
        assert!(0x2::balance::value<T0>(&arg0.vault) - 0x2::table::borrow<u64, Round>(&arg0.rounds, v2).total_wagered >= arg0.bet_cap * (20000 - arg0.fee_bps - 10000) / 10000, 21);
        let v3 = 0x2::table::borrow<u64, Round>(&arg0.rounds, v2);
        assert!(v3.total_wagered + v1 <= arg0.bet_cap, 20);
        if (0x2::table::contains<address, UserBet>(&v3.user_bets, v0)) {
            assert!(0x2::table::borrow<address, UserBet>(&v3.user_bets, v0).choice == arg2, 7);
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg3));
        let v4 = 0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, v2);
        v4.total_wagered = v4.total_wagered + v1;
        let v5 = !0x2::table::contains<address, UserBet>(&v4.user_bets, v0);
        if (v5) {
            let v6 = UserBet{
                choice  : arg2,
                amount  : 0,
                claimed : false,
            };
            0x2::table::add<address, UserBet>(&mut v4.user_bets, v0, v6);
            0x1::vector::push_back<address>(&mut v4.bet_addresses, v0);
        };
        let v7 = 0x2::table::borrow_mut<address, UserBet>(&mut v4.user_bets, v0);
        v7.amount = v7.amount + v1;
        arg0.total_volume = arg0.total_volume + v1;
        if (!0x2::table::contains<address, PlayerStats>(&arg0.player_stats, v0)) {
            arg0.total_users = arg0.total_users + 1;
            let v8 = PlayerStats{
                total_bets     : 0,
                total_wagered  : 0,
                total_won      : 0,
                win_count      : 0,
                lose_count     : 0,
                tie_count      : 0,
                current_streak : 0,
                max_streak     : 0,
                referrer       : arg4,
            };
            0x2::table::add<address, PlayerStats>(&mut arg0.player_stats, v0, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.player_stats, v0);
        if (v5) {
            v9.total_bets = v9.total_bets + 1;
        };
        v9.total_wagered = v9.total_wagered + v1;
        let v10 = BetPlaced{
            game_id         : 0x2::object::uid_to_address(&arg0.id),
            user            : v0,
            round_target_ms : v2,
            choice          : arg2,
            amount          : v1,
            referrer        : arg4,
        };
        0x2::event::emit<BetPlaced>(v10);
    }

    public entry fun place_bet_with_referral<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        place_bet_internal<T0>(arg0, arg1, arg2, arg3, 0x1::option::some<address>(arg4), arg5);
    }

    public entry fun register_referral_code<T0>(arg0: &mut Game<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::length(&v1);
        assert!(v2 >= 3 && v2 <= 20, 25);
        let v3 = 0x1::string::bytes(&v1);
        let v4 = 0;
        while (v4 < v2) {
            let v5 = *0x1::vector::borrow<u8>(v3, v4);
            let v6 = if (v5 >= 97 && v5 <= 122) {
                true
            } else if (v5 >= 48 && v5 <= 57) {
                true
            } else {
                v5 == 95
            };
            assert!(v6, 25);
            v4 = v4 + 1;
        };
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.player_referral_code, v0), 26);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.referral_codes, v1), 24);
        0x2::table::add<0x1::string::String, address>(&mut arg0.referral_codes, v1, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.player_referral_code, v0, v1);
        let v7 = ReferralCodeRegistered{
            game_id : 0x2::object::uid_to_address(&arg0.id),
            user    : v0,
            code    : v1,
        };
        0x2::event::emit<ReferralCodeRegistered>(v7);
    }

    public entry fun reveal<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 0);
        let v0 = arg0.current_target_ms;
        assert!(0x2::clock::timestamp_ms(arg1) >= v0, 2);
        let v1 = 0x2::table::borrow_mut<u64, Round>(&mut arg0.rounds, v0);
        assert!(!v1.is_revealed, 4);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x2::random::generate_u8_in_range(&mut v2, 0, 2);
        v1.is_revealed = true;
        v1.system_choice = v3;
        let v4 = v1.total_wagered;
        let v5 = 0x1::vector::length<address>(&v1.bet_addresses);
        let v6 = v0 + arg0.round_duration_ms;
        arg0.current_target_ms = v6;
        arg0.total_rounds = arg0.total_rounds + 1;
        0x2::table::add<u64, Round>(&mut arg0.rounds, v6, new_round(v6, v6 + arg0.distribute_delay_ms, arg3));
        if (v4 == 0) {
            let Round {
                target_ms           : _,
                is_revealed         : _,
                system_choice       : _,
                total_wagered       : _,
                user_bets           : v11,
                bet_addresses       : _,
                distributed         : _,
                distribute_after_ms : _,
            } = 0x2::table::remove<u64, Round>(&mut arg0.rounds, v0);
            0x2::table::destroy_empty<address, UserBet>(v11);
        };
        let v15 = RoundRevealed{
            game_id         : 0x2::object::uid_to_address(&arg0.id),
            round_target_ms : v0,
            system_choice   : v3,
            next_target_ms  : v6,
            total_wagered   : v4,
            player_count    : v5,
        };
        0x2::event::emit<RoundRevealed>(v15);
    }

    public entry fun set_next_target<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg1.current_target_ms, 16);
        let v0 = arg1.current_target_ms;
        assert!(0x2::table::borrow<u64, Round>(&arg1.rounds, v0).total_wagered == 0, 19);
        let Round {
            target_ms           : _,
            is_revealed         : _,
            system_choice       : _,
            total_wagered       : _,
            user_bets           : v5,
            bet_addresses       : _,
            distributed         : _,
            distribute_after_ms : _,
        } = 0x2::table::remove<u64, Round>(&mut arg1.rounds, v0);
        0x2::table::destroy_empty<address, UserBet>(v5);
        0x2::table::add<u64, Round>(&mut arg1.rounds, arg2, new_round(arg2, arg2 + arg1.distribute_delay_ms, arg3));
        arg1.current_target_ms = arg2;
    }

    public entry fun unpause_distribute<T0>(arg0: &AdminCap, arg1: &mut Game<T0>) {
        arg1.distribute_paused = false;
    }

    public entry fun unpause_game<T0>(arg0: &AdminCap, arg1: &mut Game<T0>) {
        arg1.is_paused = false;
        let v0 = GameUnpausedEvent{dummy_field: false};
        0x2::event::emit<GameUnpausedEvent>(v0);
    }

    public entry fun update_bet_cap<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64) {
        arg1.bet_cap = arg2;
    }

    public entry fun update_bet_limits<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: u64) {
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
    }

    public entry fun update_distribute_delay<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64) {
        arg1.distribute_delay_ms = arg2;
    }

    public entry fun update_fee<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64) {
        assert!(arg2 <= 1000, 15);
        arg1.fee_bps = arg2;
    }

    fun update_player_stats(arg0: &mut PlayerStats, arg1: &UserBet, arg2: u8, arg3: u64) {
        let v0 = get_result(arg1.choice, arg2);
        arg0.total_won = arg0.total_won + arg3;
        if (v0 == 1) {
            arg0.win_count = arg0.win_count + 1;
            arg0.current_streak = arg0.current_streak + 1;
            if (arg0.current_streak > arg0.max_streak) {
                arg0.max_streak = arg0.current_streak;
            };
        } else if (v0 == 2) {
            arg0.lose_count = arg0.lose_count + 1;
            arg0.current_streak = 0;
        } else {
            arg0.tie_count = arg0.tie_count + 1;
        };
    }

    public entry fun update_project_wallet<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: address) {
        arg1.project_wallet = arg2;
    }

    public entry fun update_round_timing<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: u64) {
        assert!(arg2 > arg3, 16);
        arg1.round_duration_ms = arg2;
        arg1.buffer_ms = arg3;
    }

    public entry fun withdraw_vault<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.vault);
        assert!(v0 >= arg2, 17);
        let v1 = if (0x2::table::contains<u64, Round>(&arg1.rounds, arg1.current_target_ms)) {
            let v2 = 0x2::table::borrow<u64, Round>(&arg1.rounds, arg1.current_target_ms);
            if (v2.total_wagered > arg1.bet_cap) {
                v2.total_wagered
            } else {
                arg1.bet_cap
            }
        } else {
            arg1.bet_cap
        };
        assert!(v0 - arg2 >= v1 * (20000 - arg1.fee_bps - 10000) / 10000, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, arg2), arg3), arg1.project_wallet);
        let v3 = VaultWithdrawn{
            amount : arg2,
            to     : arg1.project_wallet,
        };
        0x2::event::emit<VaultWithdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

