module 0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct GameAdmin has store, key {
        id: 0x2::object::UID,
        game: 0x2::object::ID,
    }

    struct Stats has copy, drop, store {
        total_plays: u64,
        total_wins: u64,
        total_losses: u64,
        total_volume: u128,
        total_fees: u128,
        total_burned_fees: u128,
        total_bonus_plays: u64,
        total_bonus_wins: u64,
        total_bonus_losses: u64,
        total_bonus_volume: u128,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        min_bet_value: u64,
        max_bet_value: u64,
        fee_percentage: u64,
        burn_fee_percentage: u64,
        bonus_frequency: u64,
        bonus_weights: vector<u64>,
        bonus_values: vector<u64>,
        pool: 0x2::balance::Balance<T0>,
        bonus_pool: 0x2::balance::Balance<T0>,
        last_plays: vector<Play>,
        stats: Stats,
        stats_per_address: 0x2::table::Table<address, Stats>,
        plays_per_address: 0x2::table::Table<address, 0x2::table_vec::TableVec<Play>>,
    }

    struct Created has copy, drop {
        game: 0x2::object::ID,
    }

    struct Play has copy, drop, store {
        game: 0x2::object::ID,
        player: address,
        win: bool,
        bet: u64,
        prize: u64,
        is_bonus_play: bool,
        bonus_win: bool,
        bonus_prize: u64,
    }

    entry fun new<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let v0 = Game<T0>{
            id                  : 0x2::object::new(arg1),
            min_bet_value       : 1000000,
            max_bet_value       : 100000000000,
            fee_percentage      : 2,
            burn_fee_percentage : 50,
            bonus_frequency     : 1,
            bonus_weights       : vector[20, 25, 25, 10, 10, 10],
            bonus_values        : vector[0, 200, 600, 1000, 2000, 5000],
            pool                : 0x2::balance::zero<T0>(),
            bonus_pool          : 0x2::balance::zero<T0>(),
            last_plays          : 0x1::vector::empty<Play>(),
            stats               : new_stats(),
            stats_per_address   : 0x2::table::new<address, Stats>(arg1),
            plays_per_address   : 0x2::table::new<address, 0x2::table_vec::TableVec<Play>>(arg1),
        };
        let v1 = 0x2::object::id<Game<T0>>(&v0);
        0x2::transfer::share_object<Game<T0>>(v0);
        let v2 = GameAdmin{
            id   : 0x2::object::new(arg1),
            game : v1,
        };
        0x2::transfer::transfer<GameAdmin>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Created{game: v1};
        0x2::event::emit<Created>(v3);
    }

    fun assert_admin<T0>(arg0: &Game<T0>, arg1: &GameAdmin) {
        assert!(0x2::object::id<Game<T0>>(arg0) == arg1.game, 0);
    }

    fun assert_publisher(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<GAME>(arg0), 0);
    }

    fun bonus_play<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::random::RandomGenerator, arg2: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        let v0 = is_bonus_play<T0>(arg0);
        if (!v0) {
            return (v0, 0)
        };
        let (v1, v2) = if (0x2::random::generate_u64_in_range(arg1, 0, 999) == 0) {
            let v1 = 0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_withdraw_all_to_coin<T0>(&mut arg0.bonus_pool, arg2);
            (v1, 0x2::coin::value<T0>(&v1))
        } else {
            let v3 = 0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::random_utils::weighted_random_choice<u64>(arg0.bonus_weights, arg0.bonus_values, arg1);
            let v1 = 0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_withdraw_to_coin<T0>(&mut arg0.bonus_pool, v3, arg2);
            (v1, v3)
        };
        0x2::pay::keep<T0>(v1, arg2);
        (v0, v2)
    }

    public fun get_address_plays<T0>(arg0: &Game<T0>, arg1: address, arg2: u64) : vector<Play> {
        let v0 = 0x1::vector::empty<Play>();
        let v1 = 0x2::table::borrow<address, 0x2::table_vec::TableVec<Play>>(&arg0.plays_per_address, arg1);
        let v2 = 0x2::table_vec::length<Play>(v1);
        let v3 = arg2 * 10;
        let v4 = (arg2 + 1) * 10;
        let v5 = v4;
        if (v4 > v2) {
            v5 = v2;
        };
        let v6 = 0;
        while (v6 < v5 - v3) {
            0x1::vector::push_back<Play>(&mut v0, *0x2::table_vec::borrow<Play>(v1, v3 + v6));
            v6 = v6 + 1;
        };
        v0
    }

    public fun get_address_plays_total_pages<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        (0x2::table_vec::length<Play>(0x2::table::borrow<address, 0x2::table_vec::TableVec<Play>>(&arg0.plays_per_address, arg1)) - 1) / 10 + 1
    }

    public fun get_address_stats<T0>(arg0: &Game<T0>, arg1: address) : Stats {
        *0x2::table::borrow<address, Stats>(&arg0.stats_per_address, arg1)
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GAME>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun is_bonus_play<T0>(arg0: &Game<T0>) : bool {
        arg0.stats.total_plays % arg0.bonus_frequency == 0
    }

    fun new_stats() : Stats {
        Stats{
            total_plays        : 0,
            total_wins         : 0,
            total_losses       : 0,
            total_volume       : 0,
            total_fees         : 0,
            total_burned_fees  : 0,
            total_bonus_plays  : 0,
            total_bonus_wins   : 0,
            total_bonus_losses : 0,
            total_bonus_volume : 0,
        }
    }

    entry fun play<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.min_bet_value, 1);
        assert!(0x2::coin::value<T0>(&arg2) <= arg0.max_bet_value, 1);
        let v0 = 0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::coin_split_percent_to_coin<T0>(&mut arg2, arg0.fee_percentage, arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::burn_coin<T0>(0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::coin_split_percent_to_coin<T0>(&mut v0, arg0.burn_fee_percentage, arg3));
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_top_up<T0>(&mut arg0.bonus_pool, v0);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= 0x2::coin::value<T0>(&arg2), 3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = v2 * 2;
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_top_up<T0>(&mut arg0.pool, arg2);
        let v4 = 0x2::random::new_generator(arg1, arg3);
        let v5 = 0x2::random::generate_bool(&mut v4);
        if (v5) {
            0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_withdraw<T0>(&mut arg0.pool, v3, arg3);
        };
        let v6 = &mut v4;
        let (v7, v8) = bonus_play<T0>(arg0, v6, arg3);
        let v9 = &mut arg0.stats;
        update_stats(v9, v5, v2, v1, v7, v8);
        update_address_stats<T0>(arg0, 0x2::tx_context::sender(arg3), v5, v2, v1, v7, v8);
        let v10 = Play{
            game          : 0x2::object::id<Game<T0>>(arg0),
            player        : 0x2::tx_context::sender(arg3),
            win           : v5,
            bet           : v2,
            prize         : v3,
            is_bonus_play : v7,
            bonus_win     : v8 > 0,
            bonus_prize   : v8,
        };
        update_last_plays<T0>(arg0, v10);
        update_address_plays<T0>(arg0, v10, arg3);
        0x2::event::emit<Play>(v10);
    }

    entry fun set_bonus_frequency<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin<T0>(arg1, arg0);
        arg1.bonus_frequency = arg2;
    }

    entry fun set_bonus_weights_and_values<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: vector<u64>, arg3: vector<u64>) {
        assert_admin<T0>(arg1, arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        arg1.bonus_weights = arg2;
        arg1.bonus_values = arg3;
    }

    entry fun set_fee_percentage<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin<T0>(arg1, arg0);
        assert!(arg2 <= 10, 2);
        arg1.fee_percentage = arg2;
    }

    entry fun set_max_bet_value<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin<T0>(arg1, arg0);
        assert!(arg2 > arg1.min_bet_value, 1);
        arg1.max_bet_value = arg2;
    }

    entry fun set_min_bet_value<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin<T0>(arg1, arg0);
        assert!(arg2 < arg1.max_bet_value, 1);
        arg1.min_bet_value = arg2;
    }

    entry fun top_up_pool<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_top_up<T0>(&mut arg0.pool, arg1);
    }

    fun update_address_plays<T0>(arg0: &mut Game<T0>, arg1: Play, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.plays_per_address;
        if (!0x2::table::contains<address, 0x2::table_vec::TableVec<Play>>(v1, v0)) {
            0x2::table::add<address, 0x2::table_vec::TableVec<Play>>(v1, v0, 0x2::table_vec::empty<Play>(arg2));
        };
        0x2::table_vec::push_back<Play>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<Play>>(v1, v0), arg1);
    }

    fun update_address_stats<T0>(arg0: &mut Game<T0>, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = &mut arg0.stats_per_address;
        if (!0x2::table::contains<address, Stats>(v0, arg1)) {
            0x2::table::add<address, Stats>(v0, arg1, new_stats());
        };
        let v1 = 0x2::table::borrow_mut<address, Stats>(v0, arg1);
        update_stats(v1, arg2, arg3, arg4, arg5, arg6);
    }

    fun update_last_plays<T0>(arg0: &mut Game<T0>, arg1: Play) {
        let v0 = &mut arg0.last_plays;
        if (0x1::vector::length<Play>(v0) >= 10) {
            0x1::vector::reverse<Play>(v0);
            0x1::vector::pop_back<Play>(v0);
            0x1::vector::reverse<Play>(v0);
        };
        0x1::vector::push_back<Play>(v0, arg1);
    }

    fun update_stats(arg0: &mut Stats, arg1: bool, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        arg0.total_plays = arg0.total_plays + 1;
        if (arg1) {
            arg0.total_wins = arg0.total_wins + 1;
        } else {
            arg0.total_losses = arg0.total_losses + 1;
        };
        arg0.total_volume = arg0.total_volume + (arg2 as u128);
        arg0.total_fees = arg0.total_fees + (arg3 as u128);
        arg0.total_burned_fees = arg0.total_burned_fees + (arg3 as u128) / 2;
        if (arg4) {
            arg0.total_bonus_plays = arg0.total_bonus_plays + 1;
            if (arg5 > 0) {
                arg0.total_bonus_wins = arg0.total_bonus_wins + 1;
            } else {
                arg0.total_bonus_losses = arg0.total_bonus_losses + 1;
            };
            arg0.total_bonus_volume = arg0.total_bonus_volume + (arg5 as u128);
        };
    }

    entry fun withdraw_bonus_pool<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg1, arg0);
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_withdraw_all<T0>(&mut arg1.bonus_pool, arg2);
    }

    entry fun withdraw_pool<T0>(arg0: &GameAdmin, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg1, arg0);
        0x40ef2333155ae6994ab14ef52ba6cbc4f2440b7d433071886b0912307ea7f9c4::pay_utils::balance_withdraw_all<T0>(&mut arg1.pool, arg2);
    }

    // decompiled from Move bytecode v6
}

