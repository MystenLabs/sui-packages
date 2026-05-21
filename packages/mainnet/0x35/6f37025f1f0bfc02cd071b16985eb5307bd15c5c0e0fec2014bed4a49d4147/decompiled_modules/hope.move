module 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::hope {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        entry_fee: u64,
        max_players: u8,
        player_count: u8,
        balance: 0x2::balance::Balance<T0>,
        alive_players: vector<address>,
        round_choices: 0x2::table::Table<address, u8>,
        current_round: u8,
        status: u8,
        created_at: u64,
        deadline: u64,
        fee_bps: u16,
    }

    public fun alive_count<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<address>(&arg0.alive_players)
    }

    public fun close_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_not_admin());
        assert!(arg0.status == 0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg0.status != 3, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_closed());
        assert!(arg0.status != 2, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_resolved());
        assert!(arg0.player_count == 1, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_empty());
        arg0.status = 3;
        while (!0x1::vector::is_empty<address>(&arg0.alive_players)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg0.alive_players);
            if (0x2::table::contains<address, u8>(&arg0.round_choices, v0)) {
                0x2::table::remove<address, u8>(&mut arg0.round_choices, v0);
            };
            if (0x2::balance::value<T0>(&arg0.balance) >= arg0.entry_fee) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.entry_fee), arg2), v0);
            };
        };
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_pool_closed(0x2::object::uid_to_address(&arg0.id), arg0.creator, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 0x2::balance::value<T0>(&arg0.balance), 0x2::clock::timestamp_ms(arg1) / 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2), arg0.creator);
    }

    public fun create_pool<T0>(arg0: u64, arg1: u8, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::Config, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_coin_listed<T0>(arg5), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_coin_not_listed());
        assert!(arg0 > 0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_zero_entry_fee());
        assert!(arg1 >= 2 && arg1 <= 100, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_max_players());
        assert!(arg2 <= 2592000, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_duration());
        assert!(0x2::coin::value<T0>(&arg3) == arg0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_entry_fee());
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v3 = v2 + arg2;
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v4);
        let v6 = Pool<T0>{
            id            : v0,
            creator       : v4,
            entry_fee     : arg0,
            max_players   : arg1,
            player_count  : 1,
            balance       : 0x2::coin::into_balance<T0>(arg3),
            alive_players : v5,
            round_choices : 0x2::table::new<address, u8>(arg6),
            current_round : 0,
            status        : 0,
            created_at    : v2,
            deadline      : v3,
            fee_bps       : 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::fee_bps(arg5),
        };
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_pool_created(v1, v4, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), arg0, arg1, v6.fee_bps, v2, v3);
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_player_joined(v1, v4, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 255, arg0, v2);
        0x2::transfer::public_share_object<Pool<T0>>(v6);
    }

    public fun created_at<T0>(arg0: &Pool<T0>) : u64 {
        arg0.created_at
    }

    public fun creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun current_round<T0>(arg0: &Pool<T0>) : u8 {
        arg0.current_round
    }

    public fun deadline<T0>(arg0: &Pool<T0>) : u64 {
        arg0.deadline
    }

    fun determine_winner(arg0: u8, arg1: u64, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : u8 {
        if (arg1 == 0) {
            return 1
        };
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x2::random::new_generator(arg3, arg4);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 1) == 0) {
            0
        } else {
            1
        }
    }

    fun distribute_rewards<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0.alive_players);
        if (v0 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg5), arg0.creator);
            0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_pool_resolved(0x2::object::uid_to_address(&arg0.id), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 255, arg2, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
            return
        };
        let (v1, v2) = 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::math::calculate_winner_payout(arg1, v0);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg0.alive_players, v3);
            let v5 = if (v3 == v0 - 1) {
                v1 + v2
            } else {
                v1
            };
            0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_rewards_distributed(0x2::object::uid_to_address(&arg0.id), v4, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), v5, 0x2::clock::timestamp_ms(arg4) / 1000);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg5), v4);
            v3 = v3 + 1;
        };
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_pool_resolved(0x2::object::uid_to_address(&arg0.id), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 255, arg2, arg3, 0x2::clock::timestamp_ms(arg4) / 1000);
    }

    public fun entry_fee<T0>(arg0: &Pool<T0>) : u64 {
        arg0.entry_fee
    }

    public fun expire_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.deadline, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_expired());
        assert!(arg0.status != 3, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_closed());
        assert!(arg0.status != 2, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_resolved());
        arg0.status = 3;
        while (!0x1::vector::is_empty<address>(&arg0.alive_players)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg0.alive_players);
            if (0x2::table::contains<address, u8>(&arg0.round_choices, v0)) {
                0x2::table::remove<address, u8>(&mut arg0.round_choices, v0);
            };
            if (0x2::balance::value<T0>(&arg0.balance) >= arg0.entry_fee) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.entry_fee), arg2), v0);
            };
        };
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_pool_closed(0x2::object::uid_to_address(&arg0.id), arg0.creator, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 0x2::balance::value<T0>(&arg0.balance), 0x2::clock::timestamp_ms(arg1) / 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2), arg0.creator);
    }

    public fun has_joined_pool<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.alive_players)) {
            if (*0x1::vector::borrow<address>(&arg0.alive_players, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_expired<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.deadline
    }

    public fun is_resolved<T0>(arg0: &Pool<T0>) : bool {
        arg0.status == 2
    }

    public fun join_pool<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_paused(arg3), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_protocol_paused());
        assert!(0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_coin_listed<T0>(arg3), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_coin_not_listed());
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg0.deadline, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_expired());
        assert!(arg0.status == 0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg0.player_count < arg0.max_players, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_full());
        assert!(0x2::coin::value<T0>(&arg1) == arg0.entry_fee, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_entry_fee());
        assert!(!has_joined_pool<T0>(arg0, v0), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_player_already_joined());
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x1::vector::push_back<address>(&mut arg0.alive_players, v0);
        arg0.player_count = arg0.player_count + 1;
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_player_joined(0x2::object::uid_to_address(&arg0.id), v0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), 255, arg0.entry_fee, 0x2::clock::timestamp_ms(arg2) / 1000);
        if (arg0.player_count == arg0.max_players) {
            arg0.status = 1;
        };
    }

    public fun leave_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.status == 0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg0.status != 1, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_locked());
        assert!(has_joined_pool<T0>(arg0, v0), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_player_not_joined());
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.alive_players)) {
            if (*0x1::vector::borrow<address>(&arg0.alive_players, v1) == v0) {
                0x1::vector::swap_remove<address>(&mut arg0.alive_players, v1);
                break
            };
            v1 = v1 + 1;
        };
        arg0.player_count = arg0.player_count - 1;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.entry_fee, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_insufficient_balance());
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_player_left(0x2::object::uid_to_address(&arg0.id), v0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_key<T0>(), arg0.entry_fee, 0x2::clock::timestamp_ms(arg1) / 1000);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.entry_fee), arg2)
    }

    public fun max_players<T0>(arg0: &Pool<T0>) : u8 {
        arg0.max_players
    }

    public fun max_pool_size() : u8 {
        100
    }

    public fun min_pool_size() : u8 {
        2
    }

    entry fun play_round<T0>(arg0: &mut Pool<T0>, arg1: &0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::Config, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_paused(arg1), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_protocol_paused());
        assert!(0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_coin_listed<T0>(arg1), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_coin_not_listed());
        assert!(arg0.status == 1, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg0.status != 2, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_resolved());
        assert!(arg0.status != 3, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_already_closed());
        assert!(arg0.current_round < 255, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_game_already_finished());
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < arg0.deadline, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_expired());
        assert!(has_joined_pool<T0>(arg0, 0x2::tx_context::sender(arg4)), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_not_participant());
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<address>(&arg0.alive_players);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = *0x1::vector::borrow<address>(&arg0.alive_players, v2);
            if (0x2::table::contains<address, u8>(&arg0.round_choices, v3)) {
                let v4 = *0x2::table::borrow<address, u8>(&arg0.round_choices, v3);
                if (v4 == 0) {
                    v0 = v0 + 1;
                    continue
                };
                if (v4 == 1) {
                    v1 = v1 + 1;
                };
            };
        };
        let v5 = determine_winner(arg0.player_count, v0, v1, arg2, arg4);
        arg0.current_round = arg0.current_round + 1;
        let v6 = 0x1::vector::length<address>(&arg0.alive_players);
        while (v6 > 0) {
            v6 = v6 - 1;
            let v7 = *0x1::vector::borrow<address>(&arg0.alive_players, v6);
            let v8 = 0x2::table::contains<address, u8>(&arg0.round_choices, v7) && *0x2::table::borrow<address, u8>(&arg0.round_choices, v7) == v5;
            if (0x2::table::contains<address, u8>(&arg0.round_choices, v7)) {
                0x2::table::remove<address, u8>(&mut arg0.round_choices, v7);
            };
            if (!v8) {
                0x1::vector::remove<address>(&mut arg0.alive_players, v6);
            };
        };
        0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events::emit_round_played(0x2::object::uid_to_address(&arg0.id), arg0.current_round, v5, 0x2::clock::timestamp_ms(arg3) / 1000);
        if (0x1::vector::length<address>(&arg0.alive_players) <= 1) {
            resolve_game<T0>(arg0, arg1, arg3, arg4);
        };
    }

    public fun player_count<T0>(arg0: &Pool<T0>) : u8 {
        arg0.player_count
    }

    public fun pool_balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_status<T0>(arg0: &Pool<T0>) : u8 {
        arg0.status
    }

    public fun pool_status_closed() : u8 {
        3
    }

    public fun pool_status_locked() : u8 {
        1
    }

    public fun pool_status_open() : u8 {
        0
    }

    public fun pool_status_resolved() : u8 {
        2
    }

    public fun position_risk() : u8 {
        1
    }

    public fun position_safe() : u8 {
        0
    }

    fun resolve_game<T0>(arg0: &mut Pool<T0>, arg1: &0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::math::calculate_fee(v0, (arg0.fee_bps as u64));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg3), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::coin_treasury<T0>(arg1));
        };
        distribute_rewards<T0>(arg0, v0 - v1, v0, v1, arg2, arg3);
        arg0.status = 2;
    }

    public fun start_game<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::config::is_coin_listed<T0>(arg2), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_coin_not_listed());
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_not_admin());
        assert!(arg0.status == 0, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg0.player_count >= 2, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_empty());
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 < arg0.deadline, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_expired());
        arg0.status = 1;
    }

    public fun submit_choice<T0>(arg0: &mut Pool<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 1, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_pool_not_open());
        assert!(arg1 == 0 || arg1 == 1, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_position());
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<address>(&arg0.alive_players)) {
            if (*0x1::vector::borrow<address>(&arg0.alive_players, v1) == v0) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_not_participant());
        assert!(!0x2::table::contains<address, u8>(&arg0.round_choices, v0), 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::errors::e_invalid_position());
        0x2::table::add<address, u8>(&mut arg0.round_choices, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

