module 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::bee_trade {
    struct BeesManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        bee_kraft_cap: 0x2::coin::TreasuryCap<T0>,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
        available_bees: 0x2::balance::Balance<T0>,
        bee_for_engagement_per_epoch: u64,
        last_claim_epoch: u64,
        total_burnt: u64,
        module_version: u64,
    }

    struct BeesBurnt has copy, drop {
        bees_burnt: u64,
    }

    struct BeesForEngagementPerEpochUpdated has copy, drop {
        bee_for_engagement_per_epoch: u64,
    }

    public fun add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg3: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg5: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: u8, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::add_bid_for_streamer_buzzes<T0>(arg0, arg1, arg2, &arg3.policy_cap, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun claim_stream_rewards_withdraw_bid<T0>(arg0: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg1: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg2: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg3: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::claim_stream_rewards_withdraw_bid<T0>(arg0, arg1, arg2, &arg3.policy_cap, arg4, arg5);
    }

    public fun increment_stream_part_2<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg3: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg4: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg5: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg6: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg7: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::increment_stream_part_2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6.policy_cap, arg7, arg8);
    }

    public fun interact_with_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveManager, arg3: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg4: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg6: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveDisperser, arg7: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg8: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::interact_with_stream_buzz<T0>(arg0, arg1, arg2, arg3, &arg4.policy_cap, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun like_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveManager, arg3: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg4: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg6: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::like_stream_buzz<T0>(arg0, arg1, arg2, arg3, &arg4.policy_cap, arg5, arg6, arg7, arg8, arg9);
    }

    public fun upvote_hive_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveManager, arg3: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg4: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg5: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg6: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg7: address, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.module_version == 0, 5036);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::upvote_hive_buzz<T0>(arg0, arg1, arg2, arg3, arg4, &arg5.policy_cap, arg6, arg7, arg8, arg9, arg10);
    }

    public fun add_liquidity_to_x_bee_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::token::Token<T1>, arg4: u64, arg5: u64, arg6: &BeesManager<T1>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6.module_version == 0, 5036);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees<T1>(&mut arg3, &arg6.policy_cap, arg7, 0x2::token::value<T1>(&arg3), 0x2::tx_context::sender(arg8), arg8);
        0x2::token::destroy_zero<T1>(arg3);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::coin_helper::destroy_or_transfer_balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>(0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::unwrap_bee_tokens_to_coins<T1>(&mut arg3, &arg6.policy_cap, arg7, arg4, arg8)), arg5), 0x2::tx_context::sender(arg8), arg8);
    }

    public fun add_liquidity_to_x_bee_pool_and_return_lp<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::token::Token<T1>, arg4: u64, arg5: u64, arg6: &BeesManager<T1>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>> {
        assert!(arg6.module_version == 0, 5036);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees<T1>(&mut arg3, &arg6.policy_cap, arg7, 0x2::token::value<T1>(&arg3), 0x2::tx_context::sender(arg8), arg8);
        0x2::token::destroy_zero<T1>(arg3);
        0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::unwrap_bee_tokens_to_coins<T1>(&mut arg3, &arg6.policy_cap, arg7, arg4, arg8)), arg5)
    }

    public fun burn_bees_from_supply(arg0: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg1: &mut BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.module_version == 0, 5036);
        let v0 = 0x2::token::spent_balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(arg0);
        arg1.total_burnt = arg1.total_burnt + v0;
        0x2::token::flush<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(arg0, &mut arg1.bee_kraft_cap, arg2);
        let v1 = BeesBurnt{bees_burnt: v0};
        0x2::event::emit<BeesBurnt>(v1);
        v0
    }

    public fun claim_bees_for_chronicle_farming(arg0: &0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::config::HiveEntryCap, arg1: &mut BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE> {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 <= arg1.last_claim_epoch) {
            return 0x2::balance::zero<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>()
        };
        arg1.last_claim_epoch = v0;
        0x2::balance::split<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut arg1.available_bees, 0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::math::min_u64(0x2::balance::value<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&arg1.available_bees), arg1.bee_for_engagement_per_epoch))
    }

    public entry fun increment_bees_manager<T0>(arg0: &mut BeesManager<T0>) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    public fun interact_with_stream_buzz_no_url<T0>(arg0: &0x2::clock::Clock, arg1: &0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfileMappingStore, arg2: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveManager, arg3: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg4: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg6: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveDisperser, arg7: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg8: &mut 0x2fa52364ba8a9b88e01454d5e93dd95b677b3967b668d25dfac17291f032b3a8::hive_profile::HiveProfile, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        interact_with_stream_buzz<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x1::option::none<0x1::string::String>(), arg12);
    }

    public fun kraft_genesis_bees<T0>(arg0: &mut 0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::HiveVault, arg1: 0x2::coin::TreasuryCap<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE> {
        let v0 = 0x2::coin::into_balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(0x2::coin::mint<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut arg1, 0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::total_bee_supply(), arg2));
        let (v1, v2) = 0x2::token::new_policy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::set_rules<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut v4, &v3, arg2);
        0x2::token::share_policy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(v4);
        0xd8aa34067ce99e2ea4acf6cd84526c3acdc7df49cc7673a9faa7a1aa70e1ec7::hive::add_bees_for_streaming_incentives<T0>(arg0, 0x2::balance::split<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut v0, (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::math::mul_div_u128((0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::total_bee_supply() as u128), (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::bees_for_streambuzz_profile_pct() as u128), (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::percent_precision() as u128)) as u64)), arg2);
        let v5 = BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>{
            id                           : 0x2::object::new(arg2),
            bee_kraft_cap                : arg1,
            policy_cap                   : v3,
            available_bees               : 0x2::balance::split<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut v0, (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::math::mul_div_u128((0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::total_bee_supply() as u128), (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::bees_for_treasury_pct() as u128), (0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::constants::percent_precision() as u128)) as u64)),
            bee_for_engagement_per_epoch : 0,
            last_claim_epoch             : 0,
            total_burnt                  : 0,
            module_version               : 0,
        };
        0x2::transfer::share_object<BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>>(v5);
        v0
    }

    public fun remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::token::TokenPolicy<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::token::Token<T1>, 0x2::balance::Balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>) {
        let (v0, v1, v2) = 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v3, v4) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg7), arg7);
        let v5 = v4;
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::verify<T1>(arg6, &mut v5, arg7);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, v5, arg7);
        (v0, v3, v2)
    }

    public fun remove_liquidity_from_x_bee_pool_and_return<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &BeesManager<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.module_version == 0, 5036);
        let v0 = 0x2::coin::into_balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>(arg2);
        let (v1, v2, v3) = 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0, arg1, 0x2::balance::split<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>(&mut v0, arg3), arg4, arg5, arg6);
        0x2::balance::join<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>(&mut v0, v3);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg9), arg9);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::coin_helper::destroy_or_transfer_balance<0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg9), arg9);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees_balance<T1>(arg7, &arg8.policy_cap, v2, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun swap_bee_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: 0x2::token::Token<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &BeesManager<T1>, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9.module_version == 0, 5036);
        let (v0, v1) = 0x2605c976ac3e751299e9f4925644303703c88f4b966516d94acb2c5cb2bfbf08::two_pool::swap_bee_coins<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, arg3), arg4, 0x2::coin::into_balance<T1>(0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::unwrap_bee_tokens_to_coins<T1>(&mut arg5, &arg9.policy_cap, arg10, arg6, arg11)), arg7, arg8);
        0x2::balance::join<T0>(&mut arg2, v0);
        let (v2, v3) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v4 = v3;
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::verify<T1>(arg10, &mut v4, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v4, arg11);
        0x2::token::join<T1>(&mut arg5, v2);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees<T1>(&mut arg5, &arg9.policy_cap, arg10, 0x2::token::value<T1>(&arg5), 0x2::tx_context::sender(arg11), arg11);
        0x2::token::destroy_zero<T1>(arg5);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::coin_helper::destroy_or_transfer_balance<T0>(arg2, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun transfer_bees(arg0: &mut 0x2::token::Token<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg1: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(arg0, &arg1.policy_cap, arg2, arg3, arg4, arg5);
    }

    public fun transfer_bees_balance(arg0: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg1: &BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: 0x2::balance::Balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees_balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(arg0, &arg1.policy_cap, arg2, arg3, arg4);
    }

    public fun transfer_bees_from_treasury(arg0: &0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::config::HiveDaoCapability, arg1: &mut BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: &mut 0x2::token::TokenPolicy<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::transfer_bees_balance<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(arg2, &arg1.policy_cap, 0x2::balance::split<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>(&mut arg1.available_bees, arg3), arg4, arg5);
    }

    public fun update_bee_for_engagement_per_epoch(arg0: &0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::config::HiveDaoCapability, arg1: &mut BeesManager<0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::bee::BEE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        arg1.bee_for_engagement_per_epoch = arg2;
        let v0 = BeesForEngagementPerEpochUpdated{bee_for_engagement_per_epoch: arg2};
        0x2::event::emit<BeesForEngagementPerEpochUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

