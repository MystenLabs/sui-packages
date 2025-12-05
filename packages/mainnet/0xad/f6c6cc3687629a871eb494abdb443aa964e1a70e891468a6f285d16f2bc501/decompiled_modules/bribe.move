module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe {
    struct Reward has copy, drop, store {
        period_finish: u64,
        rewards_per_epoch: u64,
        last_update_time: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bribe has store, key {
        id: 0x2::object::UID,
        version: u8,
        first_bribe_timestamp: u64,
        reward_data: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>,
        reward_coins: 0x2::bag::Bag,
        user_reward_per_token_paid: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
        user_timestamp: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
        total_supply: 0x2::table::Table<u64, u64>,
        balances: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<u64, u64>>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RewardWithType has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        rewards: u64,
    }

    public fun id(arg0: &Bribe) : 0x2::object::ID {
        0x2::object::id<Bribe>(arg0)
    }

    public fun all_lock_earned(arg0: &Bribe, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : vector<RewardWithType> {
        let v0 = 0x1::vector::empty<RewardWithType>();
        let v1 = 0x2::linked_table::front<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
            if (0x1::option::is_some<0x1::type_name::TypeName>(v1)) {
                let v2 = 0x1::option::borrow<0x1::type_name::TypeName>(v1);
                let v3 = earned_internal(arg0, *v2, arg1, arg2);
                if (v3 > 0) {
                    let v4 = RewardWithType{
                        coin_type : *v2,
                        rewards   : v3,
                    };
                    0x1::vector::push_back<RewardWithType>(&mut v0, v4);
                };
                v1 = 0x2::linked_table::next<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, *v2);
            };
        };
        v0
    }

    public fun all_rewards(arg0: &Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : vector<RewardWithType> {
        let v0 = 0x2::linked_table::front<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data);
        let v1 = 0x1::vector::empty<RewardWithType>();
        let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg1);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
            if (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
                let v3 = 0x1::option::borrow<0x1::type_name::TypeName>(v0);
                let v4 = 0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, *v3);
                if (0x2::linked_table::contains<u64, Reward>(v4, v2)) {
                    let v5 = RewardWithType{
                        coin_type : *v3,
                        rewards   : 0x2::linked_table::borrow<u64, Reward>(v4, v2).rewards_per_epoch,
                    };
                    0x1::vector::push_back<RewardWithType>(&mut v1, v5);
                };
                v0 = 0x2::linked_table::next<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, *v3);
            };
        };
        v1
    }

    public fun balance_of(arg0: &Bribe, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        balance_of_at(arg0, arg1, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::next_epoch_start(arg2))
    }

    public fun balance_of_at(arg0: &Bribe, arg1: 0x2::object::ID, arg2: u64) : u64 {
        balance_of_at_(arg0, arg1, arg2)
    }

    fun balance_of_at_(arg0: &Bribe, arg1: 0x2::object::ID, arg2: u64) : u64 {
        if (0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, arg1)) {
            if (0x2::table::contains<u64, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, arg1), arg2)) {
                *0x2::table::borrow<u64, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, arg1), arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun carry_bribes_to_next_epoch(arg0: &mut Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock) {
        carry_bribes_to_next_epoch_(arg0, arg1, arg2, arg3);
    }

    fun carry_bribes_to_next_epoch_(arg0: &mut Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        if (arg0.first_bribe_timestamp == 0) {
            return
        };
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg2);
        let v1 = v0 - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        if (total_supply_at(arg0, v1) > 0) {
            return
        };
        let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::whitelisted_coins(arg1);
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.whitelist);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v2, &v5)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v2);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v2);
            if (0x2::linked_table::contains<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, v7)) {
                if (0x2::linked_table::contains<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, v7), v1)) {
                    let v8 = *0x2::linked_table::borrow<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, v7), v1);
                    if (v8.rewards_per_epoch > 0 && v8.period_finish <= v0) {
                        let v9 = Reward{
                            period_finish     : v0 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK(),
                            rewards_per_epoch : v8.rewards_per_epoch,
                            last_update_time  : 0x2::clock::timestamp_ms(arg3),
                        };
                        0x2::linked_table::push_back<u64, Reward>(0x2::linked_table::borrow_mut<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&mut arg0.reward_data, v7), v0, v9);
                    };
                };
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v2);
    }

    public(friend) fun deposit(arg0: &mut Bribe, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &mut 0x2::tx_context::TxContext) {
        deposit_(arg0, arg1, arg2, arg3, arg4);
    }

    fun deposit_(arg0: &mut Bribe, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3);
        if (!0x2::table::contains<u64, u64>(&arg0.total_supply, v0)) {
            0x2::table::add<u64, u64>(&mut arg0.total_supply, v0, 0);
        };
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2))) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, u64>>(&mut arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2), 0x2::table::new<u64, u64>(arg4));
        };
        if (!0x2::table::contains<u64, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0)) {
            0x2::table::add<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, u64>>(&mut arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0, 0);
        };
        *0x2::table::borrow_mut<u64, u64>(&mut arg0.total_supply, v0) = *0x2::table::borrow<u64, u64>(&arg0.total_supply, v0) + arg1;
        *0x2::table::borrow_mut<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, u64>>(&mut arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0) = *0x2::table::borrow<u64, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0) + arg1;
    }

    public fun earned<T0>(arg0: &Bribe, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        earned_internal(arg0, 0x1::type_name::get<T0>(), arg1, arg2)
    }

    fun earned_(arg0: &Bribe, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64) : u64 {
        let v0 = balance_of_at(arg0, arg1, arg3);
        if (v0 == 0) {
            return 0
        };
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(reward_per_token(arg0, arg2, arg3), v0, 0x1::u64::pow(10, 9))
    }

    fun earned_internal(arg0: &Bribe, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3);
        let v3 = 0;
        if (0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg2)) {
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg2), arg1)) {
                v3 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg2), arg1);
            };
        };
        if (v3 == v2) {
            return 0
        };
        if (v3 < arg0.first_bribe_timestamp) {
            v3 = arg0.first_bribe_timestamp - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        };
        while (v0 < 50) {
            if (v3 == v2) {
                break
            };
            v1 = v1 + earned_(arg0, arg2, arg1, v3);
            v3 = v3 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            v0 = v0 + 1;
        };
        v1
    }

    fun earned_with_timestamp(arg0: &Bribe, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg1)) {
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg1), arg2)) {
                v2 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, arg1), arg2);
            };
        };
        if (v2 < arg0.first_bribe_timestamp) {
            v2 = arg0.first_bribe_timestamp - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        };
        while (v0 < 50) {
            if (v2 == 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3)) {
                break
            };
            v1 = v1 + earned_(arg0, arg1, arg2, v2);
            v2 = v2 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun get_reward<T0>(arg0: &mut Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        get_reward_<T0>(arg0, arg1, arg2, arg3)
    }

    fun get_reward_<T0>(arg0: &mut Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = earned_with_timestamp(arg0, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), v0, arg2);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1))) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.user_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1), 0x2::table::new<0x1::type_name::TypeName, u64>(arg3));
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.user_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.user_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v0, 0);
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.user_timestamp, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg1)), v0) = v2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_coins, v0), v1), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_bribe<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Bribe {
        init_bribe_<T0, T1>(arg0)
    }

    fun init_bribe_<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Bribe {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T1>());
        Bribe{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            first_bribe_timestamp      : 0,
            reward_data                : 0x2::linked_table::new<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(arg0),
            reward_coins               : 0x2::bag::new(arg0),
            user_reward_per_token_paid : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg0),
            user_timestamp             : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg0),
            total_supply               : 0x2::table::new<u64, u64>(arg0),
            balances                   : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, u64>>(arg0),
            whitelist                  : v0,
        }
    }

    public fun is_reward_coin<T0>(arg0: &Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist) : bool {
        is_reward_coin_<T0>(arg0, arg1)
    }

    fun is_reward_coin_<T0>(arg0: &Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0) || 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::is_whitelisted(arg1, v0)
    }

    public(friend) fun migrate(arg0: &mut Bribe, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906836124258533375);
        arg0.version = 1;
    }

    public fun notify_reward_amount<T0>(arg0: &mut Bribe, arg1: 0x2::coin::Coin<T0>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        notify_reward_amount_<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun notify_reward_amount_<T0>(arg0: &mut Bribe, arg1: 0x2::coin::Coin<T0>, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(is_reward_coin<T0>(arg0, arg2), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3);
        if (arg0.first_bribe_timestamp == 0) {
            arg0.first_bribe_timestamp = v1;
        };
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, v0)) {
            0x2::linked_table::push_back<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&mut arg0.reward_data, v0, 0x2::linked_table::new<u64, Reward>(arg5));
        };
        if (!0x2::linked_table::contains<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, v0), v1)) {
            let v2 = Reward{
                period_finish     : 0,
                rewards_per_epoch : 0,
                last_update_time  : 0,
            };
            0x2::linked_table::push_back<u64, Reward>(0x2::linked_table::borrow_mut<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&mut arg0.reward_data, v0), v1, v2);
        };
        let v3 = 0x2::linked_table::borrow_mut<u64, Reward>(0x2::linked_table::borrow_mut<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&mut arg0.reward_data, v0), v1);
        v3.rewards_per_epoch = v3.rewards_per_epoch + 0x2::coin::value<T0>(&arg1);
        v3.last_update_time = 0x2::clock::timestamp_ms(arg4);
        v3.period_finish = v1 + 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::consts::WEEK();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_coins, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_coins, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_coins, v0), 0x2::coin::into_balance<T0>(arg1));
    }

    public fun reward_per_token(arg0: &Bribe, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        reward_per_token_(arg0, arg1, arg2)
    }

    fun reward_per_token_(arg0: &Bribe, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, arg1) || !0x2::linked_table::contains<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, arg1), arg2)) {
            return 0
        };
        if (!0x2::table::contains<u64, u64>(&arg0.total_supply, arg2) || *0x2::table::borrow<u64, u64>(&arg0.total_supply, arg2) == 0) {
            return 0x2::linked_table::borrow<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, arg1), arg2).rewards_per_epoch
        };
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::linked_table::borrow<u64, Reward>(0x2::linked_table::borrow<0x1::type_name::TypeName, 0x2::linked_table::LinkedTable<u64, Reward>>(&arg0.reward_data, arg1), arg2).rewards_per_epoch, 0x1::u64::pow(10, 9), *0x2::table::borrow<u64, u64>(&arg0.total_supply, arg2))
    }

    public fun total_supply(arg0: &Bribe, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        total_supply_at(arg0, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg1))
    }

    public fun total_supply_at(arg0: &Bribe, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(&arg0.total_supply, arg1)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(&arg0.total_supply, arg1)
    }

    public(friend) fun withdraw(arg0: &mut Bribe, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        withdraw_(arg0, arg1, arg2, arg3);
    }

    fun withdraw_(arg0: &mut Bribe, arg1: u64, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::active_period(arg3);
        let v1 = *0x2::table::borrow<u64, u64>(&arg0.total_supply, v0);
        let v2 = *0x2::table::borrow<u64, u64>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, u64>>(&arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0);
        if (v1 >= arg1) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.total_supply, v0) = v1 - arg1;
        } else {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.total_supply, v0) = 0;
        };
        if (v2 >= arg1) {
            *0x2::table::borrow_mut<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, u64>>(&mut arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0) = v2 - arg1;
        } else {
            *0x2::table::borrow_mut<u64, u64>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, u64>>(&mut arg0.balances, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::id(arg2)), v0) = 0;
        };
    }

    // decompiled from Move bytecode v6
}

