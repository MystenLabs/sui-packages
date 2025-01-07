module 0xe31ae103194e7a1a8218b3ac9d1accb88993f706533a323fe7c79e36defc252::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    struct HiveVault has store, key {
        id: 0x2::object::UID,
        streamer_profile: 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile,
        gems_kraft_cap: 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGemKraftCap,
        hive_kraft_cap: 0x2::coin::TreasuryCap<HIVE>,
        stream_buzz_cap: 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveAppAccessCapability,
        active_supply: u64,
    }

    struct StreamerBuzzes<phantom T0> has store, key {
        id: 0x2::object::UID,
        are_live: bool,
        config: StreamerConfig,
        cur_auction_stream: u64,
        stream_init_ms: u64,
        streamer_buzzes: 0x2::linked_table::LinkedTable<u64, vector<StreamBuzz<T0>>>,
        streamers_info: CurrentStreamersInfo,
        sui_for_stream: 0x2::balance::Balance<T0>,
        engagement_scores: EngagementScores,
        bid_pool: 0x2::balance::Balance<T0>,
        leading_bids: LeadingBidsInfo,
        sui_avail_for_pol: 0x2::balance::Balance<T0>,
        is_incrementing: bool,
    }

    struct StreamerConfig has store {
        max_streams_per_slot: u64,
        choosen_buzzes_count: u64,
        winning_bid_points: u64,
        first_rank_assets_limit: u64,
        second_rank_assets_limit: u64,
        third_rank_assets_limit: u64,
        max_streams_to_store: u64,
        min_bid_limit: u64,
        tax_on_bid: u64,
    }

    struct CurrentStreamersInfo has store {
        rank1_profile: 0x1::option::Option<address>,
        rank1_info: StreamerInfo,
        rank2_profile: 0x1::option::Option<address>,
        rank2_info: StreamerInfo,
        rank3_profile: 0x1::option::Option<address>,
        rank3_info: StreamerInfo,
    }

    struct StreamerInfo has copy, store {
        streamer_name: 0x1::option::Option<0x1::string::String>,
        streams_count: u64,
        access_type: u8,
        sui_per_buzz: u64,
        buzz_cost_in_hive: u64,
        remaining_buzzes_count: u64,
        engagement_points: u128,
        collection_name: 0x1::string::String,
    }

    struct EngagementScores has store {
        hive_gems_available: 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGems,
        hive_per_ad_slot: u64,
        bees_available: 0x2::balance::Balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>,
        bees_per_ad_slot: u64,
        ongoing_points_sum: u128,
        user_points_score: 0x2::linked_table::LinkedTable<address, ProfileScore>,
        total_sui_bidded: u64,
        leading_bid_amt: u64,
        points_per_sui_bidded: u128,
        historical_records: 0x2::linked_table::LinkedTable<u64, HistoricalRecord>,
    }

    struct ProfileScore has copy, store {
        stream_epoch: u64,
        points: u64,
        sui_bidded: u64,
        flag: bool,
        buzz_cost_in_hive: u64,
        access_type: u8,
        collection_name: 0x1::string::String,
    }

    struct HistoricalRecord has copy, store {
        hive_for_participants: u64,
        bees_for_participants: u64,
        total_points_sum: u128,
        points_per_sui_bidded: u256,
    }

    struct LeadingBidsInfo has drop, store {
        o_profile_addr: 0x1::option::Option<address>,
        o_bid_amt: u64,
        s_profile_addr: 0x1::option::Option<address>,
        s_bid_amt: u64,
        t_profile_addr: 0x1::option::Option<address>,
        t_bid_amt: u64,
    }

    struct StreamBuzz<phantom T0> has store {
        streamer: address,
        timestamp: u64,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        buzzes: 0x2::linked_table::LinkedTable<address, HiveBuzz<T0>>,
    }

    struct HiveBuzz<phantom T0> has store {
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        sui_earned: 0x2::balance::Balance<T0>,
        is_choosen: bool,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct KraftHive has copy, drop {
        user: address,
        hive_krafted: u64,
    }

    struct BurnHive has copy, drop {
        user: address,
        hive_burnt: u64,
    }

    struct StreamBuzzesConfigUpdated has copy, drop {
        are_live: bool,
        hive_per_ad_slot: u64,
        bees_per_ad_slot: u64,
        tax_on_bid: u64,
        cur_auction_stream: u64,
        winning_bid_points: u64,
        new_buzzes_count: u64,
        max_streams_per_slot: u64,
        first_rank_assets_limit: u64,
        second_rank_assets_limit: u64,
        third_rank_assets_limit: u64,
        max_streams_to_store: u64,
    }

    struct NewStreamerForStream has copy, drop {
        cur_auction_stream: u64,
        rank: u8,
        profile_addr: address,
        username: 0x1::string::String,
        user_address: address,
        access_type: u8,
        buzz_cost_in_hive: u64,
        collection_name: 0x1::string::String,
        hive_rewards: u64,
        bee_rewards: u64,
    }

    struct StreamerNotFoundForStream has copy, drop {
        cur_auction_stream: u64,
        rank: u8,
    }

    struct NewStreamInitiated has copy, drop {
        stream_init_ms: u64,
        streaming_from_epoch: u64,
        hive_for_participants: u64,
        bees_for_participants: u64,
        points_per_sui_bidded: u256,
        total_points_sum: u128,
        points_for_all_bids: u128,
        sui_for_pol_from_bid: u64,
    }

    struct NewStreamerNotFound has copy, drop {
        stream_init_ms: u64,
        streaming_from_epoch: u64,
    }

    struct BidUpdatedByUser has copy, drop {
        bidder_profile: address,
        username: 0x1::string::String,
        bid_amt: u64,
        flag: bool,
        bid_epoch_stream: u64,
        next_stream_from_epoch: u64,
        buzz_cost_in_hive: u64,
        access_type: u8,
        collection_name: 0x1::string::String,
    }

    struct UserBidExpired has copy, drop {
        bidder_profile: address,
        username: 0x1::string::String,
        bid_amt: u64,
        tax_on_bid: u64,
        bid_epoch_stream: u64,
    }

    struct LeadingBidsUpdated has copy, drop {
        rank1_profile: 0x1::option::Option<address>,
        rank1_bid_amt: u64,
        rank2_profile: 0x1::option::Option<address>,
        rank2_bid_amt: u64,
        rank3_profile: 0x1::option::Option<address>,
        rank3_bid_amt: u64,
    }

    struct NewStreamBuzzKrafted has copy, drop {
        cur_auction_stream: u64,
        streamer_profile_addr: address,
        streamer_name: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        stream_index: u64,
        index: u64,
    }

    struct BuzzChoosenForStream has copy, drop {
        rank_index: u64,
        streamer_profile_addr: address,
        stream_index: u64,
        stream_inner_index: u64,
        choosen_buzz_profile: address,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
    }

    struct HiveBuzzForAStreamBuzzKrafted has copy, drop {
        streamer_profile: address,
        stream_index: u64,
        stream_inner_index: u64,
        user_profile: address,
        username: 0x1::string::String,
        user_buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        hive_streamed_to_streamer: u64,
    }

    struct UserLikedStreamBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        stream_index: u64,
        stream_inner_index: u64,
        streamer_profile: address,
        engagement_points: u128,
    }

    struct UserUpvotedHiveBuzz has copy, drop {
        upvoted_by_profile_addr: address,
        upvoted_by_username: 0x1::string::String,
        stream_index: u64,
        stream_inner_index: u64,
        hive_buzz_by_profile: address,
        streamer_profile: address,
        engagement_points: u128,
    }

    struct StreamPointsFinalizedForProfile has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        from_stream: u64,
        points: u64,
        points_from_bid: u64,
        total_points: u64,
        hive_earned: u64,
        bees_earned: u64,
        cur_epoch: u64,
    }

    struct StreamDeleted has copy, drop {
        stream_index: u64,
        stream_length: u64,
    }

    public fun add_bees_for_streaming_incentives<T0>(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg2).engagement_scores.bees_available, arg1);
    }

    public fun add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &mut HiveVault, arg3: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: u8, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let (v1, v2) = authority_check(arg5, 0x2::tx_context::sender(arg11));
        let v3 = 0x2::coin::into_balance<T0>(arg6);
        assert!(arg9 == 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::worker_bee_plan() || arg9 == 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::drone_bee_plan() || arg9 == 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::queen_bee_plan(), 9867);
        let v4 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg11);
        assert!(v4.are_live, 9861);
        assert!(0x2::tx_context::epoch(arg11) < v4.cur_auction_stream + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::stream_duration_epoches(), 9862);
        let v5 = update_user_points<T0>(v4, arg1, arg5, arg3, arg4, v1, v2, v0, 0, true, 0x2::clock::timestamp_ms(arg0), arg7, arg8, arg9, arg10, false, arg11);
        assert!(v5 >= v4.config.min_bid_limit, 9880);
        update_leading_bids<T0>(v1, v5, v4);
        0x2::balance::join<T0>(&mut v4.bid_pool, 0x2::balance::split<T0>(&mut v3, arg7));
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<T0>(v3, v0, arg11);
    }

    public fun add_hive_for_streaming_incentives<T0>(arg0: &mut HiveVault, arg1: &mut 0x2::coin::Coin<HIVE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<HIVE>(0x2::coin::split<HIVE>(arg1, arg2, arg3));
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = burn_hive_and_return_gems(arg0, v0, v1, arg3);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::join(&mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg3).engagement_scores.hive_gems_available, v2);
    }

    public entry fun add_to_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg2, 0x2::tx_context::sender(arg7));
        let v2 = 0x1::option::none<0x1::string::String>();
        if (arg4 != 0x1::string::utf8(b"")) {
            v2 = 0x1::option::some<0x1::string::String>(arg4);
        };
        buzz_check(arg3, v2);
        let v3 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg7);
        let (v4, v5, v6) = is_valid_streamer<T0>(v0, v3);
        assert!(v4, 9862);
        assert!(v5 + 1 <= v3.config.max_streams_per_slot, 9874);
        if (v6 == 1) {
            v3.streamers_info.rank1_info.streams_count = v3.streamers_info.rank1_info.streams_count + 1;
        } else if (v6 == 2) {
            v3.streamers_info.rank2_info.streams_count = v3.streamers_info.rank2_info.streams_count + 1;
        } else {
            v3.streamers_info.rank3_info.streams_count = v3.streamers_info.rank3_info.streams_count + 1;
        };
        internal_add_to_stream_buzz<T0>(v3, v0, arg5, arg6, 0x2::clock::timestamp_ms(arg0), v1, arg3, v2, arg7);
    }

    fun authority_check(arg0: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg1: address) : (address, 0x1::string::String) {
        let (v0, v1, v2, v3) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg0);
        if (!v2) {
            assert!(v3 == arg1, 9873);
        };
        (v0, v1)
    }

    public fun burn_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg2: 0x2::balance::Balance<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::make_forever_subscriber_via_stream(&arg0.gems_kraft_cap, 0, arg1, &mut arg0.streamer_profile);
        let v0 = 0x2::tx_context::sender(arg4);
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg1, burn_hive_and_return_gems(arg0, 0x2::balance::split<HIVE>(&mut arg2, arg3), v0, arg4));
        arg2
    }

    public fun burn_hive_and_return_gems(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<HIVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGems {
        let v0 = 0x2::balance::value<HIVE>(&arg1);
        if (v0 > 0) {
            let v1 = BurnHive{
                user       : arg2,
                hive_burnt : v0,
            };
            0x2::event::emit<BurnHive>(v1);
        };
        arg0.active_supply = arg0.active_supply - v0;
        0x2::coin::burn<HIVE>(&mut arg0.hive_kraft_cap, 0x2::coin::from_balance<HIVE>(arg1, arg3));
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::withdraw_gems_from_comp_profile(&mut arg0.streamer_profile, v0)
    }

    public entry fun burn_hive_for_gems(arg0: &mut HiveVault, arg1: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg2: 0x2::coin::Coin<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_hive_and_return(arg0, arg1, 0x2::coin::into_balance<HIVE>(arg2), arg3, arg4);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    fun buzz_check(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>) {
        assert!(0x1::string::length(&arg0) < 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::max_stream_buzz_length(), 9870);
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v0 = *0x1::option::borrow<0x1::string::String>(&arg1);
            assert!(0x1::string::length(&v0) < 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::max_stream_ipfs_length(), 9869);
        };
    }

    fun calculate_profile_rewards<T0>(arg0: &StreamerBuzzes<T0>, arg1: &ProfileScore) : (u128, u64, u64, u64, bool) {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        if (arg1.stream_epoch != arg0.cur_auction_stream) {
            v2 = true;
            if (0x2::linked_table::contains<u64, HistoricalRecord>(&arg0.engagement_scores.historical_records, arg1.stream_epoch)) {
                let v7 = 0x2::linked_table::borrow<u64, HistoricalRecord>(&arg0.engagement_scores.historical_records, arg1.stream_epoch);
                let v8 = 0;
                if (arg1.sui_bidded > 0 && v7.points_per_sui_bidded > 0) {
                    v8 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((arg1.sui_bidded as u256), v7.points_per_sui_bidded, (1000000000 as u256)) as u64);
                };
                v4 = arg1.points + v8;
                v3 = v7.total_points_sum;
                v5 = v7.hive_for_participants;
                v6 = v7.bees_for_participants;
            };
        } else {
            let v9 = arg1.points;
            v4 = v9;
            let v10 = arg0.engagement_scores.ongoing_points_sum;
            v3 = v10;
            let v11 = arg0.leading_bids.o_bid_amt + arg0.leading_bids.s_bid_amt + arg0.leading_bids.t_bid_amt;
            if (v11 > 0) {
                let v12 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((arg0.config.winning_bid_points as u256), (1000000000 as u256), (v11 as u256));
                v3 = v10 + (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256(v12, (arg0.engagement_scores.total_sui_bidded as u256), (1000000000 as u256)) as u128);
                if (arg1.sui_bidded > 0) {
                    v4 = v9 + (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((arg1.sui_bidded as u256), v12, (1000000000 as u256)) as u64);
                };
            };
            let v13 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(1) + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(2) + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(3);
            let v14 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::percent_precision();
            v5 = arg0.engagement_scores.hive_per_ad_slot * (v14 - v13) / v14;
            v6 = arg0.engagement_scores.bees_per_ad_slot * (v14 - v13) / v14;
        };
        if (v3 > 0) {
            v0 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v4 as u256), (v5 as u256), (v3 as u256)) as u64);
            v1 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v4 as u256), (v6 as u256), (v3 as u256)) as u64);
        };
        (v3, v4, v0, v1, v2)
    }

    fun calculate_winner_rewards<T0>(arg0: &StreamerBuzzes<T0>, arg1: u64) : (u64, u64) {
        let v0 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::percent_precision();
        (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(arg0.engagement_scores.hive_per_ad_slot, arg1, v0), 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(arg0.engagement_scores.bees_per_ad_slot, arg1, v0))
    }

    public fun choose_buzzes_for_sui_rewards<T0>(arg0: &mut HiveVault, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg5));
        let v2 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg5);
        let (v3, _, v5) = is_valid_streamer<T0>(v0, v2);
        assert!(v3, 9862);
        let v6 = 0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v2.streamer_buzzes, arg2);
        assert!(v0 == 0x1::vector::borrow<StreamBuzz<T0>>(v6, 0).streamer, 9883);
        let v7 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(v6, arg3).buzzes, arg4);
        assert!(!v7.is_choosen, 9864);
        let v8 = 0;
        let v9 = 0;
        if (v5 == 1) {
            let v10 = v2.streamers_info.rank1_info.remaining_buzzes_count;
            v8 = v10;
            v9 = v2.streamers_info.rank1_info.sui_per_buzz;
            v2.streamers_info.rank1_info.remaining_buzzes_count = v10 - 1;
        } else if (v5 == 2) {
            let v11 = v2.streamers_info.rank2_info.remaining_buzzes_count;
            v8 = v11;
            v9 = v2.streamers_info.rank2_info.sui_per_buzz;
            v2.streamers_info.rank2_info.remaining_buzzes_count = v11 - 1;
        } else if (v5 == 3) {
            let v12 = v2.streamers_info.rank3_info.remaining_buzzes_count;
            v8 = v12;
            v9 = v2.streamers_info.rank3_info.sui_per_buzz;
            v2.streamers_info.rank3_info.remaining_buzzes_count = v12 - 1;
        };
        assert!(v8 > 0, 9865);
        let v13 = BuzzChoosenForStream{
            rank_index            : v5,
            streamer_profile_addr : v0,
            stream_index          : arg2,
            stream_inner_index    : arg3,
            choosen_buzz_profile  : arg4,
            buzz                  : v7.buzz,
            gen_ai_url            : v7.gen_ai_url,
        };
        0x2::event::emit<BuzzChoosenForStream>(v13);
        0x2::balance::join<T0>(&mut v7.sui_earned, 0x2::balance::split<T0>(&mut v2.sui_for_stream, v9));
    }

    public fun claim_stream_rewards_withdraw_bid<T0>(arg0: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg1: &mut HiveVault, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg3: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = authority_check(arg2, v0);
        let v3 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg5);
        update_user_points<T0>(v3, arg0, arg2, arg3, arg4, v1, v2, v0, 0, false, 0, 0, 0, 0, 0x1::string::utf8(b""), false, arg5);
    }

    public fun cleanup_streams<T0>(arg0: &mut HiveVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg2);
        let v2 = 0x2::linked_table::length<u64, vector<StreamBuzz<T0>>>(&v1.streamer_buzzes);
        if (v2 > v1.config.max_streams_to_store) {
            let v3 = 0;
            while (v3 <= 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::min_u64(v2 - v1.config.max_streams_to_store, arg1)) {
                let v4 = *0x2::linked_table::front<u64, vector<StreamBuzz<T0>>>(&v1.streamer_buzzes);
                let v5 = *0x1::option::borrow<u64>(&v4);
                let v6 = 0x2::linked_table::remove<u64, vector<StreamBuzz<T0>>>(&mut v1.streamer_buzzes, v5);
                let v7 = StreamDeleted{
                    stream_index  : v5,
                    stream_length : 0x1::vector::length<StreamBuzz<T0>>(&v6),
                };
                0x2::event::emit<StreamDeleted>(v7);
                while (0x1::vector::length<StreamBuzz<T0>>(&v6) > 0) {
                    let (_, _, _, _) = destroy_stream_buzz<T0>(0x1::vector::pop_back<StreamBuzz<T0>>(&mut v6), v0, arg2);
                };
                0x1::vector::destroy_empty<StreamBuzz<T0>>(v6);
                v3 = v3 + 1;
            };
        };
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveVault, arg1: &mut 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<HIVE>(deposit_gems_for_hive_and_return(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_gems_for_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGems, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        kraft_hive(arg0, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(arg1, arg2), arg2, 0x2::tx_context::sender(arg3))
    }

    public entry fun deposit_gems_via_profile(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<HIVE>(deposit_gems_via_profile_and_return(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    public fun deposit_gems_via_profile_and_return(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::make_forever_subscriber_via_stream(&arg2.gems_kraft_cap, 0, arg3, &mut arg2.streamer_profile);
        kraft_hive(arg2, 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::withdraw_gems_from_profile(arg0, arg1, arg3, arg4, arg5), arg4, 0x2::tx_context::sender(arg5))
    }

    public fun deposit_hive_to_treasury(arg0: &mut HiveVault, arg1: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg2: 0x2::coin::Coin<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<HIVE>(arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = burn_hive_and_return_gems(arg0, 0x2::balance::split<HIVE>(&mut v0, arg3), v1, arg4);
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_hive_with_manager_profile(arg1, v2);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    fun destroy_hive_buzz<T0>(arg0: HiveBuzz<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::option::Option<0x1::string::String>) {
        let HiveBuzz {
            buzz       : v0,
            gen_ai_url : v1,
            sui_earned : v2,
            is_choosen : v3,
            upvotes    : v4,
        } = arg0;
        let v5 = v2;
        if (v3 && 0x2::balance::value<T0>(&v5) > 0) {
            0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<T0>(v5, arg1, arg2);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        0x2::linked_table::drop<address, bool>(v4);
        (v0, v1)
    }

    fun destroy_stream_buzz<T0>(arg0: StreamBuzz<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (address, u64, 0x1::string::String, 0x1::option::Option<0x1::string::String>) {
        let StreamBuzz {
            streamer   : v0,
            timestamp  : v1,
            buzz       : v2,
            gen_ai_url : v3,
            likes      : v4,
            buzzes     : v5,
        } = arg0;
        let v6 = v5;
        0x2::linked_table::drop<address, bool>(v4);
        while (0x2::linked_table::length<address, HiveBuzz<T0>>(&v6) > 0) {
            let (_, v8) = 0x2::linked_table::pop_back<address, HiveBuzz<T0>>(&mut v6);
            let (_, _) = destroy_hive_buzz<T0>(v8, arg1, arg2);
        };
        0x2::linked_table::destroy_empty<address, HiveBuzz<T0>>(v6);
        (v0, v1, v2, v3)
    }

    public fun get_active_hive_supply(arg0: &HiveVault) : u64 {
        arg0.active_supply
    }

    public fun get_dao_hiveprofile_info(arg0: &HiveVault) : (0x1::string::String, 0x1::string::String, vector<u64>, u64, 0x1::string::String, bool, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_info(&arg0.streamer_profile)
    }

    public fun get_engagement_scores_state<T0>(arg0: &HiveVault) : (u64, u64, u64, u64, u64, u128, u64, u64, u128) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&v0.engagement_scores.hive_gems_available), v0.engagement_scores.hive_per_ad_slot, 0x2::balance::value<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&v0.engagement_scores.bees_available), v0.engagement_scores.bees_per_ad_slot, v0.engagement_scores.total_sui_bidded, v0.engagement_scores.ongoing_points_sum, 0x2::linked_table::length<address, ProfileScore>(&v0.engagement_scores.user_points_score), v0.engagement_scores.leading_bid_amt, v0.engagement_scores.points_per_sui_bidded)
    }

    public fun get_hive_buzz_for_user_for_stream<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : (0x1::string::String, 0x1::option::Option<0x1::string::String>, bool, u64) {
        let v0 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store())).streamer_buzzes, arg2), arg3);
        if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v0.buzzes, arg1)) {
            let v5 = 0x2::linked_table::borrow<address, HiveBuzz<T0>>(&v0.buzzes, arg1);
            (v5.buzz, v5.gen_ai_url, v5.is_choosen, 0x2::balance::value<T0>(&v5.sui_earned))
        } else {
            (0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), false, 0)
        }
    }

    public fun get_leading_bids_info<T0>(arg0: &HiveVault) : (0x1::option::Option<address>, u64, 0x1::option::Option<address>, u64, 0x1::option::Option<address>, u64) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        (v0.leading_bids.o_profile_addr, v0.leading_bids.o_bid_amt, v0.leading_bids.s_profile_addr, v0.leading_bids.s_bid_amt, v0.leading_bids.t_profile_addr, v0.leading_bids.t_bid_amt)
    }

    public fun get_points_for_all_profiles<T0>(arg0: &HiveVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<u64>, vector<u8>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0x1::vector::empty<bool>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        let v13 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, ProfileScore>(&v12.engagement_scores.user_points_score)
        };
        let v14 = v13;
        let v15 = 0;
        while (0x1::option::is_some<address>(&v14) && v15 < arg2) {
            let v16 = *0x1::option::borrow<address>(&v14);
            let v17 = 0x2::linked_table::borrow<address, ProfileScore>(&v12.engagement_scores.user_points_score, v16);
            let (_, v19, v20, v21, v22) = calculate_profile_rewards<T0>(v12, v17);
            0x1::vector::push_back<address>(&mut v0, v16);
            0x1::vector::push_back<u64>(&mut v1, v17.stream_epoch);
            0x1::vector::push_back<u64>(&mut v2, v17.points);
            0x1::vector::push_back<bool>(&mut v3, v17.flag);
            0x1::vector::push_back<u64>(&mut v4, v17.sui_bidded);
            0x1::vector::push_back<u64>(&mut v5, v17.buzz_cost_in_hive);
            0x1::vector::push_back<u8>(&mut v6, v17.access_type);
            0x1::vector::push_back<u64>(&mut v7, v19);
            0x1::vector::push_back<u64>(&mut v8, v20);
            0x1::vector::push_back<u64>(&mut v9, v21);
            0x1::vector::push_back<bool>(&mut v10, v22);
            0x1::vector::push_back<u64>(&mut v11, v19);
            v14 = *0x2::linked_table::next<address, ProfileScore>(&v12.engagement_scores.user_points_score, v16);
            v15 = v15 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, 0x2::linked_table::length<address, ProfileScore>(&v12.engagement_scores.user_points_score))
    }

    fun get_rank_info<T0>(arg0: u64, arg1: &StreamerBuzzes<T0>) : (0x1::option::Option<0x1::string::String>, u64, u8, u64, u64, u64, u128) {
        let v0 = 0x1::option::none<0x1::string::String>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        if (arg0 == 1) {
            v0 = arg1.streamers_info.rank1_info.streamer_name;
            v1 = arg1.streamers_info.rank1_info.streams_count;
            v2 = arg1.streamers_info.rank1_info.access_type;
            v3 = arg1.streamers_info.rank1_info.sui_per_buzz;
            v4 = arg1.streamers_info.rank1_info.buzz_cost_in_hive;
            v5 = arg1.streamers_info.rank1_info.remaining_buzzes_count;
            v6 = arg1.streamers_info.rank1_info.engagement_points;
        } else if (arg0 == 2) {
            v0 = arg1.streamers_info.rank2_info.streamer_name;
            v1 = arg1.streamers_info.rank2_info.streams_count;
            v2 = arg1.streamers_info.rank2_info.access_type;
            v3 = arg1.streamers_info.rank2_info.sui_per_buzz;
            v4 = arg1.streamers_info.rank2_info.buzz_cost_in_hive;
            v5 = arg1.streamers_info.rank2_info.remaining_buzzes_count;
            v6 = arg1.streamers_info.rank2_info.engagement_points;
        } else if (arg0 == 3) {
            v0 = arg1.streamers_info.rank3_info.streamer_name;
            v1 = arg1.streamers_info.rank3_info.streams_count;
            v2 = arg1.streamers_info.rank3_info.access_type;
            v3 = arg1.streamers_info.rank3_info.sui_per_buzz;
            v4 = arg1.streamers_info.rank3_info.buzz_cost_in_hive;
            v5 = arg1.streamers_info.rank3_info.remaining_buzzes_count;
            v6 = arg1.streamers_info.rank3_info.engagement_points;
        };
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun get_state_for_profile<T0>(arg0: &HiveVault, arg1: address) : (u64, u64, bool, u64, u64, u8, 0x1::string::String, u64, u64, u64, bool, u128) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = if (0x2::linked_table::contains<address, ProfileScore>(&v0.engagement_scores.user_points_score, arg1)) {
            let v13 = 0x2::linked_table::borrow<address, ProfileScore>(&v0.engagement_scores.user_points_score, arg1);
            let (v14, v15, v16, v17, v18) = calculate_profile_rewards<T0>(v0, v13);
            (v13.stream_epoch, v17, v18, v14, v13.points, v13.flag, v13.sui_bidded, v13.buzz_cost_in_hive, v13.access_type, v13.collection_name, v15, v16)
        } else {
            (0, 0, false, 0, 0, false, 0, 0, 0, 0x1::string::utf8(b""), 0, 0)
        };
        (v1, v5, v6, v7, v8, v9, v10, v11, v12, v2, v3, v4)
    }

    public fun get_stream_info_for_index<T0>(arg0: &HiveVault, arg1: u64) : (u64, u64, 0x1::string::String, 0x1::option::Option<0x1::string::String>, u64, u64) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        if (0x2::linked_table::contains<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1)) {
            let v7 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1);
            let v8 = 0x1::vector::borrow<StreamBuzz<T0>>(v7, 0);
            (0x1::vector::length<StreamBuzz<T0>>(v7), v8.timestamp, v8.buzz, v8.gen_ai_url, 0x2::linked_table::length<address, bool>(&v8.likes), 0x2::linked_table::length<address, HiveBuzz<T0>>(&v8.buzzes))
        } else {
            (0, 0, 0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), 0, 0)
        }
    }

    public fun get_streamer_buzzes_params<T0>(arg0: &HiveVault) : (bool, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        (v0.are_live, v0.cur_auction_stream, v0.stream_init_ms, v0.config.first_rank_assets_limit, v0.config.second_rank_assets_limit, v0.config.third_rank_assets_limit, v0.config.max_streams_per_slot, v0.config.choosen_buzzes_count, v0.engagement_scores.hive_per_ad_slot, v0.engagement_scores.bees_per_ad_slot, v0.config.min_bid_limit, v0.config.tax_on_bid)
    }

    public fun get_streamer_info<T0>(arg0: &HiveVault, arg1: u64) : (0x1::option::Option<address>, 0x1::option::Option<0x1::string::String>, u64, u8, u64, u64, u64, u128, 0x1::string::String) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        if (arg1 == 0) {
            (v0.streamers_info.rank1_profile, v0.streamers_info.rank1_info.streamer_name, v0.streamers_info.rank1_info.streams_count, v0.streamers_info.rank1_info.access_type, v0.streamers_info.rank1_info.sui_per_buzz, v0.streamers_info.rank1_info.buzz_cost_in_hive, v0.streamers_info.rank1_info.remaining_buzzes_count, v0.streamers_info.rank1_info.engagement_points, v0.streamers_info.rank1_info.collection_name)
        } else if (arg1 == 1) {
            (v0.streamers_info.rank2_profile, v0.streamers_info.rank2_info.streamer_name, v0.streamers_info.rank2_info.streams_count, v0.streamers_info.rank2_info.access_type, v0.streamers_info.rank2_info.sui_per_buzz, v0.streamers_info.rank2_info.buzz_cost_in_hive, v0.streamers_info.rank2_info.remaining_buzzes_count, v0.streamers_info.rank2_info.engagement_points, v0.streamers_info.rank2_info.collection_name)
        } else if (arg1 == 2) {
            (v0.streamers_info.rank3_profile, v0.streamers_info.rank3_info.streamer_name, v0.streamers_info.rank3_info.streams_count, v0.streamers_info.rank3_info.access_type, v0.streamers_info.rank3_info.sui_per_buzz, v0.streamers_info.rank3_info.buzz_cost_in_hive, v0.streamers_info.rank3_info.remaining_buzzes_count, v0.streamers_info.rank3_info.engagement_points, v0.streamers_info.rank3_info.collection_name)
        } else {
            (0x1::option::none<address>(), 0x1::option::none<0x1::string::String>(), 0, 0, 0, 0, 0, 0, 0x1::string::utf8(b""))
        }
    }

    public fun get_streamer_pol_info<T0>(arg0: &HiveVault) : (u64, u64) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        (0x2::balance::value<T0>(&v0.bid_pool), 0x2::balance::value<T0>(&v0.sui_avail_for_pol))
    }

    public fun has_user_liked<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : bool {
        0x2::linked_table::contains<address, bool>(&0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store())).streamer_buzzes, arg2), arg3).likes, arg1)
    }

    public entry fun increment_stream_part_1<T0>(arg0: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg1: &mut HiveVault, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg3: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg4: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg2);
        let (v4, _, _, _) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg3);
        let (v8, _, _, _) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg4);
        let v12 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg5);
        if (!v12.are_live || 0x2::tx_context::epoch(arg5) < v12.cur_auction_stream + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::stream_duration_epoches()) {
            return
        };
        assert!(!v12.is_incrementing, 9889);
        v12.is_incrementing = true;
        let v13 = v12.cur_auction_stream;
        0x2::balance::join<T0>(&mut v12.sui_avail_for_pol, 0x2::balance::withdraw_all<T0>(&mut v12.sui_for_stream));
        let v14 = v12.streamers_info.rank1_info.engagement_points;
        let v15 = v12.streamers_info.rank2_info.engagement_points;
        let v16 = v12.streamers_info.rank3_info.engagement_points;
        if (v14 >= v15 && v14 >= v16) {
            onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank1_profile, v0, arg2, v12.config.first_rank_assets_limit, v12.streamers_info.rank1_info.collection_name, v13, arg5);
            if (v15 >= v16) {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank2_profile, v4, arg3, v12.config.second_rank_assets_limit, v12.streamers_info.rank2_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank3_profile, v8, arg4, v12.config.third_rank_assets_limit, v12.streamers_info.rank3_info.collection_name, v13, arg5);
            } else {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank3_profile, v8, arg4, v12.config.second_rank_assets_limit, v12.streamers_info.rank3_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank2_profile, v4, arg3, v12.config.third_rank_assets_limit, v12.streamers_info.rank2_info.collection_name, v13, arg5);
            };
        } else if (v15 >= v14 && v15 >= v16) {
            onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank2_profile, v4, arg3, v12.config.first_rank_assets_limit, v12.streamers_info.rank2_info.collection_name, v13, arg5);
            if (v14 >= v16) {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank1_profile, v0, arg2, v12.config.second_rank_assets_limit, v12.streamers_info.rank1_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank3_profile, v8, arg4, v12.config.third_rank_assets_limit, v12.streamers_info.rank3_info.collection_name, v13, arg5);
            } else {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank3_profile, v8, arg4, v12.config.second_rank_assets_limit, v12.streamers_info.rank3_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank1_profile, v0, arg2, v12.config.third_rank_assets_limit, v12.streamers_info.rank1_info.collection_name, v13, arg5);
            };
        } else {
            onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank3_profile, v8, arg4, v12.config.first_rank_assets_limit, v12.streamers_info.rank3_info.collection_name, v13, arg5);
            if (v14 >= v15) {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank1_profile, v0, arg2, v12.config.second_rank_assets_limit, v12.streamers_info.rank1_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank2_profile, v4, arg3, v12.config.third_rank_assets_limit, v12.streamers_info.rank2_info.collection_name, v13, arg5);
            } else {
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank2_profile, v4, arg3, v12.config.second_rank_assets_limit, v12.streamers_info.rank2_info.collection_name, v13, arg5);
                onboard_streamer_as_creator(&arg1.gems_kraft_cap, arg0, v12.streamers_info.rank1_profile, v0, arg2, v12.config.third_rank_assets_limit, v12.streamers_info.rank1_info.collection_name, v13, arg5);
            };
        };
    }

    public entry fun increment_stream_part_2<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &mut HiveVault, arg3: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg4: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg5: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg6: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg7: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::sui_for_stream_pct();
        let (v3, v4, _, v6) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg3);
        let (v7, v8, _, v10) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg4);
        let (v11, v12, _, v14) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg5);
        let v15 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg8);
        if (!v15.are_live || v0 < v15.cur_auction_stream + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::stream_duration_epoches()) {
            return
        };
        assert!(v15.is_incrementing, 9890);
        v15.is_incrementing = false;
        let v16 = v15.cur_auction_stream;
        v15.cur_auction_stream = v0;
        v15.stream_init_ms = v1;
        if (v15.leading_bids.o_bid_amt > 0 || v15.leading_bids.s_bid_amt > 0 || v15.leading_bids.t_bid_amt > 0) {
            let v17 = v15.leading_bids.o_bid_amt + v15.leading_bids.s_bid_amt + v15.leading_bids.t_bid_amt;
            let v18 = 0x2::balance::split<T0>(&mut v15.bid_pool, v17);
            0x2::balance::join<T0>(&mut v15.sui_for_stream, 0x2::balance::split<T0>(&mut v18, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(v17, v2, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::percent_precision())));
            0x2::balance::join<T0>(&mut v15.sui_avail_for_pol, v18);
            let v19 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v15.config.winning_bid_points as u256), (1000000000 as u256), (v17 as u256));
            let v20 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256(v19, (v15.engagement_scores.total_sui_bidded as u256), (1000000000 as u256)) as u128);
            let v21 = v15.engagement_scores.ongoing_points_sum + v20;
            if (v15.engagement_scores.hive_per_ad_slot > 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&v15.engagement_scores.hive_gems_available)) {
                v15.engagement_scores.hive_per_ad_slot = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&v15.engagement_scores.hive_gems_available);
            };
            if (v15.engagement_scores.bees_per_ad_slot > 0x2::balance::value<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&v15.engagement_scores.bees_available)) {
                v15.engagement_scores.bees_per_ad_slot = 0x2::balance::value<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&v15.engagement_scores.bees_available);
            };
            let v22 = 0;
            let v23 = 0;
            let v24 = 0;
            let v25 = 0;
            let v26 = 0;
            let v27 = 0;
            let v28 = v15.config.choosen_buzzes_count;
            let v29 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::percent_precision();
            if (0x1::option::is_some<address>(&v15.leading_bids.o_profile_addr)) {
                assert!(v3 == *0x1::option::borrow<address>(&v15.leading_bids.o_profile_addr), 9881);
                let v30 = 0x2::linked_table::borrow<address, ProfileScore>(&v15.engagement_scores.user_points_score, v3);
                let v31 = &mut v15.streamers_info.rank1_info;
                update_streamer_info(v31, v4, 0, v30.access_type, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(v15.leading_bids.o_bid_amt, v2, v29) / v15.config.choosen_buzzes_count, v30.buzz_cost_in_hive, v28, 0, v30.collection_name);
                v15.streamers_info.rank1_profile = 0x1::option::some<address>(v3);
                let (v32, v33) = calculate_winner_rewards<T0>(v15, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(1));
                v23 = v33;
                v22 = v32;
                0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg3, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(&mut v15.engagement_scores.hive_gems_available, v32));
                0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::transfer_bees_balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(arg7, arg6, 0x2::balance::split<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&mut v15.engagement_scores.bees_available, v33), v6, arg8);
                let v34 = NewStreamerForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 1,
                    profile_addr       : v3,
                    username           : v4,
                    user_address       : v6,
                    access_type        : v30.access_type,
                    buzz_cost_in_hive  : v30.buzz_cost_in_hive,
                    collection_name    : v30.collection_name,
                    hive_rewards       : v32,
                    bee_rewards        : v33,
                };
                0x2::event::emit<NewStreamerForStream>(v34);
                update_user_points<T0>(v15, arg1, arg3, arg6, arg7, v3, v4, v6, 0, false, v1, 0, 0, 0, 0x1::string::utf8(b""), true, arg8);
            } else {
                let v35 = StreamerNotFoundForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 1,
                };
                0x2::event::emit<StreamerNotFoundForStream>(v35);
            };
            if (0x1::option::is_some<address>(&v15.leading_bids.s_profile_addr)) {
                assert!(v7 == *0x1::option::borrow<address>(&v15.leading_bids.s_profile_addr), 9881);
                let v36 = 0x2::linked_table::borrow<address, ProfileScore>(&v15.engagement_scores.user_points_score, v7);
                let v37 = &mut v15.streamers_info.rank2_info;
                update_streamer_info(v37, v8, 0, v36.access_type, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(v15.leading_bids.s_bid_amt, v2, v29) / v15.config.choosen_buzzes_count, v36.buzz_cost_in_hive, v28, 0, v36.collection_name);
                v15.streamers_info.rank2_profile = 0x1::option::some<address>(v7);
                let (v38, v39) = calculate_winner_rewards<T0>(v15, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(2));
                v25 = v39;
                v24 = v38;
                0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg4, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(&mut v15.engagement_scores.hive_gems_available, v38));
                0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::transfer_bees_balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(arg7, arg6, 0x2::balance::split<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&mut v15.engagement_scores.bees_available, v39), v10, arg8);
                let v40 = NewStreamerForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 2,
                    profile_addr       : v7,
                    username           : v8,
                    user_address       : v10,
                    access_type        : v36.access_type,
                    buzz_cost_in_hive  : v36.buzz_cost_in_hive,
                    collection_name    : v36.collection_name,
                    hive_rewards       : v38,
                    bee_rewards        : v39,
                };
                0x2::event::emit<NewStreamerForStream>(v40);
                update_user_points<T0>(v15, arg1, arg4, arg6, arg7, v7, v8, v10, 0, false, v1, 0, 0, 0, 0x1::string::utf8(b""), true, arg8);
            } else {
                let v41 = StreamerNotFoundForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 2,
                };
                0x2::event::emit<StreamerNotFoundForStream>(v41);
            };
            if (0x1::option::is_some<address>(&v15.leading_bids.t_profile_addr)) {
                assert!(v11 == *0x1::option::borrow<address>(&v15.leading_bids.t_profile_addr), 9881);
                let v42 = 0x2::linked_table::borrow<address, ProfileScore>(&v15.engagement_scores.user_points_score, v11);
                let v43 = &mut v15.streamers_info.rank3_info;
                update_streamer_info(v43, v12, 0, v42.access_type, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div(v15.leading_bids.t_bid_amt, v2, v29) / v15.config.choosen_buzzes_count, v42.buzz_cost_in_hive, v28, 0, v42.collection_name);
                v15.streamers_info.rank3_profile = 0x1::option::some<address>(v11);
                let (v44, v45) = calculate_winner_rewards<T0>(v15, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::rank_rewards_pct(3));
                v27 = v45;
                v26 = v44;
                0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg5, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(&mut v15.engagement_scores.hive_gems_available, v44));
                0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::transfer_bees_balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(arg7, arg6, 0x2::balance::split<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&mut v15.engagement_scores.bees_available, v45), v14, arg8);
                let v46 = NewStreamerForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 3,
                    profile_addr       : v11,
                    username           : v12,
                    user_address       : v14,
                    access_type        : v42.access_type,
                    buzz_cost_in_hive  : v42.buzz_cost_in_hive,
                    collection_name    : v42.collection_name,
                    hive_rewards       : v44,
                    bee_rewards        : v45,
                };
                0x2::event::emit<NewStreamerForStream>(v46);
                update_user_points<T0>(v15, arg1, arg5, arg6, arg7, v11, v12, v14, 0, false, v1, 0, 0, 0, 0x1::string::utf8(b""), true, arg8);
            } else {
                let v47 = StreamerNotFoundForStream{
                    cur_auction_stream : v15.cur_auction_stream,
                    rank               : 3,
                };
                0x2::event::emit<StreamerNotFoundForStream>(v47);
            };
            let v48 = v15.engagement_scores.hive_per_ad_slot - v22 - v24 - v26;
            let v49 = v15.engagement_scores.bees_per_ad_slot - v23 - v25 - v27;
            let v50 = HistoricalRecord{
                hive_for_participants : v48,
                bees_for_participants : v49,
                total_points_sum      : v21,
                points_per_sui_bidded : v19,
            };
            0x2::linked_table::push_back<u64, HistoricalRecord>(&mut v15.engagement_scores.historical_records, v16, v50);
            let v51 = NewStreamInitiated{
                stream_init_ms        : v15.stream_init_ms,
                streaming_from_epoch  : v15.cur_auction_stream,
                hive_for_participants : v48,
                bees_for_participants : v49,
                points_per_sui_bidded : v19,
                total_points_sum      : v21,
                points_for_all_bids   : v20,
                sui_for_pol_from_bid  : 0x2::balance::value<T0>(&v18),
            };
            0x2::event::emit<NewStreamInitiated>(v51);
        } else {
            let v52 = HistoricalRecord{
                hive_for_participants : v15.engagement_scores.hive_per_ad_slot,
                bees_for_participants : v15.engagement_scores.bees_per_ad_slot,
                total_points_sum      : v15.engagement_scores.ongoing_points_sum,
                points_per_sui_bidded : 0,
            };
            0x2::linked_table::push_back<u64, HistoricalRecord>(&mut v15.engagement_scores.historical_records, v16, v52);
            v15.streamers_info.rank1_profile = 0x1::option::none<address>();
            let v53 = &mut v15.streamers_info.rank1_info;
            reset_streamer_info(v53);
            v15.streamers_info.rank2_profile = 0x1::option::none<address>();
            let v54 = &mut v15.streamers_info.rank2_info;
            reset_streamer_info(v54);
            v15.streamers_info.rank3_profile = 0x1::option::none<address>();
            let v55 = &mut v15.streamers_info.rank3_info;
            reset_streamer_info(v55);
            let v56 = StreamerNotFoundForStream{
                cur_auction_stream : v15.cur_auction_stream,
                rank               : 1,
            };
            0x2::event::emit<StreamerNotFoundForStream>(v56);
            let v57 = StreamerNotFoundForStream{
                cur_auction_stream : v15.cur_auction_stream,
                rank               : 2,
            };
            0x2::event::emit<StreamerNotFoundForStream>(v57);
            let v58 = StreamerNotFoundForStream{
                cur_auction_stream : v15.cur_auction_stream,
                rank               : 3,
            };
            0x2::event::emit<StreamerNotFoundForStream>(v58);
            let v59 = NewStreamerNotFound{
                stream_init_ms       : v1,
                streaming_from_epoch : v15.cur_auction_stream,
            };
            0x2::event::emit<NewStreamerNotFound>(v59);
        };
        v15.engagement_scores.total_sui_bidded = 0;
        v15.leading_bids.o_profile_addr = 0x1::option::none<address>();
        v15.leading_bids.o_bid_amt = 0;
        v15.leading_bids.s_profile_addr = 0x1::option::none<address>();
        v15.leading_bids.s_bid_amt = 0;
        v15.leading_bids.t_profile_addr = 0x1::option::none<address>();
        v15.leading_bids.t_bid_amt = 0;
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HIVE", b"HIVE GEMS are the social currency and governance token for DegenHive's programmable-identity (HiveProfile) driven open-hive. HIVE is krafted on a 1:1 basis against HIVE GEMS and enables users to trade it on DegenHive DEX and compose with other protocols on-top of SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/hive_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_hive_vault<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x1dc0877296495b5cdc43ce9ff1ac5fb4618bf23cf3ed447363aa9f5e0df7fdb9::dsui_vault::DSuiVault, arg3: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg4: 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGemKraftCap, arg5: 0x2::coin::TreasuryCap<HIVE>, arg6: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg7: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::DSuiDisperser<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::dsui::DSUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::add_time_stream_app(&mut arg4, arg3, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()), true, true, true, arg11);
        let v1 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::kraft_hive_gems(&mut arg4, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::total_hive_gems_supply());
        let (v2, v3) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::kraft_owned_hive_profile(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        let v4 = v2;
        let v5 = StreamerInfo{
            streamer_name          : 0x1::option::none<0x1::string::String>(),
            streams_count          : 0,
            access_type            : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::worker_bee_plan(),
            sui_per_buzz           : 0,
            buzz_cost_in_hive      : 0,
            remaining_buzzes_count : 0,
            engagement_points      : 0,
            collection_name        : 0x1::string::utf8(b""),
        };
        let v6 = StreamerConfig{
            max_streams_per_slot     : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::init_streams_per_slot(),
            choosen_buzzes_count     : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::init_buzzes_per_stream(),
            winning_bid_points       : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::init_winning_bid_points(),
            first_rank_assets_limit  : 0,
            second_rank_assets_limit : 0,
            third_rank_assets_limit  : 0,
            max_streams_to_store     : 1000,
            min_bid_limit            : 1000000000,
            tax_on_bid               : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::init_tax_allowed(),
        };
        let v7 = CurrentStreamersInfo{
            rank1_profile : 0x1::option::none<address>(),
            rank1_info    : v5,
            rank2_profile : 0x1::option::none<address>(),
            rank2_info    : v5,
            rank3_profile : 0x1::option::none<address>(),
            rank3_info    : v5,
        };
        let v8 = EngagementScores{
            hive_gems_available   : 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(&mut v1, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::hive_gems_for_ad_incentives()),
            hive_per_ad_slot      : 0,
            bees_available        : 0x2::balance::zero<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(),
            bees_per_ad_slot      : 0,
            ongoing_points_sum    : 0,
            user_points_score     : 0x2::linked_table::new<address, ProfileScore>(arg11),
            total_sui_bidded      : 0,
            leading_bid_amt       : 0,
            points_per_sui_bidded : 0,
            historical_records    : 0x2::linked_table::new<u64, HistoricalRecord>(arg11),
        };
        let v9 = LeadingBidsInfo{
            o_profile_addr : 0x1::option::none<address>(),
            o_bid_amt      : 0,
            s_profile_addr : 0x1::option::none<address>(),
            s_bid_amt      : 0,
            t_profile_addr : 0x1::option::none<address>(),
            t_bid_amt      : 0,
        };
        let v10 = StreamerBuzzes<T0>{
            id                 : 0x2::object::new(arg11),
            are_live           : false,
            config             : v6,
            cur_auction_stream : 0,
            stream_init_ms     : 0,
            streamer_buzzes    : 0x2::linked_table::new<u64, vector<StreamBuzz<T0>>>(arg11),
            streamers_info     : v7,
            sui_for_stream     : 0x2::balance::zero<T0>(),
            engagement_scores  : v8,
            bid_pool           : 0x2::balance::zero<T0>(),
            leading_bids       : v9,
            sui_avail_for_pol  : 0x2::balance::zero<T0>(),
            is_incrementing    : false,
        };
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::add_app_to_profile<StreamerBuzzes<T0>>(&v0, &mut v4, v10, arg11);
        let v11 = HiveVault{
            id               : 0x2::object::new(arg11),
            streamer_profile : v4,
            gems_kraft_cap   : arg4,
            hive_kraft_cap   : arg5,
            stream_buzz_cap  : v0,
            active_supply    : 0,
        };
        let v12 = &mut v11;
        let v13 = &mut v1;
        0x2::transfer::share_object<HiveVault>(v11);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::destroy_zero(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIVE>>(0x2::coin::from_balance<HIVE>(deposit_gems_for_hive_and_return(v12, v13, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&v1), arg11), arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg11), 0x2::tx_context::sender(arg11));
    }

    public entry fun interact_with_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg3: &mut HiveVault, arg4: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg6: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveDisperser, arg7: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg8: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let (v1, v2) = authority_check(arg7, v0);
        let (v3, _, _, _) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(arg8);
        buzz_check(arg11, arg12);
        let v7 = false;
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::consume_entropy_of_profile(arg0, &arg3.stream_buzz_cap, arg2, arg7, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::comment_engagement_cost(), arg13);
        let v8 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg3.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store()));
        let (v9, _, v11) = is_valid_streamer<T0>(v3, v8);
        assert!(v9, 9871);
        let (_, _, v14, _, v16, _, _) = get_rank_info<T0>(v11, v8);
        let v19 = 0;
        if (v16 > 0) {
            let v20 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::withdraw_gems_from_profile(arg0, arg2, arg7, v16, arg13);
            v19 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&v20);
            0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg8, v20);
            v7 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::join_hive_of_profile_via_stream(&arg3.gems_kraft_cap, arg0, arg2, arg7, arg8, arg6, v14, 0, arg13);
        } else {
            0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::make_forever_subscriber_via_stream(&arg3.gems_kraft_cap, v8.stream_init_ms, arg7, &mut arg3.streamer_profile);
        };
        let v21 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg3.stream_buzz_cap, &mut arg3.streamer_profile, arg13);
        let v22 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v21.streamer_buzzes, arg9), arg10);
        assert!(v3 == v22.streamer, 9883);
        let v23 = HiveBuzzForAStreamBuzzKrafted{
            streamer_profile          : v3,
            stream_index              : arg9,
            stream_inner_index        : arg10,
            user_profile              : v1,
            username                  : v2,
            user_buzz                 : arg11,
            gen_ai_url                : arg12,
            hive_streamed_to_streamer : v19,
        };
        0x2::event::emit<HiveBuzzForAStreamBuzzKrafted>(v23);
        let v24 = if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v22.buzzes, v1)) {
            let v24 = 0x2::linked_table::remove<address, HiveBuzz<T0>>(&mut v22.buzzes, v1);
            assert!(!v24.is_choosen, 9868);
            v24.buzz = arg11;
            v24.gen_ai_url = arg12;
            v24
        } else {
            HiveBuzz<T0>{buzz: arg11, gen_ai_url: arg12, sui_earned: 0x2::balance::zero<T0>(), is_choosen: false, upvotes: 0x2::linked_table::new<address, bool>(arg13)}
        };
        0x2::linked_table::push_back<address, HiveBuzz<T0>>(&mut v22.buzzes, v1, v24);
        let v25 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::comment_points();
        if (v7) {
            v25 = 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::subscriber_points();
        };
        update_user_points<T0>(v21, arg1, arg7, arg4, arg5, v1, v2, v0, v25, false, 0, 0, 0, 0, 0x1::string::utf8(b""), false, arg13);
    }

    public entry fun interact_with_stream_buzz_no_url<T0>(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg3: &mut HiveVault, arg4: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg6: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveDisperser, arg7: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg8: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        interact_with_stream_buzz<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x1::option::none<0x1::string::String>(), arg12);
    }

    fun internal_add_to_stream_buzz<T0>(arg0: &mut StreamerBuzzes<T0>, arg1: address, arg2: u64, arg3: bool, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamBuzz<T0>{
            streamer   : arg1,
            timestamp  : arg4,
            buzz       : arg6,
            gen_ai_url : arg7,
            likes      : 0x2::linked_table::new<address, bool>(arg8),
            buzzes     : 0x2::linked_table::new<address, HiveBuzz<T0>>(arg8),
        };
        let v1 = 0x2::linked_table::length<u64, vector<StreamBuzz<T0>>>(&arg0.streamer_buzzes);
        let v2 = 0;
        if (arg3) {
            let v3 = 0x1::vector::empty<StreamBuzz<T0>>();
            0x1::vector::push_back<StreamBuzz<T0>>(&mut v3, v0);
            0x2::linked_table::push_back<u64, vector<StreamBuzz<T0>>>(&mut arg0.streamer_buzzes, v1, v3);
            arg2 = v1;
        } else {
            let v4 = 0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut arg0.streamer_buzzes, arg2);
            assert!(arg1 == 0x1::vector::borrow<StreamBuzz<T0>>(v4, 0).streamer, 9883);
            v2 = 0x1::vector::length<StreamBuzz<T0>>(v4);
            0x1::vector::push_back<StreamBuzz<T0>>(v4, v0);
            assert!(0x1::vector::length<StreamBuzz<T0>>(v4) <= 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::max_stream_thread_length(), 9866);
        };
        let v5 = NewStreamBuzzKrafted{
            cur_auction_stream    : arg0.cur_auction_stream,
            streamer_profile_addr : arg1,
            streamer_name         : arg5,
            buzz                  : arg6,
            gen_ai_url            : arg7,
            stream_index          : arg2,
            index                 : v2,
        };
        0x2::event::emit<NewStreamBuzzKrafted>(v5);
    }

    fun is_valid_streamer<T0>(arg0: address, arg1: &StreamerBuzzes<T0>) : (bool, u64, u64) {
        let v0 = false;
        let v1 = 0;
        let v2 = 0;
        if (0x1::option::is_some<address>(&arg1.streamers_info.rank1_profile) && arg0 == *0x1::option::borrow<address>(&arg1.streamers_info.rank1_profile)) {
            v0 = true;
            v2 = 1;
            v1 = arg1.streamers_info.rank1_info.streams_count;
        } else if (0x1::option::is_some<address>(&arg1.streamers_info.rank2_profile) && arg0 == *0x1::option::borrow<address>(&arg1.streamers_info.rank2_profile)) {
            v0 = true;
            v2 = 2;
            v1 = arg1.streamers_info.rank2_info.streams_count;
        } else if (0x1::option::is_some<address>(&arg1.streamers_info.rank3_profile) && arg0 == *0x1::option::borrow<address>(&arg1.streamers_info.rank3_profile)) {
            v0 = true;
            v2 = 3;
            v1 = arg1.streamers_info.rank3_info.streams_count;
        };
        (v0, v1, v2)
    }

    fun kraft_hive(arg0: &mut HiveVault, arg1: 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGems, arg2: u64, arg3: address) : 0x2::balance::Balance<HIVE> {
        assert!(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::value(&arg1) == arg2, 9876);
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(&mut arg0.streamer_profile, arg1);
        if (arg2 > 0) {
            let v0 = KraftHive{
                user         : arg3,
                hive_krafted : arg2,
            };
            0x2::event::emit<KraftHive>(v0);
        };
        arg0.active_supply = arg0.active_supply + arg2;
        0x2::coin::mint_balance<HIVE>(&mut arg0.hive_kraft_cap, arg2)
    }

    public fun like_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg3: &mut HiveVault, arg4: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg6: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2) = authority_check(arg6, v0);
        let v3 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg3.stream_buzz_cap, &mut arg3.streamer_profile, arg9);
        let v4 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, arg7), arg8);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v1), 9872);
        let v5 = false;
        let v6 = 0;
        let v7 = v4.streamer;
        if (0x1::option::is_some<address>(&v3.streamers_info.rank1_profile) && v7 == *0x1::option::borrow<address>(&v3.streamers_info.rank1_profile)) {
            v5 = true;
            v3.streamers_info.rank1_info.engagement_points = v3.streamers_info.rank1_info.engagement_points + 1;
            v6 = v3.streamers_info.rank1_info.engagement_points;
        } else if (0x1::option::is_some<address>(&v3.streamers_info.rank2_profile) && v7 == *0x1::option::borrow<address>(&v3.streamers_info.rank2_profile)) {
            v5 = true;
            v3.streamers_info.rank2_info.engagement_points = v3.streamers_info.rank2_info.engagement_points + 1;
            v6 = v3.streamers_info.rank2_info.engagement_points;
        } else if (0x1::option::is_some<address>(&v3.streamers_info.rank3_profile) && v7 == *0x1::option::borrow<address>(&v3.streamers_info.rank3_profile)) {
            v5 = true;
            v3.streamers_info.rank3_info.engagement_points = v3.streamers_info.rank3_info.engagement_points + 1;
            v6 = v3.streamers_info.rank3_info.engagement_points;
        };
        assert!(v5, 9871);
        let v8 = UserLikedStreamBuzz{
            user_profile_addr  : v1,
            username           : v2,
            stream_index       : arg7,
            stream_inner_index : arg8,
            streamer_profile   : v7,
            engagement_points  : v6,
        };
        0x2::event::emit<UserLikedStreamBuzz>(v8);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v1, true);
        update_user_points<T0>(v3, arg1, arg6, arg4, arg5, v1, v2, v0, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::like_points(), false, 0, 0, 0, 0, 0x1::string::utf8(b""), false, arg9);
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::consume_entropy_of_profile(arg0, &arg3.stream_buzz_cap, arg2, arg6, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::like_engagement_cost(), arg9);
    }

    public entry fun make_hive_launch_stream<T0>(arg0: &0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut HiveVault, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _) = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::get_profile_meta_info(&arg2.streamer_profile);
        let v4 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg5);
        internal_add_to_stream_buzz<T0>(v4, @0x0, 0, true, 0x2::clock::timestamp_ms(arg1), v1, arg3, arg4, arg5);
    }

    fun make_new_user_points(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : ProfileScore {
        ProfileScore{
            stream_epoch      : arg0,
            points            : arg1,
            sui_bidded        : arg2,
            flag              : false,
            buzz_cost_in_hive : arg3,
            access_type       : arg4,
            collection_name   : 0x1::string::utf8(b""),
        }
    }

    fun max_addable_to_bid(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (bool, u64) {
        if (arg2 < arg0 + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::unlimited_deposit_window()) {
            return (false, arg4)
        };
        if (arg5 == 0) {
            return (false, 0)
        };
        (true, (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((arg5 as u256), ((arg1 + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::stream_duration_epoches() * 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::epoch_duration_ms() - arg3) as u256), ((0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::limited_deposit_window() * 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::epoch_duration_ms()) as u256)) as u64))
    }

    fun onboard_streamer_as_creator(arg0: &0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::HiveGemKraftCap, arg1: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: 0x1::option::Option<address>, arg3: address, arg4: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg2)) {
            assert!(arg3 == *0x1::option::borrow<address>(&arg2), 9881);
            0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::onboard_profile_as_creator(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        };
    }

    public fun query_across_buzzes_for_stream<T0>(arg0: &HiveVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store())).streamer_buzzes, arg1), arg2);
        let v6 = if (0x1::option::is_some<address>(&arg3)) {
            arg3
        } else {
            *0x2::linked_table::front<address, bool>(&v5.likes)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<address>(&v7) && v8 < arg4) {
            let v9 = *0x1::option::borrow<address>(&v7);
            let v10 = 0x2::linked_table::borrow<address, HiveBuzz<T0>>(&v5.buzzes, v9);
            let v11 = 0x1::string::utf8(b"");
            if (0x1::option::is_some<0x1::string::String>(&v5.gen_ai_url)) {
                v11 = *0x1::option::borrow<0x1::string::String>(&v5.gen_ai_url);
            };
            0x1::vector::push_back<address>(&mut v0, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v10.buzz);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v11);
            0x1::vector::push_back<bool>(&mut v3, v10.is_choosen);
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<T0>(&v10.sui_earned));
            v7 = *0x2::linked_table::next<address, bool>(&v5.likes, v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, 0x2::linked_table::length<address, HiveBuzz<T0>>(&v5.buzzes))
    }

    public fun query_across_likes<T0>(arg0: &HiveVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store())).streamer_buzzes, arg1), arg2);
        let v2 = if (0x1::option::is_some<address>(&arg3)) {
            arg3
        } else {
            *0x2::linked_table::front<address, bool>(&v1.likes)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg4) {
            let v5 = *0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, v5);
            v3 = *0x2::linked_table::next<address, bool>(&v1.likes, v5);
            v4 = v4 + 1;
        };
        (v0, 0x2::linked_table::length<address, bool>(&v1.likes))
    }

    public fun query_across_streams_for_index<T0>(arg0: &HiveVault, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<u64>, vector<0x1::string::String>, vector<0x1::string::String>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::streamer_buzzes_store())).streamer_buzzes, arg1);
        let v6 = 0x1::vector::length<StreamBuzz<T0>>(v5);
        let v7 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0
        };
        let v8 = v7;
        let v9 = 0;
        while (v8 < v6 && v9 < arg3) {
            let v10 = 0x1::vector::borrow<StreamBuzz<T0>>(v5, v8);
            let v11 = 0x1::string::utf8(b"");
            if (0x1::option::is_some<0x1::string::String>(&v10.gen_ai_url)) {
                v11 = *0x1::option::borrow<0x1::string::String>(&v10.gen_ai_url);
            };
            0x1::vector::push_back<u64>(&mut v0, v10.timestamp);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v10.buzz);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v11);
            0x1::vector::push_back<u64>(&mut v3, 0x2::linked_table::length<address, bool>(&v10.likes));
            0x1::vector::push_back<u64>(&mut v4, 0x2::linked_table::length<address, HiveBuzz<T0>>(&v10.buzzes));
            v8 = v8 + 1;
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v6)
    }

    fun reset_streamer_info(arg0: &mut StreamerInfo) {
        arg0.streamer_name = 0x1::option::none<0x1::string::String>();
        arg0.streams_count = 0;
        arg0.access_type = 0;
        arg0.sui_per_buzz = 0;
        arg0.buzz_cost_in_hive = 0;
        arg0.remaining_buzzes_count = 0;
        arg0.engagement_points = 0;
        arg0.collection_name = 0x1::string::utf8(b"");
    }

    public entry fun retrieve_sui_from_buzz<T0>(arg0: &mut HiveVault, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg4).streamer_buzzes, arg2), arg3).buzzes, v0);
        assert!(v2.is_choosen, 9861);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v2.sui_earned), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun transfer_hive_treasury_funds(arg0: &0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::config::HiveDaoCapability, arg1: &mut HiveVault, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::transfer_hive_treasury_funds(arg0, arg2, arg3);
        let v1 = &mut v0;
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::destroy_zero(v0);
        0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<HIVE>(deposit_gems_for_hive_and_return(arg1, v1, arg3, arg5), arg4, arg5);
    }

    public fun transfer_pol<T0>(arg0: &0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::config::TwoAmmFeeClaimCapability, arg1: &mut HiveVault, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg2).sui_avail_for_pol)
    }

    fun update_leading_bids<T0>(arg0: address, arg1: u64, arg2: &mut StreamerBuzzes<T0>) {
        if (arg1 < arg2.leading_bids.t_bid_amt) {
            return
        };
        if (arg1 > arg2.leading_bids.o_bid_amt) {
            if (0x1::option::is_some<address>(&arg2.leading_bids.o_profile_addr) && arg0 == *0x1::option::borrow<address>(&arg2.leading_bids.o_profile_addr)) {
                arg2.leading_bids.o_bid_amt = arg1;
                return
            };
            if (0x1::option::is_some<address>(&arg2.leading_bids.s_profile_addr) && arg0 == *0x1::option::borrow<address>(&arg2.leading_bids.s_profile_addr)) {
                arg2.leading_bids.s_profile_addr = arg2.leading_bids.o_profile_addr;
                arg2.leading_bids.s_bid_amt = arg2.leading_bids.o_bid_amt;
            } else {
                arg2.leading_bids.t_profile_addr = arg2.leading_bids.s_profile_addr;
                arg2.leading_bids.t_bid_amt = arg2.leading_bids.s_bid_amt;
                arg2.leading_bids.s_profile_addr = arg2.leading_bids.o_profile_addr;
                arg2.leading_bids.s_bid_amt = arg2.leading_bids.o_bid_amt;
            };
            arg2.leading_bids.o_profile_addr = 0x1::option::some<address>(arg0);
            arg2.leading_bids.o_bid_amt = arg1;
        } else if (arg1 > arg2.leading_bids.s_bid_amt) {
            arg2.leading_bids.t_profile_addr = arg2.leading_bids.s_profile_addr;
            arg2.leading_bids.t_bid_amt = arg2.leading_bids.s_bid_amt;
            arg2.leading_bids.s_profile_addr = 0x1::option::some<address>(arg0);
            arg2.leading_bids.s_bid_amt = arg1;
        } else {
            arg2.leading_bids.t_profile_addr = 0x1::option::some<address>(arg0);
            arg2.leading_bids.t_bid_amt = arg1;
        };
        let v0 = LeadingBidsUpdated{
            rank1_profile : arg2.leading_bids.o_profile_addr,
            rank1_bid_amt : arg2.leading_bids.o_bid_amt,
            rank2_profile : arg2.leading_bids.s_profile_addr,
            rank2_bid_amt : arg2.leading_bids.s_bid_amt,
            rank3_profile : arg2.leading_bids.t_profile_addr,
            rank3_bid_amt : arg2.leading_bids.t_bid_amt,
        };
        0x2::event::emit<LeadingBidsUpdated>(v0);
    }

    public fun update_streamer_buzzes<T0>(arg0: &0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::config::HiveDaoCapability, arg1: &mut HiveVault, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::tx_context::TxContext) {
        let v0 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg13);
        v0.are_live = arg2;
        if (!v0.are_live && arg2) {
            v0.cur_auction_stream = 0x2::tx_context::epoch(arg13);
        };
        if (arg7 > 0) {
            v0.engagement_scores.hive_per_ad_slot = arg7;
        };
        if (arg6 > 0) {
            v0.config.winning_bid_points = arg6;
        };
        if (arg8 > 0) {
            v0.engagement_scores.bees_per_ad_slot = arg8;
        };
        if (arg4 > 0) {
            assert!(1 < arg4 && arg4 < 15, 9875);
            v0.config.tax_on_bid = arg4;
        };
        if (arg3 > 0) {
            assert!(arg3 <= 420, 9869);
            assert!(arg3 > 1, 9870);
            v0.config.choosen_buzzes_count = arg3;
        };
        if (arg5 > 0) {
            assert!(arg5 > 5, 9873);
            assert!(arg5 < 150, 9874);
            v0.config.max_streams_per_slot = arg5;
        };
        if (arg9 > 0) {
            assert!(arg9 < 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::max_first_rank_limit(), 9887);
            v0.config.first_rank_assets_limit = arg9;
        };
        if (arg10 > 0) {
            assert!(arg10 < v0.config.first_rank_assets_limit, 9887);
            v0.config.second_rank_assets_limit = arg10;
        };
        if (arg11 > 0) {
            assert!(arg11 < v0.config.second_rank_assets_limit, 9887);
            v0.config.third_rank_assets_limit = arg11;
        };
        if (arg12 > 0) {
            assert!(arg12 > 100, 9888);
            v0.config.max_streams_to_store = arg12;
        };
        let v1 = StreamBuzzesConfigUpdated{
            are_live                 : v0.are_live,
            hive_per_ad_slot         : v0.engagement_scores.hive_per_ad_slot,
            bees_per_ad_slot         : v0.engagement_scores.bees_per_ad_slot,
            tax_on_bid               : v0.config.tax_on_bid,
            cur_auction_stream       : v0.cur_auction_stream,
            winning_bid_points       : v0.config.winning_bid_points,
            new_buzzes_count         : v0.config.choosen_buzzes_count,
            max_streams_per_slot     : v0.config.max_streams_per_slot,
            first_rank_assets_limit  : v0.config.first_rank_assets_limit,
            second_rank_assets_limit : v0.config.second_rank_assets_limit,
            third_rank_assets_limit  : v0.config.third_rank_assets_limit,
            max_streams_to_store     : v0.config.max_streams_to_store,
        };
        0x2::event::emit<StreamBuzzesConfigUpdated>(v1);
    }

    fun update_streamer_info(arg0: &mut StreamerInfo, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String) {
        arg0.streamer_name = 0x1::option::some<0x1::string::String>(arg1);
        arg0.streams_count = arg2;
        arg0.access_type = arg3;
        arg0.sui_per_buzz = arg4;
        arg0.buzz_cost_in_hive = arg5;
        arg0.remaining_buzzes_count = arg6;
        arg0.engagement_points = arg7;
        arg0.collection_name = arg8;
    }

    fun update_user_points<T0>(arg0: &mut StreamerBuzzes<T0>, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg3: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg5: address, arg6: 0x1::string::String, arg7: address, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u8, arg14: 0x1::string::String, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::linked_table::contains<address, ProfileScore>(&arg0.engagement_scores.user_points_score, arg5)) {
            0x2::linked_table::push_back<address, ProfileScore>(&mut arg0.engagement_scores.user_points_score, arg5, make_new_user_points(arg0.cur_auction_stream, 0, 0, 0, 0));
        };
        arg0.engagement_scores.ongoing_points_sum = arg0.engagement_scores.ongoing_points_sum + (arg8 as u128);
        if (arg9) {
            arg0.engagement_scores.total_sui_bidded = arg0.engagement_scores.total_sui_bidded + arg11;
        };
        let v0 = 0x2::linked_table::borrow_mut<address, ProfileScore>(&mut arg0.engagement_scores.user_points_score, arg5);
        if (v0.stream_epoch != arg0.cur_auction_stream) {
            let v1 = v0.stream_epoch;
            if (0x2::linked_table::contains<u64, HistoricalRecord>(&mut arg0.engagement_scores.historical_records, v1)) {
                let v2 = 0x2::linked_table::borrow<u64, HistoricalRecord>(&mut arg0.engagement_scores.historical_records, v1);
                let v3 = 0;
                if (v0.sui_bidded > 0 && v2.points_per_sui_bidded > 0) {
                    v3 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v0.sui_bidded as u256), v2.points_per_sui_bidded, (1000000000 as u256)) as u64);
                };
                let v4 = v0.points + v3;
                let v5 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v4 as u256), (v2.hive_for_participants as u256), (v2.total_points_sum as u256)) as u64);
                let v6 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u256((v4 as u256), (v2.bees_for_participants as u256), (v2.total_points_sum as u256)) as u64);
                let v7 = StreamPointsFinalizedForProfile{
                    profile_addr    : arg5,
                    username        : arg6,
                    from_stream     : v1,
                    points          : v0.points,
                    points_from_bid : v3,
                    total_points    : v4,
                    hive_earned     : v5,
                    bees_earned     : v6,
                    cur_epoch       : 0x2::tx_context::epoch(arg16),
                };
                0x2::event::emit<StreamPointsFinalizedForProfile>(v7);
                0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::deposit_gems_in_profile(arg2, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::hive_gems::split(&mut arg0.engagement_scores.hive_gems_available, v5));
                0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::transfer_bees_balance<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(arg4, arg3, 0x2::balance::split<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>(&mut arg0.engagement_scores.bees_available, v6), arg7, arg16);
            };
            if (v0.sui_bidded > 0 && !arg15) {
                let v8 = v0.sui_bidded;
                let v9 = 0x2::balance::split<T0>(&mut arg0.bid_pool, v8);
                let v10 = (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::math::mul_div_u128((v8 as u128), (arg0.config.tax_on_bid as u128), (0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::percent_precision() as u128)) as u64);
                0x2::balance::join<T0>(&mut arg0.sui_avail_for_pol, 0x2::balance::split<T0>(&mut v9, v10));
                0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::coin_helper::destroy_or_transfer_balance<T0>(v9, arg7, arg16);
                let v11 = UserBidExpired{
                    bidder_profile   : arg5,
                    username         : arg6,
                    bid_amt          : v8,
                    tax_on_bid       : v10,
                    bid_epoch_stream : v0.stream_epoch,
                };
                0x2::event::emit<UserBidExpired>(v11);
            };
            v0.stream_epoch = arg0.cur_auction_stream;
            v0.points = 0;
            v0.sui_bidded = 0;
            v0.flag = false;
            v0.buzz_cost_in_hive = 0;
            v0.access_type = 0;
            v0.collection_name = 0x1::string::utf8(b"");
        };
        v0.points = v0.points + arg8;
        let v12 = 0;
        if (arg9) {
            assert!(!v0.flag, 9863);
            let (v13, v14) = max_addable_to_bid(arg0.cur_auction_stream, arg0.stream_init_ms, 0x2::tx_context::epoch(arg16), arg10, arg11, v0.sui_bidded);
            assert!(arg11 <= v14, 9864);
            if (v0.sui_bidded == 0) {
                assert!(0x1::string::length(&arg14) <= 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::max_collection_name_length(), 9884);
                assert!(arg14 != 0x1::string::utf8(b""), 9885);
                v0.collection_name = arg14;
                assert!(!0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::does_collection_exist(arg1, arg14), 9886);
            };
            v0.sui_bidded = v0.sui_bidded + arg11;
            v0.flag = v13;
            v0.buzz_cost_in_hive = arg12;
            v0.access_type = arg13;
            let v15 = BidUpdatedByUser{
                bidder_profile         : arg5,
                username               : arg6,
                bid_amt                : v0.sui_bidded,
                flag                   : v0.flag,
                bid_epoch_stream       : v0.stream_epoch,
                next_stream_from_epoch : arg0.cur_auction_stream + 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::stream_duration_epoches(),
                buzz_cost_in_hive      : v0.buzz_cost_in_hive,
                access_type            : v0.access_type,
                collection_name        : v0.collection_name,
            };
            0x2::event::emit<BidUpdatedByUser>(v15);
            v12 = v0.sui_bidded;
        };
        v12
    }

    public fun upvote_hive_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfileMappingStore, arg2: &0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveManager, arg3: &mut HiveVault, arg4: &mut 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::HiveProfile, arg5: &0x2::token::TokenPolicyCap<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg6: &mut 0x2::token::TokenPolicy<0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::bee::BEE>, arg7: address, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, v2) = authority_check(arg4, v0);
        let v3 = 0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::borrow_app_from_profile<StreamerBuzzes<T0>>(&arg3.stream_buzz_cap, &mut arg3.streamer_profile, arg10);
        let v4 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, arg8), arg9);
        assert!(!0x2::linked_table::contains<address, HiveBuzz<T0>>(&v4.buzzes, arg7), 9876);
        let v5 = false;
        let v6 = 0;
        if (0x1::option::is_some<address>(&v3.streamers_info.rank1_profile) && v1 == *0x1::option::borrow<address>(&v3.streamers_info.rank1_profile)) {
            v5 = true;
            v6 = 1;
        } else if (0x1::option::is_some<address>(&v3.streamers_info.rank2_profile) && v1 == *0x1::option::borrow<address>(&v3.streamers_info.rank2_profile)) {
            v5 = true;
            v6 = 2;
        } else if (0x1::option::is_some<address>(&v3.streamers_info.rank3_profile) && v1 == *0x1::option::borrow<address>(&v3.streamers_info.rank3_profile)) {
            v5 = true;
            v6 = 3;
        };
        assert!(v5, 9871);
        let v7 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut v4.buzzes, arg7);
        assert!(!0x2::linked_table::contains<address, bool>(&v7.upvotes, v1), 9875);
        0x2::linked_table::push_back<address, bool>(&mut v7.upvotes, v1, true);
        let v8 = 0;
        if (v6 == 1) {
            v3.streamers_info.rank1_info.engagement_points = v3.streamers_info.rank1_info.engagement_points + 1;
            v8 = v3.streamers_info.rank1_info.engagement_points;
        } else if (v6 == 2) {
            v3.streamers_info.rank2_info.engagement_points = v3.streamers_info.rank2_info.engagement_points + 1;
            v8 = v3.streamers_info.rank2_info.engagement_points;
        } else if (v6 == 3) {
            v3.streamers_info.rank3_info.engagement_points = v3.streamers_info.rank3_info.engagement_points + 1;
            v8 = v3.streamers_info.rank3_info.engagement_points;
        };
        let v9 = UserUpvotedHiveBuzz{
            upvoted_by_profile_addr : v1,
            upvoted_by_username     : v2,
            stream_index            : arg8,
            stream_inner_index      : arg9,
            hive_buzz_by_profile    : arg7,
            streamer_profile        : v4.streamer,
            engagement_points       : v8,
        };
        0x2::event::emit<UserUpvotedHiveBuzz>(v9);
        update_user_points<T0>(v3, arg1, arg4, arg5, arg6, v1, v2, v0, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::like_points(), false, 0, 0, 0, 0, 0x1::string::utf8(b""), false, arg10);
        0xdaa92b45136039414845606e44e029fb5df2714797919d18a834bd5cd771839c::hive_profile::consume_entropy_of_profile(arg0, &arg3.stream_buzz_cap, arg2, arg4, 0x526fcd8e26368a0f1eb1b30e2830150a9fd5026edf6a3df117a9af1a7eac7752::constants::like_engagement_cost(), arg10);
    }

    // decompiled from Move bytecode v6
}

