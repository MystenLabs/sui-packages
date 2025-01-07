module 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    struct HiveVault has store, key {
        id: 0x2::object::UID,
        streamer_profile: 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile,
        gems_kraft_cap: 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGemKraftCap,
        hive_kraft_cap: 0x2::coin::TreasuryCap<HIVE>,
        stream_buzz_cap: 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveAppAccessCapability,
        active_supply: u64,
        genesis_ms: u64,
    }

    struct StreamerBuzzes<phantom T0> has store, key {
        id: 0x2::object::UID,
        are_live: bool,
        max_streams_per_slot: u64,
        cur_auction_stream: u64,
        stream_init_ms: u64,
        streamer_buzzes: 0x2::linked_table::LinkedTable<u64, vector<StreamBuzz<T0>>>,
        streams_count: u64,
        streamer_name: 0x1::option::Option<0x1::string::String>,
        streamer_profile: 0x1::option::Option<address>,
        sui_for_stream: 0x2::balance::Balance<T0>,
        sui_per_buzz: u64,
        buzz_cost_in_hive: u64,
        remaining_buzzes_count: u64,
        buzzes_count: u64,
        subscription_type: u64,
        engagement_scores: EngagementScores,
        bid_pool: 0x2::balance::Balance<T0>,
        leading_bid: LeadingBidInfo,
        min_bid_limit: u64,
        tax_on_bid: u64,
        sui_avail_for_pol: 0x2::balance::Balance<T0>,
        hive_avail_for_pol: 0x2::balance::Balance<HIVE>,
    }

    struct EngagementScores has store {
        hive_gems_available: 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGems,
        hive_per_ad_slot: u64,
        bees_available: 0x2::balance::Balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>,
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
        subscription_type: u64,
    }

    struct HistoricalRecord has copy, store {
        hive_for_participants: u64,
        bees_for_participants: u64,
        total_points_sum: u128,
        points_per_sui_bidded: u256,
    }

    struct LeadingBidInfo has drop, store {
        profile_addr: 0x1::option::Option<address>,
        username: 0x1::option::Option<0x1::string::String>,
        bid_amt: u64,
        buzz_cost_in_hive: u64,
        subscription_type: u64,
    }

    struct StreamBuzz<phantom T0> has store {
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
        min_bid_limit: u64,
        tax_on_bid: u64,
        cur_auction_stream: u64,
        new_buzzes_count: u64,
        max_streams_per_slot: u64,
    }

    struct NewStreamInitiated has copy, drop {
        streamer_name: 0x1::string::String,
        streamer_profile: address,
        stream_init_ms: u64,
        streaming_from_epoch: u64,
        buzz_cost_in_hive: u64,
        subscription_type: u64,
        hive_for_streamer: u64,
        bee_for_streamer: u64,
        hive_for_participants: u64,
        bees_for_participants: u64,
        points_per_sui_bidded: u256,
        total_points_sum: u128,
        points_for_all_bids: u128,
        sui_from_remaining_rewards: u64,
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
        buzz_cost_in_hive: u64,
        subscription_type: u64,
    }

    struct UserBidExpired has copy, drop {
        bidder_profile: address,
        username: 0x1::string::String,
        bid_amt: u64,
        tax_on_bid: u64,
        bid_epoch_stream: u64,
    }

    struct NewLeadingBid has copy, drop {
        bidder: address,
        username: 0x1::string::String,
        sui_bidded_by_user: u64,
        buzz_cost_in_hive: u64,
        subscription_type: u64,
    }

    struct NewStreamBuzzKrafted has copy, drop {
        streamer_name: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        stream_index: u64,
        index: u64,
    }

    struct BuzzChoosenForStream has copy, drop {
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
        hive_streamed_to_pol: u64,
    }

    struct UserLikedStreamBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        stream_index: u64,
        stream_inner_index: u64,
    }

    struct UserUpvotedHiveBuzz has copy, drop {
        upvoted_by_profile_addr: address,
        upvoted_by_username: 0x1::string::String,
        stream_index: u64,
        stream_inner_index: u64,
        hive_buzz_by_profile: address,
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
    }

    public fun add_bees_for_streaming_incentives<T0>(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg2).engagement_scores.bees_available, arg1);
    }

    public fun add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg3: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2) = authority_check(arg4, 0x2::tx_context::sender(arg9));
        let v3 = 0x2::coin::into_balance<T0>(arg5);
        assert!(arg8 == 100 || arg8 == 1 || arg8 == 3 || arg8 == 12, 9867);
        let v4 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg9);
        assert!(v4.are_live, 9861);
        assert!(0x2::tx_context::epoch(arg9) < v4.cur_auction_stream + 1, 9862);
        let v5 = update_user_points<T0>(v4, arg4, arg2, arg3, v1, v2, v0, 0, true, 0x2::clock::timestamp_ms(arg0), arg6, arg7, arg8, false, arg9);
        assert!(v5 >= v4.min_bid_limit, 9880);
        if (0x1::option::is_some<address>(&v4.leading_bid.profile_addr)) {
            if (v5 > v4.leading_bid.bid_amt) {
                v4.engagement_scores.leading_bid_amt = v5;
                v4.leading_bid.profile_addr = 0x1::option::some<address>(v1);
                v4.leading_bid.username = 0x1::option::some<0x1::string::String>(v2);
                v4.leading_bid.bid_amt = v5;
                v4.leading_bid.buzz_cost_in_hive = arg7;
                v4.leading_bid.subscription_type = arg8;
                let v6 = NewLeadingBid{
                    bidder             : v1,
                    username           : v2,
                    sui_bidded_by_user : v5,
                    buzz_cost_in_hive  : arg7,
                    subscription_type  : arg8,
                };
                0x2::event::emit<NewLeadingBid>(v6);
            };
        } else {
            let v7 = LeadingBidInfo{
                profile_addr      : 0x1::option::some<address>(v1),
                username          : 0x1::option::some<0x1::string::String>(v2),
                bid_amt           : v5,
                buzz_cost_in_hive : arg7,
                subscription_type : arg8,
            };
            v4.leading_bid = v7;
        };
        0x2::balance::join<T0>(&mut v4.bid_pool, 0x2::balance::split<T0>(&mut v3, arg6));
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<T0>(v3, v0, arg9);
    }

    public fun add_hive_for_streaming_incentives<T0>(arg0: &mut HiveVault, arg1: &mut 0x2::coin::Coin<HIVE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<HIVE>(0x2::coin::split<HIVE>(arg1, arg2, arg3));
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = burn_hive_and_return_gems(arg0, v0, v1, arg3);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::join(&mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg3).engagement_scores.hive_gems_available, v2);
    }

    public entry fun add_to_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg2, 0x2::tx_context::sender(arg7));
        let v2 = 0x1::option::none<0x1::string::String>();
        if (arg4 != 0x1::string::utf8(b"")) {
            v2 = 0x1::option::some<0x1::string::String>(arg4);
        };
        buzz_check(arg3, v2);
        let v3 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg7);
        assert!(v0 == *0x1::option::borrow<address>(&v3.streamer_profile), 9873);
        assert!(v3.streams_count + 1 <= v3.max_streams_per_slot, 9874);
        internal_add_to_stream_buzz<T0>(false, v3, arg5, arg6, 0x2::clock::timestamp_ms(arg0), v1, arg3, v2, arg7);
    }

    fun authority_check(arg0: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg1: address) : (address, 0x1::string::String) {
        let (v0, v1, v2, v3) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(arg0);
        if (!v2) {
            assert!(v3 == arg1, 9873);
        };
        (v0, v1)
    }

    public fun burn_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg2: 0x2::balance::Balance<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        let (v0, _, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(&arg0.streamer_profile);
        let (v4, _, _, _, _, _, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_subscriber_subscription_info(arg1, v0);
        if (!v4) {
            0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::make_forever_subscriber(arg0.genesis_ms, arg1, &mut arg0.streamer_profile);
        };
        let v12 = 0x2::tx_context::sender(arg4);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_in_profile(arg1, burn_hive_and_return_gems(arg0, 0x2::balance::split<HIVE>(&mut arg2, arg3), v12, arg4));
        arg2
    }

    public fun burn_hive_and_return_gems(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<HIVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGems {
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
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::withdraw_gems_from_comp_profile(&mut arg0.streamer_profile, v0)
    }

    public entry fun burn_hive_for_gems(arg0: &mut HiveVault, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg2: 0x2::coin::Coin<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_hive_and_return(arg0, arg1, 0x2::coin::into_balance<HIVE>(arg2), arg3, arg4);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    fun buzz_check(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>) {
        assert!(0x1::string::length(&arg0) < 510, 9870);
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v0 = *0x1::option::borrow<0x1::string::String>(&arg1);
            assert!(0x1::string::length(&v0) < 240, 9869);
        };
    }

    fun calculate_profile_rewards<T0>(arg0: &StreamerBuzzes<T0>, arg1: &ProfileScore) : (u128, u64, u64, u64, bool) {
        let v0 = false;
        let (v1, v2, v3, v4) = if (arg1.stream_epoch != arg0.cur_auction_stream) {
            v0 = true;
            let v5 = 0x2::linked_table::borrow<u64, HistoricalRecord>(&arg0.engagement_scores.historical_records, arg1.stream_epoch);
            let v6 = 0;
            if (arg1.sui_bidded > 0 && v5.points_per_sui_bidded > 0) {
                v6 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((arg1.sui_bidded as u256), v5.points_per_sui_bidded, (1000000 as u256)) as u64);
            };
            (v5.bees_for_participants, v5.hive_for_participants, v5.total_points_sum, arg1.points + v6)
        } else {
            let v7 = arg1.points;
            let v4 = v7;
            let v8 = arg0.engagement_scores.ongoing_points_sum;
            let v3 = v8;
            if (arg0.leading_bid.bid_amt > 0) {
                let v9 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256(((10000 * 1000000) as u256), (1000000 as u256), (arg0.leading_bid.bid_amt as u256));
                v3 = v8 + (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256(v9, (arg0.engagement_scores.total_sui_bidded as u256), (1000000 as u256)) as u128);
                if (arg1.sui_bidded > 0) {
                    v4 = v7 + (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((arg1.sui_bidded as u256), v9, (1000000 as u256)) as u64);
                };
            };
            (arg0.engagement_scores.bees_per_ad_slot * (10000 - 1500) / 10000, arg0.engagement_scores.hive_per_ad_slot * (10000 - 1500) / 10000, v3, v4)
        };
        (v3, v4, (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((v4 as u256), (v2 as u256), (v3 as u256)) as u64), (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((v4 as u256), (v1 as u256), (v3 as u256)) as u64), v0)
    }

    public fun choose_buzzes_for_sui_rewards<T0>(arg0: &mut HiveVault, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg5));
        let v2 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg5);
        assert!(v0 == *0x1::option::borrow<address>(&v2.streamer_profile), 9862);
        assert!(arg2 >= 0x2::linked_table::length<u64, vector<StreamBuzz<T0>>>(&v2.streamer_buzzes) - v2.streams_count, 9863);
        let v3 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v2.streamer_buzzes, arg2), arg3).buzzes, arg4);
        assert!(!v3.is_choosen, 9864);
        assert!(v2.remaining_buzzes_count > 0, 9865);
        let v4 = BuzzChoosenForStream{
            stream_index         : arg2,
            stream_inner_index   : arg3,
            choosen_buzz_profile : arg4,
            buzz                 : v3.buzz,
            gen_ai_url           : v3.gen_ai_url,
        };
        0x2::event::emit<BuzzChoosenForStream>(v4);
        0x2::balance::join<T0>(&mut v3.sui_earned, 0x2::balance::split<T0>(&mut v2.sui_for_stream, v2.sui_per_buzz));
        v2.remaining_buzzes_count = v2.remaining_buzzes_count - 1;
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveVault, arg1: &mut 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<HIVE>(deposit_gems_for_hive_and_return(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_gems_for_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGems, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        kraft_hive(arg0, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(arg1, arg2), arg2, 0x2::tx_context::sender(arg3))
    }

    public entry fun deposit_gems_via_profile(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<HIVE>(deposit_gems_via_profile_and_return(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5), arg5);
    }

    public fun deposit_gems_via_profile_and_return(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        let (v0, _, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(&arg2.streamer_profile);
        let (v4, _, _, _, _, _, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_subscriber_subscription_info(arg3, v0);
        if (!v4) {
            0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::make_forever_subscriber(arg2.genesis_ms, arg3, &mut arg2.streamer_profile);
        };
        kraft_hive(arg2, 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::withdraw_gems_from_profile(arg0, arg1, arg3, arg4, arg5), arg4, 0x2::tx_context::sender(arg5))
    }

    public fun get_active_hive_supply(arg0: &HiveVault) : u64 {
        arg0.active_supply
    }

    public fun get_current_streamer_info<T0>(arg0: &HiveVault) : (bool, u64, u64, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<address>, u64, u64, u64, u64, u64) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.are_live, v0.cur_auction_stream, v0.stream_init_ms, v0.streamer_name, v0.streamer_profile, 0x2::balance::value<T0>(&v0.sui_for_stream), v0.sui_per_buzz, v0.buzz_cost_in_hive, v0.remaining_buzzes_count, v0.subscription_type)
    }

    public fun get_dao_hiveprofile_info(arg0: &HiveVault) : (0x1::string::String, 0x1::string::String, vector<u64>, u64, 0x1::string::String, bool, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_info(&arg0.streamer_profile)
    }

    public fun get_engagement_scores_state<T0>(arg0: &HiveVault) : (u64, u64, u64, u64, u64, u128, u64, u64, u128) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&v0.engagement_scores.hive_gems_available), v0.engagement_scores.hive_per_ad_slot, 0x2::balance::value<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&v0.engagement_scores.bees_available), v0.engagement_scores.bees_per_ad_slot, v0.engagement_scores.total_sui_bidded, v0.engagement_scores.ongoing_points_sum, 0x2::linked_table::length<address, ProfileScore>(&v0.engagement_scores.user_points_score), v0.engagement_scores.leading_bid_amt, v0.engagement_scores.points_per_sui_bidded)
    }

    public fun get_hive_buzz_for_user_for_stream<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : (0x1::string::String, 0x1::option::Option<0x1::string::String>, bool, u64) {
        let v0 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg2), arg3);
        if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v0.buzzes, arg1)) {
            let v5 = 0x2::linked_table::borrow<address, HiveBuzz<T0>>(&v0.buzzes, arg1);
            (v5.buzz, v5.gen_ai_url, v5.is_choosen, 0x2::balance::value<T0>(&v5.sui_earned))
        } else {
            (0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), false, 0)
        }
    }

    public fun get_leading_bid_info<T0>(arg0: &HiveVault) : (0x1::option::Option<address>, 0x1::option::Option<0x1::string::String>, u64, u64, u64) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.leading_bid.profile_addr, v0.leading_bid.username, v0.leading_bid.bid_amt, v0.leading_bid.buzz_cost_in_hive, v0.leading_bid.subscription_type)
    }

    public fun get_points_for_all_profiles<T0>(arg0: &HiveVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0x1::vector::empty<bool>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
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
            0x1::vector::push_back<u64>(&mut v6, v17.subscription_type);
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

    public fun get_points_for_profile<T0>(arg0: &HiveVault, arg1: address) : (u64, u64, bool, u64, u64, u64, u64, u64, u64, bool, u128) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = if (0x2::linked_table::contains<address, ProfileScore>(&v0.engagement_scores.user_points_score, arg1)) {
            let v12 = 0x2::linked_table::borrow<address, ProfileScore>(&v0.engagement_scores.user_points_score, arg1);
            let (v13, v14, v15, v16, v17) = calculate_profile_rewards<T0>(v0, v12);
            (v12.stream_epoch, v17, v13, v12.points, v12.flag, v12.sui_bidded, v12.buzz_cost_in_hive, v12.subscription_type, v14, v15, v16)
        } else {
            (0, false, 0, 0, false, 0, 0, 0, 0, 0, 0)
        };
        (v1, v4, v5, v6, v7, v8, v9, v10, v11, v2, v3)
    }

    public fun get_stream_info_for_index<T0>(arg0: &HiveVault, arg1: u64) : (u64, u64, 0x1::string::String, 0x1::option::Option<0x1::string::String>, u64, u64) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        if (0x2::linked_table::contains<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1)) {
            let v7 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1);
            let v8 = 0x1::vector::borrow<StreamBuzz<T0>>(v7, 0);
            (0x1::vector::length<StreamBuzz<T0>>(v7), v8.timestamp, v8.buzz, v8.gen_ai_url, 0x2::linked_table::length<address, bool>(&v8.likes), 0x2::linked_table::length<address, HiveBuzz<T0>>(&v8.buzzes))
        } else {
            (0, 0, 0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), 0, 0)
        }
    }

    public fun get_streamer_buzzes_params<T0>(arg0: &HiveVault) : (bool, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.are_live, v0.max_streams_per_slot, v0.buzzes_count, v0.engagement_scores.hive_per_ad_slot, v0.engagement_scores.bees_per_ad_slot, v0.min_bid_limit, v0.tax_on_bid)
    }

    public fun get_streamer_pol_info<T0>(arg0: &HiveVault) : (u64, u64, u64) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (0x2::balance::value<T0>(&v0.bid_pool), 0x2::balance::value<T0>(&v0.sui_avail_for_pol), 0x2::balance::value<HIVE>(&v0.hive_avail_for_pol))
    }

    public fun has_user_liked<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : bool {
        0x2::linked_table::contains<address, bool>(&0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg2), arg3).likes, arg1)
    }

    public entry fun increment_stream<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg3: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let (v2, v3, _, v5) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(arg2);
        let v6 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg5);
        if (!v6.are_live || v0 < v6.cur_auction_stream + 1) {
            return
        };
        0x2::balance::join<T0>(&mut v6.sui_avail_for_pol, 0x2::balance::withdraw_all<T0>(&mut v6.sui_for_stream));
        v6.cur_auction_stream = v0;
        v6.stream_init_ms = v1;
        v6.streams_count = 0;
        if (v6.leading_bid.bid_amt >= v6.min_bid_limit) {
            assert!(v2 == *0x1::option::borrow<address>(&v6.leading_bid.profile_addr), 9881);
            v6.streamer_name = 0x1::option::some<0x1::string::String>(0x1::option::extract<0x1::string::String>(&mut v6.leading_bid.username));
            v6.streamer_profile = 0x1::option::some<address>(0x1::option::extract<address>(&mut v6.leading_bid.profile_addr));
            v6.buzz_cost_in_hive = v6.leading_bid.buzz_cost_in_hive;
            v6.subscription_type = v6.leading_bid.subscription_type;
            let v7 = v6.leading_bid.bid_amt;
            let v8 = 0x2::balance::split<T0>(&mut v6.bid_pool, v7);
            let v9 = v7 * 7000 / 10000;
            0x2::balance::join<T0>(&mut v6.sui_avail_for_pol, 0x2::balance::split<T0>(&mut v8, v9));
            0x2::balance::join<T0>(&mut v6.sui_for_stream, 0x2::balance::withdraw_all<T0>(&mut v8));
            v6.sui_per_buzz = 0x2::balance::value<T0>(&v6.sui_for_stream) / v6.buzzes_count;
            0x2::balance::destroy_zero<T0>(v8);
            let v10 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256(((10000 * 1000000) as u256), (1000000 as u256), (v7 as u256));
            let v11 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256(v10, (v6.engagement_scores.total_sui_bidded as u256), (1000000 as u256)) as u128);
            let v12 = v6.engagement_scores.ongoing_points_sum + v11;
            if (v6.engagement_scores.hive_per_ad_slot > 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&v6.engagement_scores.hive_gems_available)) {
                v6.engagement_scores.hive_per_ad_slot = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&v6.engagement_scores.hive_gems_available);
            };
            if (v6.engagement_scores.bees_per_ad_slot > 0x2::balance::value<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&v6.engagement_scores.bees_available)) {
                v6.engagement_scores.bees_per_ad_slot = 0x2::balance::value<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&v6.engagement_scores.bees_available);
            };
            let v13 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div(v6.engagement_scores.hive_per_ad_slot, 1500, 10000);
            let v14 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div(v6.engagement_scores.bees_per_ad_slot, 1500, 10000);
            0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_in_profile(arg2, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(&mut v6.engagement_scores.hive_gems_available, v13));
            0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg4, arg3, 0x2::balance::split<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut v6.engagement_scores.bees_available, v14), v5, arg5);
            let v15 = v6.engagement_scores.hive_per_ad_slot - v13;
            let v16 = v6.engagement_scores.bees_per_ad_slot - v14;
            let v17 = HistoricalRecord{
                hive_for_participants : v15,
                bees_for_participants : v16,
                total_points_sum      : v12,
                points_per_sui_bidded : v10,
            };
            0x2::linked_table::push_back<u64, HistoricalRecord>(&mut v6.engagement_scores.historical_records, v6.cur_auction_stream, v17);
            let v18 = NewStreamInitiated{
                streamer_name              : *0x1::option::borrow<0x1::string::String>(&v6.streamer_name),
                streamer_profile           : *0x1::option::borrow<address>(&v6.streamer_profile),
                stream_init_ms             : v6.stream_init_ms,
                streaming_from_epoch       : v6.cur_auction_stream,
                buzz_cost_in_hive          : v6.buzz_cost_in_hive,
                subscription_type          : v6.subscription_type,
                hive_for_streamer          : v13,
                bee_for_streamer           : v14,
                hive_for_participants      : v15,
                bees_for_participants      : v16,
                points_per_sui_bidded      : v10,
                total_points_sum           : v12,
                points_for_all_bids        : v11,
                sui_from_remaining_rewards : 0x2::balance::value<T0>(&v6.sui_for_stream),
                sui_for_pol_from_bid       : v9,
            };
            0x2::event::emit<NewStreamInitiated>(v18);
        } else {
            v6.streamer_name = 0x1::option::none<0x1::string::String>();
            v6.streamer_profile = 0x1::option::none<address>();
            let v19 = NewStreamerNotFound{
                stream_init_ms       : v1,
                streaming_from_epoch : v6.cur_auction_stream,
            };
            0x2::event::emit<NewStreamerNotFound>(v19);
        };
        if (0x1::option::is_some<address>(&v6.streamer_profile)) {
            update_user_points<T0>(v6, arg2, arg3, arg4, v2, v3, v5, 0, false, v1, 0, 0, 0, true, arg5);
        };
        v6.cur_auction_stream = v0;
        v6.stream_init_ms = v1;
        v6.streams_count = 0;
        v6.engagement_scores.total_sui_bidded = 0;
        v6.leading_bid.profile_addr = 0x1::option::none<address>();
        v6.leading_bid.username = 0x1::option::none<0x1::string::String>();
        v6.leading_bid.bid_amt = 0;
        v6.leading_bid.buzz_cost_in_hive = 0;
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HIVE", x"484956452047454d53206172652074686520696e2d67616d652063757272656e637920616e642067656f7665726e616e636520746f6b656e20666f7220446567656e4869766527732070726f6772616d6d61626c652d6964656e7469747920284869766550726f66696c65292064726976656e206f70656e2d686976652e200a2048495645206973206b726166746564206f6e206120313a3120626173697320616761696e737420484956452047454d5320616e6420656e61626c657320757365727320746f207472616465206974206f6e20446567656e486976652044455820616e6420636f6d706f73652077697468206f746865722070726f746f636f6c73206f6e2d746f70206f6620535549206e6574776f726b2e", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_hive_vault<T0>(arg0: &mut 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x26346e185003acbf732d373c60413cee41996a9fbdf8790ae1b7385f6a6a9b32::hsui_vault::HSuiVault, arg4: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfileMappingStore, arg5: 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGemKraftCap, arg6: 0x2::coin::TreasuryCap<HIVE>, arg7: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg8: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HSuiDisperser<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::friend_add_streaming_app(arg4, 0x1::ascii::string(b"STREAMER_BUZZES"), true, true, true, arg10);
        let v1 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::kraft_hive_gems(&mut arg5, 1000000000000000);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_with_manager_profile(arg7, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(&mut v1, 15000000000000));
        let (v2, v3) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::kraft_owned_hive_profile(arg1, arg2, arg3, arg4, arg7, arg8, arg9, 0x1::string::utf8(b"StreamBuzz"), 0x1::string::utf8(b"Launch your show with StreamBuzz, and interact with your community via HiveBuzzes!"), arg10);
        let v4 = v2;
        let v5 = EngagementScores{
            hive_gems_available   : 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(&mut v1, 15000000000000),
            hive_per_ad_slot      : 0,
            bees_available        : 0x2::balance::zero<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(),
            bees_per_ad_slot      : 0,
            ongoing_points_sum    : 0,
            user_points_score     : 0x2::linked_table::new<address, ProfileScore>(arg10),
            total_sui_bidded      : 0,
            leading_bid_amt       : 0,
            points_per_sui_bidded : 0,
            historical_records    : 0x2::linked_table::new<u64, HistoricalRecord>(arg10),
        };
        let v6 = LeadingBidInfo{
            profile_addr      : 0x1::option::none<address>(),
            username          : 0x1::option::none<0x1::string::String>(),
            bid_amt           : 0,
            buzz_cost_in_hive : 0,
            subscription_type : 0,
        };
        let v7 = StreamerBuzzes<T0>{
            id                     : 0x2::object::new(arg10),
            are_live               : false,
            max_streams_per_slot   : 24,
            cur_auction_stream     : 0,
            stream_init_ms         : 0,
            streamer_buzzes        : 0x2::linked_table::new<u64, vector<StreamBuzz<T0>>>(arg10),
            streams_count          : 0,
            streamer_name          : 0x1::option::none<0x1::string::String>(),
            streamer_profile       : 0x1::option::none<address>(),
            sui_for_stream         : 0x2::balance::zero<T0>(),
            sui_per_buzz           : 0,
            buzz_cost_in_hive      : 0,
            remaining_buzzes_count : 0,
            buzzes_count           : 10,
            subscription_type      : 100,
            engagement_scores      : v5,
            bid_pool               : 0x2::balance::zero<T0>(),
            leading_bid            : v6,
            min_bid_limit          : 100000000,
            tax_on_bid             : 500,
            sui_avail_for_pol      : 0x2::balance::zero<T0>(),
            hive_avail_for_pol     : 0x2::balance::zero<HIVE>(),
        };
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_add_app_to_profile<StreamerBuzzes<T0>>(&v0, &mut v4, v7, arg10);
        let v8 = HiveVault{
            id               : 0x2::object::new(arg10),
            streamer_profile : v4,
            gems_kraft_cap   : arg5,
            hive_kraft_cap   : arg6,
            stream_buzz_cap  : v0,
            active_supply    : 0,
            genesis_ms       : 0x2::clock::timestamp_ms(arg1),
        };
        let v9 = &mut v8;
        let v10 = &mut v1;
        0x2::transfer::share_object<HiveVault>(v8);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::destroy_zero(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIVE>>(0x2::coin::from_balance<HIVE>(deposit_gems_for_hive_and_return(v9, v10, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&v1), arg10), arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg10), 0x2::tx_context::sender(arg10));
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::config::vault_setup_by_deployer(arg0);
    }

    public entry fun interact_with_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveDisperser, arg6: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg7: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let (v1, v2) = authority_check(arg6, v0);
        let (v3, _, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(arg7);
        buzz_check(arg10, arg11);
        let v7 = false;
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::stream_consume_entropy(arg0, arg1, arg6, 10, arg12);
        let v8 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg2.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        let v9 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::withdraw_gems_from_profile(arg0, arg1, arg6, v8.buzz_cost_in_hive, arg12);
        let v10 = 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&v9);
        let v11 = 0;
        let v12 = if (0x1::option::is_some<address>(&v8.streamer_profile)) {
            assert!(v3 == *0x1::option::borrow<address>(&v8.streamer_profile), 9871);
            let v13 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u128((v10 as u128), (7000 as u128), (10000 as u128)) as u64);
            let v14 = v10 - v13;
            v11 = v14;
            0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_in_profile(arg7, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(&mut v9, v14));
            if (v8.subscription_type == 100) {
                0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::make_forever_subscriber(v8.stream_init_ms, arg6, arg7);
            } else {
                v7 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::internal_subscribe_to_profile(arg0, arg1, arg6, arg7, arg5, v8.subscription_type, 0, arg12);
            };
            v13
        } else {
            0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::make_forever_subscriber(v8.stream_init_ms, arg6, &mut arg2.streamer_profile);
            v10
        };
        let v15 = kraft_hive(arg2, v9, v12, @0x0);
        let v16 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg12);
        0x2::balance::join<HIVE>(&mut v16.hive_avail_for_pol, v15);
        assert!(arg8 >= 0x2::linked_table::length<u64, vector<StreamBuzz<T0>>>(&v16.streamer_buzzes) - v16.streams_count, 9877);
        let v17 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v16.streamer_buzzes, arg8), arg9);
        let v18 = HiveBuzzForAStreamBuzzKrafted{
            streamer_profile          : v3,
            stream_index              : arg8,
            stream_inner_index        : arg9,
            user_profile              : v1,
            username                  : v2,
            user_buzz                 : arg10,
            gen_ai_url                : arg11,
            hive_streamed_to_streamer : v11,
            hive_streamed_to_pol      : v12,
        };
        0x2::event::emit<HiveBuzzForAStreamBuzzKrafted>(v18);
        let v19 = if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v17.buzzes, v1)) {
            let v19 = 0x2::linked_table::remove<address, HiveBuzz<T0>>(&mut v17.buzzes, v1);
            assert!(!v19.is_choosen, 9868);
            v19.buzz = arg10;
            v19.gen_ai_url = arg11;
            v19
        } else {
            HiveBuzz<T0>{buzz: arg10, gen_ai_url: arg11, sui_earned: 0x2::balance::zero<T0>(), is_choosen: false, upvotes: 0x2::linked_table::new<address, bool>(arg12)}
        };
        0x2::linked_table::push_back<address, HiveBuzz<T0>>(&mut v17.buzzes, v1, v19);
        let v20 = if (v7) {
            100 * 1000000
        } else {
            10 * 1000000
        };
        update_user_points<T0>(v16, arg6, arg3, arg4, v1, v2, v0, v20, false, 0, 0, 0, 0, false, arg12);
    }

    fun internal_add_to_stream_buzz<T0>(arg0: bool, arg1: &mut StreamerBuzzes<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamBuzz<T0>{
            timestamp  : arg4,
            buzz       : arg6,
            gen_ai_url : arg7,
            likes      : 0x2::linked_table::new<address, bool>(arg8),
            buzzes     : 0x2::linked_table::new<address, HiveBuzz<T0>>(arg8),
        };
        let v1 = 0x2::linked_table::length<u64, vector<StreamBuzz<T0>>>(&arg1.streamer_buzzes);
        let v2 = 0;
        if (arg3) {
            if (!arg0) {
                assert!(arg1.streams_count < arg1.max_streams_per_slot, 9874);
            };
            let v3 = 0x1::vector::empty<StreamBuzz<T0>>();
            0x1::vector::push_back<StreamBuzz<T0>>(&mut v3, v0);
            0x2::linked_table::push_back<u64, vector<StreamBuzz<T0>>>(&mut arg1.streamer_buzzes, v1, v3);
            arg1.streams_count = arg1.streams_count + 1;
            arg2 = v1;
        } else {
            if (!arg0) {
                assert!(arg2 >= v1 - arg1.streams_count, 9877);
            };
            let v4 = 0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut arg1.streamer_buzzes, arg2);
            v2 = 0x1::vector::length<StreamBuzz<T0>>(v4);
            0x1::vector::push_back<StreamBuzz<T0>>(v4, v0);
            assert!(0x1::vector::length<StreamBuzz<T0>>(v4) <= 24, 9866);
        };
        let v5 = NewStreamBuzzKrafted{
            streamer_name : arg5,
            buzz          : arg6,
            gen_ai_url    : arg7,
            stream_index  : arg2,
            index         : v2,
        };
        0x2::event::emit<NewStreamBuzzKrafted>(v5);
    }

    fun kraft_hive(arg0: &mut HiveVault, arg1: 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::HiveGems, arg2: u64, arg3: address) : 0x2::balance::Balance<HIVE> {
        assert!(0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::value(&arg1) == arg2, 9876);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_in_profile(&mut arg0.streamer_profile, arg1);
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

    public fun like_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = authority_check(arg5, v0);
        let v3 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg8);
        let v4 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, arg6), arg7);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v1), 9872);
        let v5 = UserLikedStreamBuzz{
            user_profile_addr  : v1,
            username           : v2,
            stream_index       : arg6,
            stream_inner_index : arg7,
        };
        0x2::event::emit<UserLikedStreamBuzz>(v5);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v1, true);
        update_user_points<T0>(v3, arg5, arg3, arg4, v1, v2, v0, 1000000, false, 0, 0, 0, 0, false, arg8);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::stream_consume_entropy(arg0, arg1, arg5, 1, arg8);
    }

    public entry fun make_hive_launch_stream<T0>(arg0: &0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut HiveVault, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1, _, _) = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::get_profile_meta_info(&arg2.streamer_profile);
        let v4 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg5);
        internal_add_to_stream_buzz<T0>(true, v4, 0, true, 0x2::clock::timestamp_ms(arg1), v1, arg3, arg4, arg5);
    }

    fun make_new_user_points(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : ProfileScore {
        ProfileScore{
            stream_epoch      : arg0,
            points            : arg1,
            sui_bidded        : arg2,
            flag              : false,
            buzz_cost_in_hive : arg3,
            subscription_type : arg4,
        }
    }

    fun max_addable_to_bid(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (bool, u64) {
        if (arg2 < arg0 + 1) {
            return (false, arg4)
        };
        if (arg5 == 0) {
            return (false, 0)
        };
        (true, (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((arg5 as u256), ((arg1 + 1 * 86400000 - arg3) as u256), ((0 * 86400000) as u256)) as u64))
    }

    public fun query_across_buzzes_for_stream<T0>(arg0: &HiveVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1), arg2);
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
        let v1 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1), arg2);
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
        let v5 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1);
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

    public entry fun retrieve_sui_from_buzz<T0>(arg0: &mut HiveVault, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg4).streamer_buzzes, arg2), arg3).buzzes, v0);
        assert!(v2.is_choosen, 9861);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v2.sui_earned), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun transfer_pol<T0>(arg0: &0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::config::TwoAmmFeeClaimCapability, arg1: &mut HiveVault, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<HIVE>) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg2);
        (0x2::balance::withdraw_all<T0>(&mut v0.sui_avail_for_pol), 0x2::balance::withdraw_all<HIVE>(&mut v0.hive_avail_for_pol))
    }

    public fun update_streamer_buzzes<T0>(arg0: &0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::config::HiveDaoCapability, arg1: &mut HiveVault, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg9);
        v0.are_live = arg2;
        if (!v0.are_live && arg2) {
            v0.cur_auction_stream = 0x2::tx_context::epoch(arg9);
        };
        if (arg7 > 0) {
            assert!(arg7 < 200000000000, 9878);
            v0.engagement_scores.hive_per_ad_slot = arg7;
        };
        if (arg8 > 0) {
            assert!(arg8 < 51000000000000, 9882);
            v0.engagement_scores.bees_per_ad_slot = arg8;
        };
        if (arg4 > 0) {
            assert!(arg4 > 100000000, 9877);
            v0.min_bid_limit = arg4;
        };
        if (arg5 > 0) {
            assert!(100 < arg5 && arg5 < 5000, 9875);
            v0.tax_on_bid = arg5;
        };
        if (arg3 > 0) {
            assert!(arg3 <= 420, 9869);
            assert!(arg3 > 1, 9870);
            v0.buzzes_count = arg3;
        };
        if (arg6 > 0) {
            assert!(arg6 > 5, 9874);
            assert!(arg6 < 51, 9873);
            v0.max_streams_per_slot = arg6;
        };
        let v1 = StreamBuzzesConfigUpdated{
            are_live             : v0.are_live,
            hive_per_ad_slot     : v0.engagement_scores.hive_per_ad_slot,
            bees_per_ad_slot     : v0.engagement_scores.bees_per_ad_slot,
            min_bid_limit        : v0.min_bid_limit,
            tax_on_bid           : v0.tax_on_bid,
            cur_auction_stream   : v0.cur_auction_stream,
            new_buzzes_count     : v0.buzzes_count,
            max_streams_per_slot : v0.max_streams_per_slot,
        };
        0x2::event::emit<StreamBuzzesConfigUpdated>(v1);
    }

    fun update_user_points<T0>(arg0: &mut StreamerBuzzes<T0>, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg2: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg3: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: address, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (!0x2::linked_table::contains<address, ProfileScore>(&arg0.engagement_scores.user_points_score, arg4)) {
            0x2::linked_table::push_back<address, ProfileScore>(&mut arg0.engagement_scores.user_points_score, arg4, make_new_user_points(arg0.cur_auction_stream, 0, 0, 0, 0));
        };
        arg0.engagement_scores.ongoing_points_sum = arg0.engagement_scores.ongoing_points_sum + (arg7 as u128);
        if (arg8) {
            arg0.engagement_scores.total_sui_bidded = arg0.engagement_scores.total_sui_bidded + arg10;
        };
        let v0 = 0x2::linked_table::borrow_mut<address, ProfileScore>(&mut arg0.engagement_scores.user_points_score, arg4);
        if (v0.stream_epoch != arg0.cur_auction_stream) {
            let v1 = v0.stream_epoch;
            if (0x2::linked_table::contains<u64, HistoricalRecord>(&mut arg0.engagement_scores.historical_records, v1)) {
                let v2 = 0x2::linked_table::borrow<u64, HistoricalRecord>(&mut arg0.engagement_scores.historical_records, v1);
                let v3 = 0;
                if (v0.sui_bidded > 0 && v2.points_per_sui_bidded > 0) {
                    v3 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((v0.sui_bidded as u256), v2.points_per_sui_bidded, (1000000 as u256)) as u64);
                };
                let v4 = v0.points + v3;
                let v5 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((v4 as u256), (v2.hive_for_participants as u256), (v2.total_points_sum as u256)) as u64);
                let v6 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u256((v4 as u256), (v2.bees_for_participants as u256), (v2.total_points_sum as u256)) as u64);
                let v7 = StreamPointsFinalizedForProfile{
                    profile_addr    : arg4,
                    username        : arg5,
                    from_stream     : v1,
                    points          : v0.points,
                    points_from_bid : v3,
                    total_points    : v4,
                    hive_earned     : v5,
                    bees_earned     : v6,
                };
                0x2::event::emit<StreamPointsFinalizedForProfile>(v7);
                0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::deposit_gems_in_profile(arg1, 0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::hive_gems::split(&mut arg0.engagement_scores.hive_gems_available, v5));
                0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg3, arg2, 0x2::balance::split<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut arg0.engagement_scores.bees_available, v6), arg6, arg14);
            };
            if (v0.sui_bidded > 0 && !arg13) {
                let v8 = v0.sui_bidded;
                let v9 = 0x2::balance::split<T0>(&mut arg0.bid_pool, v8);
                let v10 = (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u128((v8 as u128), (arg0.tax_on_bid as u128), (10000 as u128)) as u64);
                0x2::balance::join<T0>(&mut arg0.sui_avail_for_pol, 0x2::balance::split<T0>(&mut v9, v10));
                0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<T0>(v9, arg6, arg14);
                let v11 = UserBidExpired{
                    bidder_profile   : arg4,
                    username         : arg5,
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
            v0.subscription_type = 0;
        };
        v0.points = v0.points + arg7;
        let v12 = 0;
        if (arg8) {
            assert!(!v0.flag, 9863);
            let (v13, v14) = max_addable_to_bid(arg0.cur_auction_stream, arg0.stream_init_ms, 0x2::tx_context::epoch(arg14), arg9, arg10, v0.sui_bidded);
            assert!(arg10 <= v14, 9864);
            v0.sui_bidded = v0.sui_bidded + arg10;
            v0.flag = v13;
            v0.buzz_cost_in_hive = arg11;
            v0.subscription_type = arg12;
            let v15 = BidUpdatedByUser{
                bidder_profile    : arg4,
                username          : arg5,
                bid_amt           : v0.sui_bidded,
                flag              : v0.flag,
                bid_epoch_stream  : v0.stream_epoch,
                buzz_cost_in_hive : v0.buzz_cost_in_hive,
                subscription_type : v0.subscription_type,
            };
            0x2::event::emit<BidUpdatedByUser>(v15);
            v12 = v0.sui_bidded;
        };
        v12
    }

    public fun upvote_hive_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut HiveVault, arg3: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg4: &0x2::token::TokenPolicyCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg6: address, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2) = authority_check(arg3, v0);
        let v3 = 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::entry_borrow_app_from_profile<StreamerBuzzes<T0>>(&arg2.stream_buzz_cap, &mut arg2.streamer_profile, arg9);
        let v4 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, arg7), arg8);
        assert!(!0x2::linked_table::contains<address, HiveBuzz<T0>>(&v4.buzzes, arg6), 9876);
        let v5 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut v4.buzzes, arg6);
        assert!(!0x2::linked_table::contains<address, bool>(&v5.upvotes, v1), 9875);
        0x2::linked_table::push_back<address, bool>(&mut v5.upvotes, v1, true);
        let v6 = UserUpvotedHiveBuzz{
            upvoted_by_profile_addr : v1,
            upvoted_by_username     : v2,
            stream_index            : arg7,
            stream_inner_index      : arg8,
            hive_buzz_by_profile    : arg6,
        };
        0x2::event::emit<UserUpvotedHiveBuzz>(v6);
        update_user_points<T0>(v3, arg3, arg4, arg5, v1, v2, v0, 1000000, false, 0, 0, 0, 0, false, arg9);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::stream_consume_entropy(arg0, arg1, arg3, 1, arg9);
    }

    // decompiled from Move bytecode v6
}

