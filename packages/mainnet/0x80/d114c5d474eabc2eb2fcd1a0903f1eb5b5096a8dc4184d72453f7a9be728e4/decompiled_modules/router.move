module 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::router {
    public entry fun add_user_to_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::add_user_to_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun add_users_to_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: vector<address>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::add_users_to_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun cancel<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::cancel<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::PurchaseMark, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun purchase<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::PurchaseMark, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::merge_coins<T1>(arg3, arg6);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::purchase<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, arg4, arg6)), arg5, arg6);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun remove_user_from_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::remove_user_from_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun settle<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::settle<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_pool_duration<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::update_pool_duration<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun update_recipient_address<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::update_recipient_address<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun update_whitelist_hard_cap_total<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::update_whitelist_hard_cap_total<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_raise<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::withdraw_raise<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_sale<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::withdraw_sale<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_and_purchase<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::merge_coins<T1>(arg2, arg5);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::create_mark_and_purchase<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, arg3, arg5)), arg4, arg5);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_launch_pool<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::factory::Pools, arg3: address, arg4: u128, arg5: vector<0x2::coin::Coin<T0>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u32, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::merge_coins<T0>(arg5, arg18);
        assert!(0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg17) < arg12, 2);
        let v1 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((arg6 as u128), arg4, 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR());
        assert!(arg10 == v1 && arg9 < arg10, 1);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::factory::create_pool<T0, T1>(arg0, arg1, arg3, arg2, arg4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((arg6 as u128), ((arg11 + 10000) as u128), 10000), arg18)), arg6, arg7, arg8, arg9, v1, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg18);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg18));
    }

    public entry fun settle_only_with_a<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u128, arg5: vector<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::settle_with_forward_clmm_pool<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg6, arg7);
    }

    public entry fun settle_only_with_b<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u128, arg5: vector<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::settle_with_forward_clmm_pool<T0, T1>(arg0, arg1, arg3, arg2, arg4, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg5, false, arg6, arg7);
    }

    public entry fun settle_with_reverse_clmm_only_with_a<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u128, arg5: vector<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::settle_with_reverse_clmm_pool<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, 0x1::vector::empty<0x2::coin::Coin<T0>>(), true, arg6, arg7);
    }

    public entry fun settle_with_reverse_clmm_only_with_b<T0, T1>(arg0: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u128, arg5: vector<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::settle_with_reverse_clmm_pool<T0, T1>(arg0, arg1, arg3, arg2, arg4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg5, false, arg6, arg7);
    }

    public entry fun update_whitelist_member_safe_limit_amount<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::Pool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool::update_whitelist_safe_limit_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

