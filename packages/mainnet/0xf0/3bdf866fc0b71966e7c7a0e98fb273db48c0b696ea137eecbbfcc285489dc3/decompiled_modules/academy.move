module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::academy {
    struct TrainingDiver has key {
        id: 0x2::object::UID,
        diver: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver,
        start_time: u64,
        training_duration_ms: u64,
        training_type: u8,
        r_value: u8,
    }

    struct TrainingStartEvent has copy, drop {
        diver_id: 0x2::object::ID,
        training_type: u8,
        start_time: u64,
        training_duration_ms: u64,
        r_value: u8,
    }

    struct TrainingResultEvent has copy, drop {
        diver_id: 0x2::object::ID,
        training_type: u8,
        value: u8,
        is_upgrade: bool,
    }

    entry fun batch_start_training(arg0: vector<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg7: u8, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        let v0 = 0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&arg0);
        assert!(v0 <= 200, 5);
        let v1 = if (arg7 == 0) {
            true
        } else if (arg7 == 1) {
            true
        } else if (arg7 == 2) {
            true
        } else if (arg7 == 3) {
            true
        } else {
            arg7 == 4
        };
        assert!(v1, 1);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v0) {
            let v4 = 0x1::vector::pop_back<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&mut arg0);
            let v5 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_level(&v4);
            if (arg7 != 4) {
                assert!(v5 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_max_level(), 2);
            };
            if (v5 == 9) {
                assert!(arg7 == 3 || arg7 == 4, 4);
            };
            if (arg7 == 0) {
                assert!(v5 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_max_level() - 2, 4);
            };
            if (arg7 == 1) {
                assert!(v5 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_max_level() - 3, 4);
            };
            if (arg7 == 2) {
                assert!(v5 >= 1, 4);
                assert!(v5 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_max_level() - 4, 4);
            };
            if (arg7 == 3) {
                assert!(v5 == 9, 4);
            };
            let v6 = if (arg7 == 4) {
                0
            } else {
                calc_training_cost(v5, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_rarity(&v4))
            };
            v3 = v3 + v6;
            start_training(v4, arg7, arg8, arg9, arg10);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1) == v3, 0);
        0x1::vector::destroy_empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(arg0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_training_times_distribution(arg3, arg7, v0);
        if (arg7 == 4) {
            0x2::coin::destroy_zero<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(arg1);
            return
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg5, arg1, arg2, arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_training(), arg9, arg10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg4, v3, arg6);
    }

    fun calc_training_cost(arg0: u64, arg1: u8) : u64 {
        if (arg0 == 0) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::base_training_cost()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::base_training_cost() * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::pow_with_decimals(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::get_training_cost_growth_rate_by_rarity(arg1), arg0) / 100
        }
    }

    entry fun finish_training(arg0: TrainingDiver, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &0x2::clock::Clock, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= training_diver_finish_time(&arg0), 3);
        let v0 = internal_finish_training(arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(v0, 0x2::tx_context::sender(arg4));
    }

    fun internal_finish_training(arg0: TrainingDiver, arg1: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg2: &mut 0x2::tx_context::TxContext) : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver {
        let TrainingDiver {
            id                   : v0,
            diver                : v1,
            start_time           : _,
            training_duration_ms : _,
            training_type        : v4,
            r_value              : v5,
        } = arg0;
        let v6 = v1;
        let v7 = if (v4 == 0) {
            true
        } else if (v4 == 1) {
            true
        } else if (v4 == 2) {
            true
        } else if (v4 == 3) {
            true
        } else {
            v4 == 4
        };
        assert!(v7, 1);
        let v8 = 0;
        let v9 = true;
        if (v4 == 0) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 1);
            v8 = 1;
        } else if (v4 == 1) {
            if (v5 > 40 && v5 <= 70) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 1);
                v8 = 1;
            } else if (v5 > 70) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 2);
                v8 = 2;
            };
        } else if (v4 == 2) {
            if (v5 <= 25) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::downgrade_diver(&mut v6, 1);
                v8 = 1;
                v9 = false;
            } else if (v5 > 45 && v5 <= 65) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 1);
                v8 = 1;
            } else if (v5 > 65 && v5 <= 85) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 2);
                v8 = 2;
            } else if (v5 > 85) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 3);
                v8 = 3;
            };
        } else if (v4 == 3) {
            if (v5 <= 50) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::downgrade_diver(&mut v6, 1);
                v8 = 1;
                v9 = false;
            } else {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::upgrade_diver(&mut v6, 1);
                v8 = 1;
            };
        } else if (v4 == 4) {
            if (v5 > 80) {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::mint_diving_tank_for_reef_plant_diver(2, arg2);
                v8 = 2;
            } else {
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::mint_diving_tank_for_reef_plant_diver(1, arg2);
                v8 = 1;
            };
        };
        0x2::object::delete(v0);
        let v10 = TrainingResultEvent{
            diver_id      : 0x2::object::id<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v6),
            training_type : v4,
            value         : v8,
            is_upgrade    : v9,
        };
        0x2::event::emit<TrainingResultEvent>(v10);
        v6
    }

    entry fun skip_training(arg0: TrainingDiver, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::skip_training_cost_in_sui(), 0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_in_game_purchase_treasury(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_skip_training());
        let v1 = internal_finish_training(arg0, arg3, arg4);
        0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(v1, 0x2::tx_context::sender(arg4));
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_in_game_purchase_payment(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_skip_training(), v0);
    }

    fun start_training(arg0: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg1: u8, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let v2 = if (arg1 == 4) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::reed_plant_duration_ms()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::training_duration_ms()
        };
        let v3 = TrainingDiver{
            id                   : 0x2::object::new(arg4),
            diver                : arg0,
            start_time           : 0x2::clock::timestamp_ms(arg3),
            training_duration_ms : v2,
            training_type        : arg1,
            r_value              : v1,
        };
        0x2::transfer::transfer<TrainingDiver>(v3, 0x2::tx_context::sender(arg4));
        let v4 = TrainingStartEvent{
            diver_id             : 0x2::object::id<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&arg0),
            training_type        : arg1,
            start_time           : 0x2::clock::timestamp_ms(arg3),
            training_duration_ms : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::training_duration_ms(),
            r_value              : v1,
        };
        0x2::event::emit<TrainingStartEvent>(v4);
    }

    fun training_diver_finish_time(arg0: &TrainingDiver) : u64 {
        arg0.start_time + arg0.training_duration_ms
    }

    // decompiled from Move bytecode v6
}

