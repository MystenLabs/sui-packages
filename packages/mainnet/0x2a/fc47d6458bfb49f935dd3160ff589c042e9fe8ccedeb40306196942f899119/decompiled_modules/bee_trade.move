module 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::bee_trade {
    struct BeeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bee_kraft_cap: 0x2::coin::TreasuryCap<T0>,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
        is_genesis_supply_krafted: bool,
    }

    public fun add_bid_for_streamer_buzzes<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg2: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg3: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::add_bid_for_streamer_buzzes<T0>(arg0, arg1, &arg2.policy_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun add_liquidity_to_x_bee_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::token::Token<T1>, arg4: u64, arg5: u64, arg6: &BeeCap<T1>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>> {
        0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::unwrap_bee_tokens_to_coins<T1>(arg3, &arg6.policy_cap, arg7, arg4, arg8)), arg5)
    }

    public fun burn_bees_from_supply(arg0: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg1: &mut BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::token::flush<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg0, &mut arg1.bee_kraft_cap, arg2);
        0x2::token::spent_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg0)
    }

    public fun increment_stream<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg2: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg3: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x2::tx_context::TxContext) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::increment_stream<T0>(arg0, arg1, arg2, &arg3.policy_cap, arg4, arg5);
    }

    public fun interact_with_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg3: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveDisperser, arg6: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg7: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::interact_with_stream_buzz<T0>(arg0, arg1, arg2, &arg3.policy_cap, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun kraft_genesis_bees<T0>(arg0: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg1: 0x2::coin::TreasuryCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE> {
        let v0 = 0x2::coin::into_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(0x2::coin::mint<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut arg1, 420000000000000000, arg2));
        let (v1, v2) = 0x2::token::new_policy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::set_rules<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut v4, &v3, arg2);
        0x2::token::share_policy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(v4);
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::add_bees_for_streaming_incentives<T0>(arg0, 0x2::balance::split<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(&mut v0, (0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::math::mul_div_u128((420000000000000000 as u128), (5 as u128), (100 as u128)) as u64)), arg2);
        let v5 = BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>{
            id                        : 0x2::object::new(arg2),
            bee_kraft_cap             : arg1,
            policy_cap                : v3,
            is_genesis_supply_krafted : false,
        };
        0x2::transfer::share_object<BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>>(v5);
        v0
    }

    public fun like_stream_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg3: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg4: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::like_stream_buzz<T0>(arg0, arg1, arg2, &arg3.policy_cap, arg4, arg5, arg6, arg7, arg8);
    }

    public fun more_new_swap_bee_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: 0x2::token::Token<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &BeeCap<T1>, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::swap_bee_coins<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, arg3), arg4, 0x2::coin::into_balance<T1>(0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::unwrap_bee_tokens_to_coins<T1>(&mut arg5, &arg9.policy_cap, arg10, arg6, arg11)), arg7, arg8);
        0x2::balance::join<T0>(&mut arg2, v0);
        let (v2, v3) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v4 = v3;
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::verify<T1>(arg10, &mut v4, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v4, arg11);
        0x2::token::join<T1>(&mut arg5, v2);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees<T1>(&mut arg5, &arg9.policy_cap, arg10, 0x2::token::value<T1>(&arg5), 0x2::tx_context::sender(arg11), arg11);
        0x2::token::destroy_zero<T1>(arg5);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<T0>(arg2, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun new_swap_bee_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: 0x2::token::Token<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &BeeCap<T1>, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::swap_bee_coins<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(arg2, arg3), arg4, 0x2::coin::into_balance<T1>(0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::unwrap_bee_tokens_to_coins<T1>(&mut arg5, &arg9.policy_cap, arg10, arg6, arg11)), arg7, arg8);
        let (v2, v3) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v4 = v3;
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::verify<T1>(arg10, &mut v4, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v4, arg11);
        0x2::token::join<T1>(&mut arg5, v2);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees<T1>(&mut arg5, &arg9.policy_cap, arg10, 0x2::token::value<T1>(&arg5), 0x2::tx_context::sender(arg11), arg11);
        0x2::token::destroy_zero<T1>(arg5);
        v0
    }

    public fun remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::token::TokenPolicy<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::token::Token<T1>, 0x2::balance::Balance<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>) {
        let (v0, v1, v2) = 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let (v3, v4) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg7), arg7);
        let v5 = v4;
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::verify<T1>(arg6, &mut v5, arg7);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, v5, arg7);
        (v0, v3, v2)
    }

    public fun remove_liquidity_from_x_bee_pool_and_return<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: &BeeCap<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>(arg2);
        let (v1, v2, v3) = 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::remove_liquidity_from_x_bee_pool<T0, T1, T2>(arg0, arg1, 0x2::balance::split<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>(&mut v0, arg3), arg4, arg5, arg6);
        0x2::balance::join<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>(&mut v0, v3);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg9), arg9);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::coin_helper::destroy_or_transfer_balance<0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg9), arg9);
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees_balance<T1>(arg7, &arg8.policy_cap, v2, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun swap_bee_coins<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::token::Token<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &BeeCap<T1>, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x2c48ac843f415aedb11ab2c7f9eda3faf205396642fe13b346acfcc5ca6373e3::two_pool::swap_bee_coins<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(arg2, arg3), arg4, 0x2::coin::into_balance<T1>(0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::unwrap_bee_tokens_to_coins<T1>(arg5, &arg9.policy_cap, arg10, arg6, arg11)), arg7, arg8);
        let (v2, v3) = 0x2::token::from_coin<T1>(0x2::coin::from_balance<T1>(v1, arg11), arg11);
        let v4 = v3;
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::verify<T1>(arg10, &mut v4, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v4, arg11);
        0x2::token::join<T1>(arg5, v2);
        v0
    }

    public fun transfer_bees(arg0: &mut 0x2::token::Token<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg1: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg2: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg0, &arg1.policy_cap, arg2, arg3, arg4, arg5);
    }

    public fun transfer_bees_balance(arg0: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg1: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg2: 0x2::balance::Balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::transfer_bees_balance<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>(arg0, &arg1.policy_cap, arg2, arg3, arg4);
    }

    public fun upvote_hive_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveManager, arg2: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::HiveVault, arg3: &mut 0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive_profile::HiveProfile, arg4: &BeeCap<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg5: &mut 0x2::token::TokenPolicy<0x893914132732096938d72cbc7188a44d4c9bd8c8bcd1d45bd782891a51420301::bee::BEE>, arg6: address, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x95200662180edb7e40e73cbf327306319ee94e39037e888b2108ed69451e4aa3::hive::upvote_hive_buzz<T0>(arg0, arg1, arg2, arg3, &arg4.policy_cap, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

