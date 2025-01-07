module 0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        min_bet_value: u64,
        max_bet_value: u64,
        fee_percentage: u64,
        bonus_frequency: u64,
        bonus_weights: vector<u64>,
        bonus_values: vector<u64>,
        pool: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        total_plays: u64,
        total_wins: u64,
        total_losses: u64,
        total_volume: u128,
        total_fees: u128,
        total_bonus_plays: u64,
        total_bonus_wins: u64,
        total_bonus_losses: u64,
        total_bonus_volume: u128,
    }

    struct Created has copy, drop {
        game: 0x2::object::ID,
    }

    struct Played has copy, drop {
        game: 0x2::object::ID,
        player: address,
        win: bool,
        bet: u64,
        prize: u64,
    }

    struct BonusPlayed has copy, drop {
        game: 0x2::object::ID,
        player: address,
        bonus: u64,
    }

    entry fun new<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        let v0 = Game<T0>{
            id                 : 0x2::object::new(arg1),
            min_bet_value      : 1000000,
            max_bet_value      : 100000000000,
            fee_percentage     : 2,
            bonus_frequency    : 25,
            bonus_weights      : vector[60, 25, 10, 5],
            bonus_values       : vector[0, 2, 5, 10],
            pool               : 0x2::balance::zero<T0>(),
            fees               : 0x2::balance::zero<T0>(),
            total_plays        : 0,
            total_wins         : 0,
            total_losses       : 0,
            total_volume       : 0,
            total_fees         : 0,
            total_bonus_plays  : 0,
            total_bonus_wins   : 0,
            total_bonus_losses : 0,
            total_bonus_volume : 0,
        };
        0x2::transfer::share_object<Game<T0>>(v0);
        let v1 = Created{game: 0x2::object::id<Game<T0>>(&v0)};
        0x2::event::emit<Created>(v1);
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<GAME>(arg0), 0);
    }

    fun bonus_play<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::random::RandomGenerator, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::random_utils::weighted_random_choice<u64>(arg0.bonus_weights, arg0.bonus_values, arg1);
        let v1 = 0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_split_percent_to_coin<T0>(&mut arg0.fees, v0, arg2);
        update_bonus_stats<T0>(arg0, 0x2::coin::value<T0>(&v1));
        0x2::pay::keep<T0>(v1, arg2);
        let v2 = BonusPlayed{
            game   : 0x2::object::id<Game<T0>>(arg0),
            player : 0x2::tx_context::sender(arg2),
            bonus  : v0,
        };
        0x2::event::emit<BonusPlayed>(v2);
    }

    entry fun burn_fees<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_withdraw_all_to_coin<T0>(&mut arg1.fees, arg2), @0x0);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<GAME>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun is_bonus_play<T0>(arg0: &Game<T0>) : bool {
        arg0.total_plays % arg0.bonus_frequency == 0
    }

    entry fun play<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.min_bet_value, 1);
        assert!(0x2::coin::value<T0>(&arg2) <= arg0.max_bet_value, 1);
        let v0 = 0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::coin_split_percent_to_coin<T0>(&mut arg2, arg0.fee_percentage, arg3);
        0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_top_up<T0>(&mut arg0.fees, v0);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= 0x2::coin::value<T0>(&arg2), 3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = v1 * 2;
        0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_top_up<T0>(&mut arg0.pool, arg2);
        let v3 = 0x2::random::new_generator(arg1, arg3);
        let v4 = 0x2::random::generate_bool(&mut v3);
        if (v4) {
            0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_withdraw<T0>(&mut arg0.pool, v2, arg3);
        };
        update_stats<T0>(arg0, v4, v1, 0x2::coin::value<T0>(&v0));
        if (is_bonus_play<T0>(arg0)) {
            let v5 = &mut v3;
            bonus_play<T0>(arg0, v5, arg3);
        };
        let v6 = Played{
            game   : 0x2::object::id<Game<T0>>(arg0),
            player : 0x2::tx_context::sender(arg3),
            win    : v4,
            bet    : v1,
            prize  : v2,
        };
        0x2::event::emit<Played>(v6);
    }

    entry fun set_bonus_frequency<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin(arg0);
        arg1.bonus_frequency = arg2;
    }

    entry fun set_bonus_weights_and_values<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: vector<u64>, arg3: vector<u64>) {
        assert_admin(arg0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        arg1.bonus_weights = arg2;
        arg1.bonus_values = arg3;
    }

    entry fun set_fee_percentage<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin(arg0);
        assert!(arg2 <= 10, 2);
        arg1.fee_percentage = arg2;
    }

    entry fun set_max_bet_value<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin(arg0);
        assert!(arg2 > arg1.min_bet_value, 1);
        arg1.max_bet_value = arg2;
    }

    entry fun set_min_bet_value<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: u64) {
        assert_admin(arg0);
        assert!(arg2 < arg1.max_bet_value, 1);
        arg1.min_bet_value = arg2;
    }

    entry fun top_up_pool<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_top_up<T0>(&mut arg0.pool, arg1);
    }

    fun update_bonus_stats<T0>(arg0: &mut Game<T0>, arg1: u64) {
        arg0.total_bonus_plays = arg0.total_bonus_plays + 1;
        if (arg1 > 0) {
            arg0.total_bonus_wins = arg0.total_bonus_wins + 1;
        } else {
            arg0.total_bonus_losses = arg0.total_bonus_losses + 1;
        };
        arg0.total_bonus_volume = arg0.total_bonus_volume + (arg1 as u128);
    }

    fun update_stats<T0>(arg0: &mut Game<T0>, arg1: bool, arg2: u64, arg3: u64) {
        arg0.total_plays = arg0.total_plays + 1;
        if (arg1) {
            arg0.total_wins = arg0.total_wins + 1;
        } else {
            arg0.total_losses = arg0.total_losses + 1;
        };
        arg0.total_volume = arg0.total_volume + (arg2 as u128);
        arg0.total_fees = arg0.total_fees + (arg3 as u128);
    }

    entry fun withdraw_fees<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_withdraw_all<T0>(&mut arg1.fees, arg2);
    }

    entry fun withdraw_pool<T0>(arg0: &0x2::package::Publisher, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        0xacb32e9d13c584e017f7a27e98ca4c7323082a0d4423583a06e8766906fa6dfb::pay_utils::balance_withdraw_all<T0>(&mut arg1.pool, arg2);
    }

    // decompiled from Move bytecode v6
}

