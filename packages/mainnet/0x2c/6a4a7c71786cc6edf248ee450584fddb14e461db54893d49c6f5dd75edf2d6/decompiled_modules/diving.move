module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diving {
    struct DivingDiver has key {
        id: 0x2::object::UID,
        diver: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver,
        start_time: u64,
        diving_duration_ms: u64,
    }

    struct DivingLoot has key {
        id: 0x2::object::UID,
        collected_by_diver_id: 0x2::object::ID,
        has_fish: bool,
        fish_rarity: u8,
        fish_size: u8,
        fish_gender: u8,
    }

    struct DiverStartDivingEvent has copy, drop {
        diver_id: 0x2::object::ID,
        rarity: u8,
        level: u64,
        nitrogen_saturation: u64,
        diving_type: u8,
    }

    struct DiverFinishDivingEvent has copy, drop {
        diver_id: 0x2::object::ID,
        rarity: u8,
        level: u64,
        total_fishes_obtained: u64,
        total_attempts: u64,
    }

    struct OpenDivingLootEvent has copy, drop {
        diving_loot_id: 0x2::object::ID,
        has_fish: bool,
        fish_rarity: u8,
        fish_size: u8,
        fish_gender: u8,
    }

    entry fun batch_finish_diving(arg0: &0x2::random::Random, arg1: vector<DivingDiver>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &0x2::clock::Clock, arg5: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        let v0 = 0x1::vector::length<DivingDiver>(&arg1);
        assert!(v0 <= 100, 4);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = 0x1::vector::pop_back<DivingDiver>(&mut arg1);
            let v4 = v3.diving_duration_ms;
            v2 = v2 + v4;
            assert!(0x2::clock::timestamp_ms(arg4) >= v3.start_time + v4, 0);
            let v5 = finish_diving(v3, arg0, arg3, arg2, arg6);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::update_nitrogen(&mut v5, arg4);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::increase_nitrogen(&mut v5, arg4);
            0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(v5, 0x2::tx_context::sender(arg6));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<DivingDiver>(arg1);
        let v6 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_diving_time_in_ms();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg2, &v6, v2);
        let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_dive_times();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg2, &v7, v0);
    }

    entry fun batch_open_diving_loot(arg0: vector<DivingLoot>, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &0x2::clock::Clock, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::FishEncyclopedia, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        let v0 = 0x1::vector::length<DivingLoot>(&arg0);
        assert!(v0 <= 100, 4);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v0) {
            let v4 = 0x1::vector::pop_back<DivingLoot>(&mut arg0);
            let DivingLoot {
                id                    : v5,
                collected_by_diver_id : v6,
                has_fish              : v7,
                fish_rarity           : v8,
                fish_size             : v9,
                fish_gender           : v10,
            } = v4;
            let v11 = OpenDivingLootEvent{
                diving_loot_id : 0x2::object::id<DivingLoot>(&v4),
                has_fish       : v7,
                fish_rarity    : v8,
                fish_size      : v9,
                fish_gender    : v10,
            };
            0x2::event::emit<OpenDivingLootEvent>(v11);
            if (v7) {
                let v12 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_encyclopedia_rarity_fish_count(arg5, v8);
                assert!(v12 > 0, 6);
                let v13 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::generate_fish(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_encyclopedia_get_random_fish_id(arg5, v8, 0x2::random::generate_u64_in_range(&mut v1, 0, v12 - 1)), v8, v9, v10, v6, arg1, arg2, arg7);
                0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::emit_collect_fish_event(&v13);
                0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(v13, 0x2::tx_context::sender(arg7));
                v3 = v3 + 1;
            };
            0x2::object::delete(v5);
            v2 = v2 + 1;
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_fishes_obtained(arg3, v3, arg4);
        let v14 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_diving_loot_with_no_fish_collected();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg1, &v14, v0 - v3);
        0x1::vector::destroy_empty<DivingLoot>(arg0);
    }

    entry fun batch_skip_diving(arg0: &0x2::random::Random, arg1: vector<DivingDiver>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        let v0 = 0x1::vector::length<DivingDiver>(&arg1);
        assert!(v0 <= 100, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::skip_diving_cost_in_sui() * v0, 3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_in_game_purchase_treasury(arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), 3);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = 0x1::vector::pop_back<DivingDiver>(&mut arg1);
            v2 = v2 + v3.diving_duration_ms;
            let v4 = finish_diving(v3, arg0, arg4, arg3, arg7);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::update_nitrogen(&mut v4, arg6);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::increase_nitrogen(&mut v4, arg6);
            0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(v4, 0x2::tx_context::sender(arg7));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<DivingDiver>(arg1);
        let v5 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_diving_time_in_ms();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg3, &v5, v2);
        let v6 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_dive_times();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg3, &v6, v0);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_in_game_purchase_payment(arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_skip_diving(), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    fun finish_diving(arg0: DivingDiver, arg1: &0x2::random::Random, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x2::tx_context::TxContext) : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver {
        let DivingDiver {
            id                 : v0,
            diver              : v1,
            start_time         : _,
            diving_duration_ms : _,
        } = arg0;
        let v4 = v1;
        0x2::object::delete(v0);
        let v5 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_rarity(&v4);
        let v6 = 0x2::object::id<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&v4);
        let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_level(&v4);
        let v8 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_base_fishing_attempts();
        let v9 = 0;
        let v10 = 0;
        let v11 = (*0x1::vector::borrow<u8>(&v8, (v5 as u64)) as u64) + v7 / (0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::fishing_attempt_level_bonus_base() as u64);
        assert!(v11 <= 10, 5);
        while (v9 < v11) {
            let (v12, v13) = generate_diving_loot(v5, v7, v6, arg1, arg4);
            0x2::transfer::transfer<DivingLoot>(v12, 0x2::tx_context::sender(arg4));
            v10 = v10 + (v13 as u64);
            v9 = v9 + 1;
        };
        let v14 = DiverFinishDivingEvent{
            diver_id              : v6,
            rarity                : v5,
            level                 : v7,
            total_fishes_obtained : v10,
            total_attempts        : v11,
        };
        0x2::event::emit<DiverFinishDivingEvent>(v14);
        let v15 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_diving_loot_collected();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg3, &v15, v11);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::increase_total_fishes_obtained(&mut v4, v10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::increase_total_dive_times(&mut v4, arg2);
        v4
    }

    fun generate_diving_loot(arg0: u8, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : (DivingLoot, u8) {
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::has_fish_probability();
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::arithmetic_is_less_than_u16((0x2::random::generate_u8_in_range(&mut v1, 1, 100) as u16), (*0x1::vector::borrow<u8>(&v0, (arg0 as u64)) as u16) + (arg1 as u16) + 1, 100);
        let v3 = DivingLoot{
            id                    : 0x2::object::new(arg4),
            collected_by_diver_id : arg2,
            has_fish              : v2 == 1,
            fish_rarity           : v2 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_rarity(&mut v1),
            fish_size             : v2 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_rarity(&mut v1),
            fish_gender           : v2 * 0x2::random::generate_u8_in_range(&mut v1, 1, 2),
        };
        (v3, v2)
    }

    fun start_diving(arg0: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg1: &0x2::clock::Clock, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_rarity(&arg0);
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_level(&arg0);
        let v2 = DivingDiver{
            id                 : 0x2::object::new(arg3),
            diver              : arg0,
            start_time         : 0x2::clock::timestamp_ms(arg1),
            diving_duration_ms : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diving_duration_ms(v0) + 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_level_bonus_ms() * v1,
        };
        let v3 = DiverStartDivingEvent{
            diver_id            : 0x2::object::id<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(&arg0),
            rarity              : v0,
            level               : v1,
            nitrogen_saturation : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_nitrogen_saturation(&arg0),
            diving_type         : arg2,
        };
        0x2::event::emit<DiverStartDivingEvent>(v3);
        0x2::transfer::transfer<DivingDiver>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun start_diving_with_dive_token(arg0: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::update_nitrogen(&mut arg0, arg7);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_nitrogen_saturation(&arg0);
        assert!(v0 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation(), 1);
        assert!(v0 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation_with_dive_token(), 1);
        let v1 = 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1);
        assert!(v1 == 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diving_with_dive_token_cost(), 2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg5, arg1, arg2, arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_diving(), arg7, arg8);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg4, v1, arg6);
        start_diving(arg0, arg7, 1, arg8);
    }

    public fun start_diving_with_diving_tank(arg0: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg1: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::DivingTank, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::update_nitrogen(&mut arg0, arg3);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_nitrogen_saturation(&arg0);
        assert!(v0 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation(), 1);
        assert!(v0 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation_with_dive_token(), 1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::use_diving_tank(arg1);
        start_diving(arg0, arg3, 2, arg4);
    }

    public fun start_diving_with_sui(arg0: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &0x2::clock::Clock, arg4: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::update_nitrogen(&mut arg0, arg3);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::diver_nitrogen_saturation(&arg0);
        assert!(v0 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation(), 1);
        let v1 = if (v0 < 4) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diving_with_sui_tier_1_cost()
        } else if (v0 < 5) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diving_with_sui_tier_2_cost()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diving_with_sui_tier_3_cost()
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 == v1, 2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_in_game_purchase_treasury(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), 2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_in_game_purchase_payment(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_diving_with_sui(), v2);
        start_diving(arg0, arg3, 3, arg5);
    }

    // decompiled from Move bytecode v6
}

