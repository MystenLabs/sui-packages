module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::aquarium {
    struct Aquarium has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        fishes: vector<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>,
        dive_generation_rate: u64,
        last_dive_token_claim_time: u64,
        last_feed_time: u64,
        slot_count: u64,
        health: u8,
        created_at: u64,
        likes_record: 0x2::table::Table<address, u64>,
    }

    struct PurchaseAquariumEvent has copy, drop {
        aquarium_id: 0x2::object::ID,
    }

    struct UnlockAquariumSlotEvent has copy, drop {
        aquarium_id: 0x2::object::ID,
        after_slot_count: u64,
    }

    struct FeedAquariumEvent has copy, drop {
        aquarium_id: 0x2::object::ID,
        feed_time_interval: u64,
    }

    struct ClaimAquariumYieldEvent has copy, drop {
        aquarium_id: 0x2::object::ID,
        claimed_dive_token: u64,
    }

    fun add_fish(arg0: &mut Aquarium, arg1: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish) : u64 {
        assert!(0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&arg0.fishes) + 1 <= arg0.slot_count, 4);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_release_bonus(&arg1) / 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::aquarium_fish_yield_rate_divisor();
        arg0.dive_generation_rate = arg0.dive_generation_rate + v0;
        0x1::vector::push_back<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&mut arg0.fishes, arg1);
        v0
    }

    entry fun batch_add_fish(arg0: &mut Aquarium, arg1: vector<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 0);
        let v0 = 0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&arg1);
        assert!(0x1::vector::length<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&arg0.fishes) + v0 <= arg0.slot_count, 4);
        settle_aquarium_yield(arg0, arg3, arg2, arg4, arg5, arg6, arg7);
        let v1 = arg0.dive_generation_rate;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = add_fish(arg0, 0x1::vector::pop_back<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&mut arg1));
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        let v5 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_current_fish_in_aquarium_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg2, &v5, v0);
        let v6 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_current_dive_token_yield_rate_in_aquarium();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg2, &v6, v2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_aquariums_yield_rate(), v1, arg0.dive_generation_rate, 0x2::object::id<Aquarium>(arg0));
        0x1::vector::destroy_empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(arg1);
    }

    fun can_purchase_new_aquarium(arg0: u64) : bool {
        arg0 % 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_aquarium_slot_count() == 0
    }

    public fun claim_aquarium_yield(arg0: &mut Aquarium, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        settle_aquarium_yield(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun edit_aquarium_infos(arg0: &mut Aquarium, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg8: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(arg0.owner == 0x2::tx_context::sender(arg10), 0);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::is_valid_aquarium_name(&arg1), 6);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::is_valid_aquarium_description(&arg2), 7);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::aquarium_edit_name_and_description_cost_in_dive_token();
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg3) == v0, 1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg7, arg3, arg6, arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_edit_aquarium_name_and_description(), arg9, arg10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg5, v0, arg8);
        arg0.name = arg1;
        arg0.description = arg2;
    }

    public fun feed_aquarium(arg0: &mut Aquarium, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg8), 0);
        let v0 = arg0.last_feed_time;
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::aquarium_feed_payment();
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1) == v1, 1);
        settle_aquarium_yield(arg0, arg3, arg2, arg6, arg5, arg7, arg8);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg4, arg1, arg3, arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_feed_aquarium(), arg7, arg8);
        arg0.last_feed_time = 0x2::clock::timestamp_ms(arg7);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg5, v1, arg6);
        let v2 = FeedAquariumEvent{
            aquarium_id        : 0x2::object::id<Aquarium>(arg0),
            feed_time_interval : arg0.last_feed_time - v0,
        };
        0x2::event::emit<FeedAquariumEvent>(v2);
    }

    public(friend) fun fish_encyclopedia_reward_aquarium(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        let v0 = Aquarium{
            id                         : 0x2::object::new(arg3),
            name                       : 0x1::string::utf8(b"Fish Encyclopedia Reward"),
            description                : 0x1::string::utf8(b"Fish Encyclopedia Reward"),
            owner                      : 0x2::tx_context::sender(arg3),
            fishes                     : 0x1::vector::empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(),
            dive_generation_rate       : 0,
            last_dive_token_claim_time : 0x2::clock::timestamp_ms(arg2),
            last_feed_time             : 0x2::clock::timestamp_ms(arg2),
            slot_count                 : 30,
            health                     : 100,
            created_at                 : 0x2::clock::timestamp_ms(arg2),
            likes_record               : 0x2::table::new<address, u64>(arg3),
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::purchase_aquarium_slot(arg0, 30);
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_aquarium_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg1, &v1, 1);
        let v2 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_aquarium_slot_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg1, &v2, 30);
        0x2::transfer::transfer<Aquarium>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun purchase_aquarium(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::aquarium_count(arg3) < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_aquarium_count_per_user(), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::aquarium_price_in_sui(), 1);
        assert!(can_purchase_new_aquarium(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::aquarium_slot_count(arg3)), 5);
        let v0 = Aquarium{
            id                         : 0x2::object::new(arg6),
            name                       : arg0,
            description                : arg1,
            owner                      : 0x2::tx_context::sender(arg6),
            fishes                     : 0x1::vector::empty<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(),
            dive_generation_rate       : 0,
            last_dive_token_claim_time : 0x2::clock::timestamp_ms(arg5),
            last_feed_time             : 0x2::clock::timestamp_ms(arg5),
            slot_count                 : 10,
            health                     : 100,
            created_at                 : 0x2::clock::timestamp_ms(arg5),
            likes_record               : 0x2::table::new<address, u64>(arg6),
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::purchase_aquarium(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::purchase_aquarium_slot(arg3, 10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_in_game_purchase_treasury(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), 0);
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_aquarium_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg4, &v1, 1);
        let v2 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_aquarium_slot_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg4, &v2, 10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_in_game_purchase_payment(arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_purchase_aquarium(), 0x2::coin::value<0x2::sui::SUI>(&arg2));
        0x2::transfer::transfer<Aquarium>(v0, 0x2::tx_context::sender(arg6));
        let v3 = PurchaseAquariumEvent{aquarium_id: 0x2::object::id<Aquarium>(&v0)};
        0x2::event::emit<PurchaseAquariumEvent>(v3);
    }

    entry fun remove_fish(arg0: &mut Aquarium, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 0);
        settle_aquarium_yield(arg0, arg3, arg2, arg4, arg5, arg6, arg7);
        let v0 = arg0.dive_generation_rate;
        let (v1, v2) = remove_fish_from_aquarium(arg0, arg1, arg7);
        let v3 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_current_fish_in_aquarium_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::decrement_global_counter_stats(arg2, &v3, 1);
        let v4 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_current_dive_token_yield_rate_in_aquarium();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::decrement_global_counter_stats(arg2, &v4, v1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_aquariums_yield_rate(), v0, arg0.dive_generation_rate, 0x2::object::id<Aquarium>(arg0));
        0x2::transfer::public_transfer<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(v2, 0x2::tx_context::sender(arg7));
    }

    fun remove_fish_from_aquarium(arg0: &mut Aquarium, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x1::vector::remove<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::Fish>(&mut arg0.fishes, arg1);
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish::fish_release_bonus(&v0) / 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::aquarium_fish_yield_rate_divisor();
        if (arg0.dive_generation_rate >= v1) {
            arg0.dive_generation_rate = arg0.dive_generation_rate - v1;
        } else {
            arg0.dive_generation_rate = 0;
        };
        (v1, v0)
    }

    fun settle_aquarium_yield(arg0: &mut Aquarium, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.last_dive_token_claim_time == 0 || arg0.dive_generation_rate == 0) {
            arg0.last_dive_token_claim_time = v0;
            return
        };
        let v1 = arg0.last_feed_time + 86400000;
        let v2 = if (v0 <= v1) {
            v0 - arg0.last_dive_token_claim_time
        } else if (arg0.last_dive_token_claim_time >= v1) {
            0
        } else {
            v1 - arg0.last_dive_token_claim_time
        };
        let v3 = arg0.dive_generation_rate * v2 * 10000 / 86400000;
        if (v3 > 0) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::mint_dive_token(arg1, v3, 0x2::tx_context::sender(arg6), 1, arg6);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_aquarium_yielded(arg4, v3, arg3);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_minted(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_minted_aquarium(), v3);
            arg0.last_dive_token_claim_time = v0;
            let v4 = ClaimAquariumYieldEvent{
                aquarium_id        : 0x2::object::id<Aquarium>(arg0),
                claimed_dive_token : v3,
            };
            0x2::event::emit<ClaimAquariumYieldEvent>(v4);
        };
    }

    public fun unlock_aquarium_slot(arg0: &mut Aquarium, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        assert!(arg0.slot_count < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_aquarium_slot_count(), 3);
        let v0 = if (arg0.slot_count < 20) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::slot_price_tier_1_in_sui()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::slot_price_tier_2_in_sui()
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v0, 1);
        arg0.slot_count = arg0.slot_count + 1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::purchase_aquarium_slot(arg3, 1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_in_game_purchase_treasury(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), 1);
        let v1 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::enum_total_aquarium_slot_count();
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_global_counter_stats(arg2, &v1, 1);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_in_game_purchase_payment(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_in_game_purchase_payment_unlock_aquarium_slot(), 0x2::coin::value<0x2::sui::SUI>(&arg1));
        let v2 = UnlockAquariumSlotEvent{
            aquarium_id      : 0x2::object::id<Aquarium>(arg0),
            after_slot_count : arg0.slot_count,
        };
        0x2::event::emit<UnlockAquariumSlotEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

