module 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    struct HiveVault has store, key {
        id: 0x2::object::UID,
        streamer_profile: 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile,
        gems_kraft_cap: 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGemKraftCap,
        hive_kraft_cap: 0x2::coin::TreasuryCap<HIVE>,
        stream_buzz_cap: 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::ProfileDofOwnershipCapability,
        active_supply: u64,
        genesis_ms: u64,
    }

    struct StreamerBuzzes<phantom T0> has store, key {
        id: 0x2::object::UID,
        are_live: bool,
        stream_init_ms: u64,
        streamer_buzzes: 0x2::linked_table::LinkedTable<u64, vector<StreamBuzz<T0>>>,
        streamer_name: 0x1::option::Option<0x1::string::String>,
        streamer_profile: 0x1::option::Option<address>,
        x_for_stream: 0x2::balance::Balance<T0>,
        x_per_buzz: u64,
        buzz_cost_in_hive: u64,
        remaining_buzzes_count: u64,
        cur_epoch_stream: u64,
        bid_by_profiles: 0x2::linked_table::LinkedTable<address, BidInfo>,
        bid_pool: 0x2::balance::Balance<T0>,
        leading_bid: LeadingBidInfo,
        buzzes_count: u64,
        min_bid_limit: u64,
        tax_on_bid: u64,
        x_avail_for_pol: 0x2::balance::Balance<T0>,
        hive_avail_for_pol: 0x2::balance::Balance<HIVE>,
    }

    struct LeadingBidInfo has drop, store {
        profile_addr: 0x1::option::Option<address>,
        username: 0x1::option::Option<0x1::string::String>,
        bid_amt: u64,
        buzz_cost_in_hive: u64,
    }

    struct BidInfo has store {
        bid_amt: u64,
        cur_epoch_stream: u64,
        flag: bool,
        buzz_cost_in_hive: u64,
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
        x_earned: 0x2::balance::Balance<T0>,
        is_choosen: bool,
    }

    struct HiveKraftedForPolDeposit has copy, drop {
        profile: address,
        hive_krafted: u64,
    }

    struct KraftHive has copy, drop {
        user: address,
        hive_krafted: u64,
    }

    struct BurnHive has copy, drop {
        user: address,
        hive_burnt: u64,
    }

    struct StreamBuzzesInitialized has copy, drop {
        are_live: bool,
        min_bid_limit: u64,
        tax_on_bid: u64,
        cur_epoch_stream: u64,
        new_buzzes_count: u64,
    }

    struct NewStreamInitiated has copy, drop {
        streamer_name: 0x1::string::String,
        streamer_profile: address,
        stream_init_ms: u64,
        streaming_from_epoch: u64,
        buzz_cost_in_hive: u64,
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
        bid_amt: u64,
    }

    struct NewStreamBuzzKrafted has copy, drop {
        streamer_name: 0x1::string::String,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
        cur_streaming_epoch: u64,
    }

    struct BuzzChoosenForStream has copy, drop {
        stream_epoch: u64,
        stream_index: u64,
        choosen_buzz_profile: address,
        buzz: 0x1::string::String,
        gen_ai_url: 0x1::option::Option<0x1::string::String>,
    }

    struct HiveBuzzForAStreamBuzzKrafted has copy, drop {
        streamer_profile: address,
        streamed_at_epoch: u64,
        stream_buzz_index: u64,
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
        streamed_at_epoch: u64,
        buzz_index: u64,
    }

    struct UserUnLikedStreamBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        streamed_at_epoch: u64,
        buzz_index: u64,
    }

    public fun add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = authority_check(arg2, 0x2::tx_context::sender(arg6));
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        let v4 = 0x2::tx_context::epoch(arg6);
        let v5 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg6);
        assert!(v5.are_live, 9861);
        assert!(v4 < v5.cur_epoch_stream + 7, 9862);
        let v6 = 0;
        if (0x2::linked_table::contains<address, BidInfo>(&v5.bid_by_profiles, v0)) {
            let BidInfo {
                bid_amt           : v7,
                cur_epoch_stream  : v8,
                flag              : v9,
                buzz_cost_in_hive : _,
            } = 0x2::linked_table::remove<address, BidInfo>(&mut v5.bid_by_profiles, v0);
            if (v8 < v5.cur_epoch_stream) {
                let v11 = 0x2::balance::split<T0>(&mut v5.bid_pool, v7);
                let v12 = (0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::math::mul_div_u128((v7 as u128), (v5.tax_on_bid as u128), (10000 as u128)) as u64);
                0x2::balance::join<T0>(&mut v5.x_avail_for_pol, 0x2::balance::split<T0>(&mut v11, v12));
                0x2::balance::join<T0>(&mut v2, v11);
                let v13 = UserBidExpired{
                    bidder_profile   : v0,
                    username         : v1,
                    bid_amt          : v7,
                    tax_on_bid       : v12,
                    bid_epoch_stream : v8,
                };
                0x2::event::emit<UserBidExpired>(v13);
            } else {
                assert!(!v9, 9863);
                let (v14, v15) = max_addable_to_bid<T0>(v5, v4, 0x2::clock::timestamp_ms(arg0), arg4, v7);
                assert!(arg4 <= v15, 9864);
                let v16 = BidInfo{
                    bid_amt           : v7 + arg4,
                    cur_epoch_stream  : v5.cur_epoch_stream,
                    flag              : v14,
                    buzz_cost_in_hive : arg5,
                };
                v6 = v7;
                let v17 = BidUpdatedByUser{
                    bidder_profile    : v0,
                    username          : v1,
                    bid_amt           : v16.bid_amt,
                    flag              : v16.flag,
                    bid_epoch_stream  : v16.cur_epoch_stream,
                    buzz_cost_in_hive : arg5,
                };
                0x2::event::emit<BidUpdatedByUser>(v17);
                0x2::linked_table::push_back<address, BidInfo>(&mut v5.bid_by_profiles, v0, v16);
            };
        };
        if (v6 == 0) {
            assert!(v4 < v5.cur_epoch_stream + 5, 9864);
            let v18 = BidInfo{
                bid_amt           : arg4,
                cur_epoch_stream  : v5.cur_epoch_stream,
                flag              : false,
                buzz_cost_in_hive : arg5,
            };
            let v19 = BidUpdatedByUser{
                bidder_profile    : v0,
                username          : v1,
                bid_amt           : v18.bid_amt,
                flag              : v18.flag,
                bid_epoch_stream  : v18.cur_epoch_stream,
                buzz_cost_in_hive : arg5,
            };
            0x2::event::emit<BidUpdatedByUser>(v19);
            0x2::linked_table::push_back<address, BidInfo>(&mut v5.bid_by_profiles, v0, v18);
        };
        let v20 = 0x2::linked_table::borrow<address, BidInfo>(&v5.bid_by_profiles, v0);
        if (0x1::option::is_some<address>(&v5.streamer_profile)) {
            if (v20.bid_amt > v5.leading_bid.bid_amt) {
                v5.leading_bid.profile_addr = 0x1::option::some<address>(v0);
                v5.leading_bid.username = 0x1::option::some<0x1::string::String>(v1);
                v5.leading_bid.bid_amt = v20.bid_amt;
                v5.leading_bid.buzz_cost_in_hive = arg5;
                let v21 = NewLeadingBid{
                    bidder   : v0,
                    username : v1,
                    bid_amt  : v20.bid_amt,
                };
                0x2::event::emit<NewLeadingBid>(v21);
            };
        } else if (v20.bid_amt > v5.min_bid_limit) {
            let v22 = LeadingBidInfo{
                profile_addr      : 0x1::option::some<address>(v0),
                username          : 0x1::option::some<0x1::string::String>(v1),
                bid_amt           : v20.bid_amt,
                buzz_cost_in_hive : v20.buzz_cost_in_hive,
            };
            v5.leading_bid = v22;
        };
        0x2::balance::join<T0>(&mut v5.bid_pool, 0x2::balance::split<T0>(&mut v3, arg4));
        0x2::balance::join<T0>(&mut v2, v3);
        v2
    }

    public entry fun add_to_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg2, 0x2::tx_context::sender(arg5));
        buzz_check(arg3, arg4);
        let v2 = 0x2::tx_context::epoch(arg5);
        let v3 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg5);
        assert!(v0 == *0x1::option::borrow<address>(&v3.streamer_profile), 9873);
        let v4 = StreamBuzz<T0>{
            timestamp  : 0x2::clock::timestamp_ms(arg0),
            buzz       : arg3,
            gen_ai_url : arg4,
            likes      : 0x2::linked_table::new<address, bool>(arg5),
            buzzes     : 0x2::linked_table::new<address, HiveBuzz<T0>>(arg5),
        };
        let v5 = NewStreamBuzzKrafted{
            streamer_name       : v1,
            buzz                : arg3,
            gen_ai_url          : arg4,
            cur_streaming_epoch : v2,
        };
        0x2::event::emit<NewStreamBuzzKrafted>(v5);
        if (!0x2::linked_table::contains<u64, vector<StreamBuzz<T0>>>(&v3.streamer_buzzes, v2)) {
            let v6 = 0x1::vector::empty<StreamBuzz<T0>>();
            0x1::vector::push_back<StreamBuzz<T0>>(&mut v6, v4);
            0x2::linked_table::push_back<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, v2, v6);
        } else {
            let v7 = 0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v3.streamer_buzzes, v2);
            0x1::vector::push_back<StreamBuzz<T0>>(v7, v4);
            assert!(0x1::vector::length<StreamBuzz<T0>>(v7) <= 42, 9866);
        };
    }

    fun authority_check(arg0: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg1: address) : (address, 0x1::string::String) {
        let (v0, v1, v2, v3) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(arg0);
        if (!v2) {
            assert!(v3 == arg1, 9873);
        };
        (v0, v1)
    }

    public fun burn_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: 0x2::balance::Balance<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        let (v0, _, _, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(&arg0.streamer_profile);
        let (v4, _, _, _, _, _, _, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_following_subscription_info(arg1, v0);
        if (!v4) {
            0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::make_forever_follower(arg0.genesis_ms, arg1, &mut arg0.streamer_profile);
        };
        let v12 = 0x2::tx_context::sender(arg4);
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::deposit_gems_in_profile(arg1, burn_hive_and_return_gems(arg0, 0x2::balance::split<HIVE>(&mut arg2, arg3), v12, arg4));
        arg2
    }

    public fun burn_hive_and_return_gems(arg0: &mut HiveVault, arg1: 0x2::balance::Balance<HIVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGems {
        let v0 = 0x2::balance::value<HIVE>(&arg1);
        let v1 = BurnHive{
            user       : arg2,
            hive_burnt : v0,
        };
        0x2::event::emit<BurnHive>(v1);
        arg0.active_supply = arg0.active_supply - v0;
        0x2::coin::burn<HIVE>(&mut arg0.hive_kraft_cap, 0x2::coin::from_balance<HIVE>(arg1, arg3));
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::withdraw_gems_from_profile(&mut arg0.streamer_profile, v0, arg3)
    }

    public entry fun burn_hive_for_gems(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: 0x2::coin::Coin<HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_hive_and_return(arg0, arg1, 0x2::coin::into_balance<HIVE>(arg2), arg3, arg4);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    fun buzz_check(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>) {
        assert!(0x1::string::length(&arg0) < 510, 9870);
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v0 = *0x1::option::borrow<0x1::string::String>(&arg1);
            assert!(0x1::string::length(&v0) < 240, 9869);
        };
    }

    public fun choose_buzzes_for_stream<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg5));
        let v2 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg5);
        assert!(v0 == *0x1::option::borrow<address>(&v2.streamer_profile), 9862);
        assert!(arg2 >= v2.cur_epoch_stream, 9863);
        let v3 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v2.streamer_buzzes, arg2), arg3).buzzes, arg4);
        assert!(!v3.is_choosen, 9864);
        assert!(v2.remaining_buzzes_count > 0, 9865);
        let v4 = BuzzChoosenForStream{
            stream_epoch         : arg2,
            stream_index         : arg3,
            choosen_buzz_profile : arg4,
            buzz                 : v3.buzz,
            gen_ai_url           : v3.gen_ai_url,
        };
        0x2::event::emit<BuzzChoosenForStream>(v4);
        0x2::balance::join<T0>(&mut v3.x_earned, 0x2::balance::split<T0>(&mut v2.x_for_stream, v2.x_per_buzz));
        v2.remaining_buzzes_count = v2.remaining_buzzes_count - 1;
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveVault, arg1: &mut 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_gems_for_hive_and_return(arg0, arg1, arg2, arg3);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_gems_for_hive_and_return(arg0: &mut HiveVault, arg1: &mut 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGems, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        kraft_hive(arg0, 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::split(arg1, arg2), arg2, 0x2::tx_context::sender(arg3))
    }

    public entry fun deposit_gems_via_profile(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_gems_via_profile_and_return(arg0, arg1, arg2, arg3);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<HIVE>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_gems_via_profile_and_return(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<HIVE> {
        let (v0, _, _, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(&arg0.streamer_profile);
        let (v4, _, _, _, _, _, _, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_following_subscription_info(arg1, v0);
        if (!v4) {
            0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::make_forever_follower(arg0.genesis_ms, arg1, &mut arg0.streamer_profile);
        };
        kraft_hive(arg0, 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::withdraw_gems_from_profile(arg1, arg2, arg3), arg2, 0x2::tx_context::sender(arg3))
    }

    public entry fun entry_add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = add_bid_for_streamer_buzzes<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_return_expired_bid<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(arg1);
        assert!(!v2, 9865);
        let v4 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg2);
        let v5 = return_expired_bid<T0>(v4, arg1, v0, v1, arg2);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<T0>(v5, 0x2::tx_context::sender(arg2), arg2);
    }

    public fun get_active_hive_supply(arg0: &HiveVault) : u64 {
        arg0.active_supply
    }

    public fun get_bid_for_profile_info<T0>(arg0: &HiveVault, arg1: address) : (u64, u64, bool, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        if (0x2::linked_table::contains<address, BidInfo>(&v0.bid_by_profiles, arg1)) {
            let v5 = 0x2::linked_table::borrow<address, BidInfo>(&v0.bid_by_profiles, arg1);
            (v5.bid_amt, v5.cur_epoch_stream, v5.flag, v5.buzz_cost_in_hive)
        } else {
            (0, 0, false, 0)
        }
    }

    public fun get_current_streamer_info<T0>(arg0: &HiveVault) : (bool, u64, u64, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<address>, u64, u64, u64, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.are_live, v0.cur_epoch_stream, v0.stream_init_ms, v0.streamer_name, v0.streamer_profile, 0x2::balance::value<T0>(&v0.x_for_stream), v0.x_per_buzz, v0.buzz_cost_in_hive, v0.remaining_buzzes_count)
    }

    public fun get_dao_hiveprofile_info(arg0: &HiveVault) : (0x1::string::String, u64, 0x1::string::String, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let (v0, v1, v2, _, v4, v5, v6, v7, v8, v9, v10) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_info(&arg0.streamer_profile);
        (v0, v1, v2, v4, v5, v6, v7, v8, v9, v10)
    }

    public fun get_hive_buzz_for_user_for_stream<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : (0x1::string::String, 0x1::option::Option<0x1::string::String>, bool, u64) {
        let v0 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg2), arg3);
        if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v0.buzzes, arg1)) {
            let v5 = 0x2::linked_table::borrow<address, HiveBuzz<T0>>(&v0.buzzes, arg1);
            (v5.buzz, v5.gen_ai_url, v5.is_choosen, 0x2::balance::value<T0>(&v5.x_earned))
        } else {
            (0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), false, 0)
        }
    }

    public fun get_leading_bid_info<T0>(arg0: &HiveVault) : (0x1::option::Option<address>, 0x1::option::Option<0x1::string::String>, u64, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.leading_bid.profile_addr, v0.leading_bid.username, v0.leading_bid.bid_amt, v0.leading_bid.buzz_cost_in_hive)
    }

    public fun get_stream_info_for_epoch<T0>(arg0: &HiveVault, arg1: u64) : (u64, u64, 0x1::string::String, 0x1::option::Option<0x1::string::String>, u64, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        if (0x2::linked_table::contains<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1)) {
            let v7 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&v0.streamer_buzzes, arg1);
            let v8 = 0x1::vector::borrow<StreamBuzz<T0>>(v7, 0);
            (0x1::vector::length<StreamBuzz<T0>>(v7), v8.timestamp, v8.buzz, v8.gen_ai_url, 0x2::linked_table::length<address, bool>(&v8.likes), 0x2::linked_table::length<address, HiveBuzz<T0>>(&v8.buzzes))
        } else {
            (0, 0, 0x1::string::utf8(b""), 0x1::option::none<0x1::string::String>(), 0, 0)
        }
    }

    public fun get_streamer_buzzes_params<T0>(arg0: &HiveVault) : (bool, u64, u64, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (v0.are_live, v0.buzzes_count, v0.min_bid_limit, v0.tax_on_bid)
    }

    public fun get_streamer_pol_info<T0>(arg0: &HiveVault) : (u64, u64, u64) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        (0x2::balance::value<T0>(&v0.bid_pool), 0x2::balance::value<T0>(&v0.x_avail_for_pol), 0x2::balance::value<HIVE>(&v0.hive_avail_for_pol))
    }

    public fun has_user_liked<T0>(arg0: &HiveVault, arg1: address, arg2: u64, arg3: u64) : bool {
        0x2::linked_table::contains<address, bool>(&0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg2), arg3).likes, arg1)
    }

    public entry fun increment_stream<T0>(arg0: &0x2::clock::Clock, arg1: &mut HiveVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg2);
        assert!(v2.are_live, 9861);
        assert!(v0 >= v2.cur_epoch_stream + 7, 9867);
        0x2::balance::join<T0>(&mut v2.x_avail_for_pol, 0x2::balance::withdraw_all<T0>(&mut v2.x_for_stream));
        v2.cur_epoch_stream = v0;
        v2.stream_init_ms = v1;
        if (v2.leading_bid.bid_amt >= v2.min_bid_limit) {
            v2.streamer_name = 0x1::option::some<0x1::string::String>(0x1::option::extract<0x1::string::String>(&mut v2.leading_bid.username));
            v2.streamer_profile = 0x1::option::some<address>(0x1::option::extract<address>(&mut v2.leading_bid.profile_addr));
            v2.buzz_cost_in_hive = v2.leading_bid.buzz_cost_in_hive;
            let v3 = v2.leading_bid.bid_amt;
            let v4 = 0x2::balance::split<T0>(&mut v2.bid_pool, v3);
            0x2::balance::join<T0>(&mut v2.x_avail_for_pol, 0x2::balance::split<T0>(&mut v4, v3 * 7000 / 10000));
            0x2::balance::join<T0>(&mut v2.x_for_stream, 0x2::balance::withdraw_all<T0>(&mut v4));
            v2.x_per_buzz = 0x2::balance::value<T0>(&v2.x_for_stream) / v2.buzzes_count;
            0x2::balance::destroy_zero<T0>(v4);
            let v5 = NewStreamInitiated{
                streamer_name        : *0x1::option::borrow<0x1::string::String>(&mut v2.streamer_name),
                streamer_profile     : *0x1::option::borrow<address>(&mut v2.streamer_profile),
                stream_init_ms       : v2.stream_init_ms,
                streaming_from_epoch : v2.cur_epoch_stream,
                buzz_cost_in_hive    : v2.buzz_cost_in_hive,
            };
            0x2::event::emit<NewStreamInitiated>(v5);
        } else {
            v2.streamer_name = 0x1::option::none<0x1::string::String>();
            v2.streamer_profile = 0x1::option::none<address>();
            let v6 = NewStreamerNotFound{
                stream_init_ms       : v1,
                streaming_from_epoch : v2.cur_epoch_stream,
            };
            0x2::event::emit<NewStreamerNotFound>(v6);
        };
        v2.leading_bid.profile_addr = 0x1::option::none<address>();
        v2.leading_bid.username = 0x1::option::none<0x1::string::String>();
        v2.leading_bid.bid_amt = 0;
        v2.leading_bid.buzz_cost_in_hive = 0;
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HIVE", x"484956452047454d53206172652074686520696e2d67616d652063757272656e637920616e642067656f7665726e616e636520746f6b656e20666f7220446567656e4869766527732070726f6772616d6d61626c652d6964656e7469747920284869766550726f66696c65292064726976656e206f70656e2d686976652e200a2048495645206973206b726166746564206f6e206120313a3120626173697320616761696e737420484956452047454d5320616e6420656e61626c657320757365727320746f207472616465206974206f6e20446567656e486976652044455820616e6420636f6d706f73652077697468206f746865722070726f746f636f6c73206f6e2d746f70206f6620535549206e6574776f726b2e", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_hive_vault<T0>(arg0: &mut 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb7a7f7de01f94d9c33c533099b89e340657edfc5ba485dadace5f0f64fe23ae2::hsui_vault::HSuiVault, arg4: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfileMappingStore, arg5: 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGemKraftCap, arg6: 0x2::coin::TreasuryCap<HIVE>, arg7: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveManager, arg8: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HSuiDisperser<0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::friend_kraft_dof_access_cap(arg4, 0x1::ascii::string(b"STREAMER_BUZZES"), true, true, true, arg10);
        let v1 = 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::kraft_hive_gems(&mut arg5, 1000000000000000);
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::deposit_gems_with_manager_profile(arg7, 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::split(&mut v1, 7000000000000));
        let (v2, v3) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::kraft_owned_hive_profile(arg1, arg2, arg3, arg4, arg7, arg8, arg9, 0x1::string::utf8(b"StreamBuzz"), 0x1::string::utf8(x"4c61756e636820796f75722073686f7720776974682053747265616d42757a7a2c20616e6420696e746572616374207769746820796f757220636f6d6d756e69747920766961204869766542757a7a657321200a353025206f6620796f757220555344432062696420697320636f6e7665727469626c6520746f20484956452d55534443204c5020746f6b656e7320746f206265206275726e7420666f726576657220776974682072656d61696e696e6720746f20626520646973746972627574656420746f2063686f6f73656e204869766542757a7a657321"), arg10);
        let v4 = v2;
        let v5 = LeadingBidInfo{
            profile_addr      : 0x1::option::none<address>(),
            username          : 0x1::option::none<0x1::string::String>(),
            bid_amt           : 0,
            buzz_cost_in_hive : 0,
        };
        let v6 = StreamerBuzzes<T0>{
            id                     : 0x2::object::new(arg10),
            are_live               : false,
            stream_init_ms         : 0,
            streamer_buzzes        : 0x2::linked_table::new<u64, vector<StreamBuzz<T0>>>(arg10),
            streamer_name          : 0x1::option::none<0x1::string::String>(),
            streamer_profile       : 0x1::option::none<address>(),
            x_for_stream           : 0x2::balance::zero<T0>(),
            x_per_buzz             : 0,
            buzz_cost_in_hive      : 0,
            remaining_buzzes_count : 0,
            cur_epoch_stream       : 0,
            bid_by_profiles        : 0x2::linked_table::new<address, BidInfo>(arg10),
            bid_pool               : 0x2::balance::zero<T0>(),
            leading_bid            : v5,
            buzzes_count           : 100,
            min_bid_limit          : 420000000,
            tax_on_bid             : 0,
            x_avail_for_pol        : 0x2::balance::zero<T0>(),
            hive_avail_for_pol     : 0x2::balance::zero<HIVE>(),
        };
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_add_to_profile<StreamerBuzzes<T0>>(&v0, &mut v4, v6, arg10);
        let v7 = HiveVault{
            id               : 0x2::object::new(arg10),
            streamer_profile : v4,
            gems_kraft_cap   : arg5,
            hive_kraft_cap   : arg6,
            stream_buzz_cap  : v0,
            active_supply    : 0,
            genesis_ms       : 0x2::clock::timestamp_ms(arg1),
        };
        let v8 = &mut v7;
        let v9 = &mut v1;
        let v10 = deposit_gems_for_hive_and_return(v8, v9, 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::value(&v1), arg10);
        0x2::transfer::share_object<HiveVault>(v7);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::destroy_zero(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIVE>>(0x2::coin::from_balance<HIVE>(v10, arg10), 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg10), 0x2::tx_context::sender(arg10));
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::config::vault_setup_by_deployer(arg0);
    }

    public entry fun interact_with_stream_buzz<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg1, 0x2::tx_context::sender(arg7));
        let (v2, _, _, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(arg2);
        buzz_check(arg5, arg6);
        let v6 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        assert!(v2 == *0x1::option::borrow<address>(&v6.streamer_profile), 9871);
        let v7 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::withdraw_gems_from_profile(arg1, v6.buzz_cost_in_hive, arg7);
        let v8 = v6.buzz_cost_in_hive / 2;
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::deposit_gems_in_profile(arg2, 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::split(&mut v7, v8));
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::make_forever_follower(v6.stream_init_ms, arg1, arg2);
        let v9 = HiveKraftedForPolDeposit{
            profile      : v0,
            hive_krafted : 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::value(&v7),
        };
        0x2::event::emit<HiveKraftedForPolDeposit>(v9);
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::deposit_gems_in_profile(&mut arg0.streamer_profile, v7);
        let v10 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg7);
        0x2::balance::join<HIVE>(&mut v10.hive_avail_for_pol, 0x2::coin::mint_balance<HIVE>(&mut arg0.hive_kraft_cap, 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::value(&v7)));
        let v11 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut v10.streamer_buzzes, arg3), arg4);
        let v12 = HiveBuzzForAStreamBuzzKrafted{
            streamer_profile          : v2,
            streamed_at_epoch         : arg3,
            stream_buzz_index         : arg4,
            user_profile              : v0,
            username                  : v1,
            user_buzz                 : arg5,
            gen_ai_url                : arg6,
            hive_streamed_to_streamer : v8,
            hive_streamed_to_pol      : 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::value(&v7),
        };
        0x2::event::emit<HiveBuzzForAStreamBuzzKrafted>(v12);
        let v13 = if (0x2::linked_table::contains<address, HiveBuzz<T0>>(&v11.buzzes, v0)) {
            let v13 = 0x2::linked_table::remove<address, HiveBuzz<T0>>(&mut v11.buzzes, v0);
            assert!(!v13.is_choosen, 9868);
            v13.buzz = arg5;
            v13.gen_ai_url = arg6;
            v13
        } else {
            HiveBuzz<T0>{buzz: arg5, gen_ai_url: arg6, x_earned: 0x2::balance::zero<T0>(), is_choosen: false}
        };
        0x2::linked_table::push_back<address, HiveBuzz<T0>>(&mut v11.buzzes, v0, v13);
    }

    fun kraft_hive(arg0: &mut HiveVault, arg1: 0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::HiveGems, arg2: u64, arg3: address) : 0x2::balance::Balance<HIVE> {
        assert!(0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::hive_gems::value(&arg1) == arg2, 9876);
        0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::deposit_gems_in_profile(&mut arg0.streamer_profile, arg1);
        let v0 = KraftHive{
            user         : arg3,
            hive_krafted : arg2,
        };
        0x2::event::emit<KraftHive>(v0);
        arg0.active_supply = arg0.active_supply + arg2;
        0x2::coin::mint_balance<HIVE>(&mut arg0.hive_kraft_cap, arg2)
    }

    public fun like_stream_buzz<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg4).streamer_buzzes, arg2), arg3);
        assert!(!0x2::linked_table::contains<address, bool>(&v2.likes, v0), 9872);
        let v3 = UserLikedStreamBuzz{
            user_profile_addr : v0,
            username          : v1,
            streamed_at_epoch : arg2,
            buzz_index        : arg3,
        };
        0x2::event::emit<UserLikedStreamBuzz>(v3);
        0x2::linked_table::push_back<address, bool>(&mut v2.likes, v0, true);
    }

    fun max_addable_to_bid<T0>(arg0: &StreamerBuzzes<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (bool, u64) {
        if (arg1 < arg0.cur_epoch_stream + 5) {
            return (false, arg3)
        };
        if (arg4 == 0) {
            return (false, 0)
        };
        (true, (0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::math::mul_div_u256((arg4 as u256), ((arg0.stream_init_ms + 7 * 86400000 - arg2) as u256), ((2 * 86400000) as u256)) as u64))
    }

    public fun query_across_all_bids<T0>(arg0: &HiveVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES"));
        let v6 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, BidInfo>(&v5.bid_by_profiles)
        };
        let v7 = v6;
        let v8 = 0;
        while (0x1::option::is_some<address>(&v7) && v8 < arg2) {
            let v9 = *0x1::option::borrow<address>(&v7);
            let v10 = 0x2::linked_table::borrow<address, BidInfo>(&v5.bid_by_profiles, v9);
            0x1::vector::push_back<address>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v1, v10.bid_amt);
            0x1::vector::push_back<u64>(&mut v2, v10.cur_epoch_stream);
            0x1::vector::push_back<bool>(&mut v3, v10.flag);
            0x1::vector::push_back<u64>(&mut v4, v10.buzz_cost_in_hive);
            v7 = *0x2::linked_table::next<address, BidInfo>(&v5.bid_by_profiles, v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, 0x2::linked_table::length<address, BidInfo>(&v5.bid_by_profiles))
    }

    public fun query_across_buzzes_for_stream<T0>(arg0: &HiveVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<bool>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1), arg2);
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
            0x1::vector::push_back<u64>(&mut v4, 0x2::balance::value<T0>(&v10.x_earned));
            v7 = *0x2::linked_table::next<address, bool>(&v5.likes, v9);
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, 0x2::linked_table::length<address, HiveBuzz<T0>>(&v5.buzzes))
    }

    public fun query_across_likes<T0>(arg0: &HiveVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::borrow<StreamBuzz<T0>>(0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1), arg2);
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

    public fun query_across_streams_for_epoch<T0>(arg0: &HiveVault, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<u64>, vector<0x1::string::String>, vector<0x1::string::String>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x2::linked_table::borrow<u64, vector<StreamBuzz<T0>>>(&0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::borrow_from_profile<StreamerBuzzes<T0>>(&arg0.streamer_profile, 0x1::ascii::string(b"STREAMER_BUZZES")).streamer_buzzes, arg1);
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

    public fun retrieve_x_from_buzz<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::linked_table::borrow_mut<address, HiveBuzz<T0>>(&mut 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg4).streamer_buzzes, arg2), arg3).buzzes, v0);
        assert!(v2.is_choosen, 9861);
        0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::coin_helper::destroy_or_transfer_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v2.x_earned), 0x2::tx_context::sender(arg4), arg4);
    }

    fun return_expired_bid<T0>(arg0: &mut StreamerBuzzes<T0>, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (_, _) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x2::linked_table::remove<address, BidInfo>(&mut arg0.bid_by_profiles, arg2);
        if (arg0.are_live) {
            assert!(arg0.cur_epoch_stream > v2.cur_epoch_stream, 9860);
        };
        let BidInfo {
            bid_amt           : v3,
            cur_epoch_stream  : v4,
            flag              : _,
            buzz_cost_in_hive : _,
        } = v2;
        let v7 = 0x2::balance::split<T0>(&mut arg0.bid_pool, v3);
        let v8 = (0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::math::mul_div_u128((v3 as u128), (arg0.tax_on_bid as u128), (10000 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg0.x_avail_for_pol, 0x2::balance::split<T0>(&mut v7, v8));
        let v9 = UserBidExpired{
            bidder_profile   : arg2,
            username         : arg3,
            bid_amt          : v3,
            tax_on_bid       : v8,
            bid_epoch_stream : v4,
        };
        0x2::event::emit<UserBidExpired>(v9);
        v7
    }

    public fun return_expired_bid_comp_profile<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2, _) = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::get_profile_meta_info(arg1);
        assert!(v2, 9866);
        let v4 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg2);
        return_expired_bid<T0>(v4, arg1, v0, v1, arg2)
    }

    public fun transfer_pol<T0>(arg0: &0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::config::TwoAmmFeeClaimCapability, arg1: &mut HiveVault, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<HIVE>) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg2);
        (0x2::balance::withdraw_all<T0>(&mut v0.x_avail_for_pol), 0x2::balance::withdraw_all<HIVE>(&mut v0.hive_avail_for_pol))
    }

    public fun unlike_stream_buzz<T0>(arg0: &mut HiveVault, arg1: &mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v2 = 0x1::vector::borrow_mut<StreamBuzz<T0>>(0x2::linked_table::borrow_mut<u64, vector<StreamBuzz<T0>>>(&mut 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg0.stream_buzz_cap, &mut arg0.streamer_profile, arg4).streamer_buzzes, arg2), arg3);
        assert!(0x2::linked_table::contains<address, bool>(&v2.likes, v0), 9871);
        let v3 = UserUnLikedStreamBuzz{
            user_profile_addr : v0,
            username          : v1,
            streamed_at_epoch : arg2,
            buzz_index        : arg3,
        };
        0x2::event::emit<UserUnLikedStreamBuzz>(v3);
        0x2::linked_table::remove<address, bool>(&mut v2.likes, v0);
    }

    public fun update_streamer_buzzes<T0>(arg0: &0x69ffbad527405cb0feba0a0ec66a65f47e6bfd33db71621ed34758c3df715a19::config::HiveDaoCapability, arg1: &mut HiveVault, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x54798d94f8314cc8e9f5d4bb810004bd46d766757516e9e249337bb6d7515a40::hive_profile::entry_borrow_mut_from_profile<StreamerBuzzes<T0>>(&arg1.stream_buzz_cap, &mut arg1.streamer_profile, arg6);
        v0.are_live = arg2;
        if (!v0.are_live && arg2) {
            v0.cur_epoch_stream = 0x2::tx_context::epoch(arg6) + 1;
        };
        if (arg4 > 0) {
            assert!(arg4 > 420000000, 9877);
            v0.min_bid_limit = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 < 500, 9875);
            v0.tax_on_bid = arg5;
        };
        if (arg3 > 0) {
            assert!(arg3 <= 100000, 9869);
            assert!(arg3 > 51, 9870);
            v0.buzzes_count = arg3;
        };
        let v1 = StreamBuzzesInitialized{
            are_live         : v0.are_live,
            min_bid_limit    : v0.min_bid_limit,
            tax_on_bid       : v0.tax_on_bid,
            cur_epoch_stream : v0.cur_epoch_stream,
            new_buzzes_count : v0.buzzes_count,
        };
        0x2::event::emit<StreamBuzzesInitialized>(v1);
    }

    // decompiled from Move bytecode v6
}

