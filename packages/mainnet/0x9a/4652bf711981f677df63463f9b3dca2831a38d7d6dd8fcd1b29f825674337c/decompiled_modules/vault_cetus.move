module 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault_cetus {
    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 1);
        let v0 = if (arg5 == 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_id<T0, T1, T2>(arg0)) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T2, T3>(arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_mut<T0, T1, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), arg4, true, arg6)
        } else {
            let (v1, v2) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
            assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::holds<T0, T2>(v2, arg5), 422);
            0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::collect_reward_tf<T0, T2, T3>(v1, v2, arg2, arg3, arg4, arg5, arg6)
        };
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::pay_reward<T0, T1, T2, T3>(arg0, arg1, arg5, v0, arg7);
    }

    public fun add_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket, arg1: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg1);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_ticket(arg0, v0);
        let v2 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::add_qf<T0, T2>(arg0, v0, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_added(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg1), &v2);
    }

    public fun begin<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_begin<T0, T1, T2>(arg0, arg1, arg4);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::begin<T0, T2>(v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), 0x2::clock::timestamp_ms(arg3))
    }

    public fun close_retired_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: 0x2::object::ID) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_closed<T0, T1, T2>(arg0, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::close_retired_qf<T0, T2>(v0, v1, arg1, arg2, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::retired_index<T0, T2>(v1, arg3)));
    }

    public fun collect_reward_qf<T0, T1, T2, T3>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg3), 1);
        let v0 = if (arg5 == 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_id<T0, T1, T2>(arg0)) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T2, T0, T3>(arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_mut<T0, T1, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), arg4, true, arg6)
        } else {
            let (v1, v2) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
            assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::holds<T0, T2>(v2, arg5), 422);
            0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::collect_reward_qf<T0, T2, T3>(v1, v2, arg2, arg3, arg4, arg5, arg6)
        };
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::pay_reward<T0, T1, T2, T3>(arg0, arg1, arg5, v0, arg7);
    }

    entry fun place_launch_ladder_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg1, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg0);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let v2 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::place_launch_ladder_qf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::take_ladder_pending<T0, T1, T2>(arg0), arg4, arg5);
        0x1::vector::reverse<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&mut v2);
            0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_added(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg0), &v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(v2);
    }

    public fun reclaim_crossed_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::reclaim_crossed_qf<T0, T2>(v0, v1, arg1, arg2, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg3), arg4);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg0, &v7, v3, v4, v5, v6);
    }

    public fun add<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket, arg1: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg1);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_ticket(arg0, v0);
        let v2 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::add_tf<T0, T2>(arg0, v0, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_added(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg1), &v2);
    }

    public fun begin_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_begin<T0, T1, T2>(arg0, arg1, arg4);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::begin<T0, T2>(v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), 0x2::clock::timestamp_ms(arg3))
    }

    public fun check_sunset<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg0);
        collect<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::close_window_due<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun check_sunset_curve<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &0x2::clock::Clock) {
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::has_no_launch<T0, T1, T2>(arg0), 423);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T0, T2>(arg2);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::add_volume<T0, T1, T2>(arg0, v0, v1, false, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg2), false), 1000000 * 10000, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::protocol_fee_rate(arg1) as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T2>(arg2) as u128));
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::close_window_due<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun check_sunset_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg0);
        collect_qf<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::close_window_due<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun close_retired<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: 0x2::object::ID) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_closed<T0, T1, T2>(arg0, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::close_retired_tf<T0, T2>(v0, v1, arg1, arg2, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::retired_index<T0, T2>(v1, arg3)));
    }

    public fun collect<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T2>(arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_mut<T0, T1, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), true);
        let v2 = arg3;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T0, T2>(v2);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::add_volume<T0, T1, T2>(arg0, v3, v4, false, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(v2), false), 1000000 * 10000, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::protocol_fee_rate(arg2) as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T2>(v2) as u128));
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::take_launch_fees<T0, T1, T2>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun collect_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg3), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T2, T0>(arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::launch_position_mut<T0, T1, T2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), true);
        let v2 = arg3;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T2, T0>(v2);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::add_volume<T0, T1, T2>(arg0, v3, v4, true, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T0>(v2), true), 1000000 * 10000, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::protocol_fee_rate(arg2) as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T2, T0>(v2) as u128));
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::take_launch_fees<T0, T1, T2>(arg0, arg1, v1, v0, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    entry fun observe<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg1, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::observe_at<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg3), false));
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T0, T2>(arg3);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::add_volume<T0, T1, T2>(arg0, v0, v1, false, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg3), false), 1000000 * 10000, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::protocol_fee_rate(arg2) as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T2>(arg3) as u128));
    }

    entry fun observe_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg1, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_pool_id<T0, T2>(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::book_ref<T0, T1, T2>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg3), 1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::observe_at<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4), 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T0>(arg3), true));
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::protocol_fee<T2, T0>(arg3);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::add_volume<T0, T1, T2>(arg0, v0, v1, true, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T0>(arg3), true), 1000000 * 10000, (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::protocol_fee_rate(arg2) as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T2, T0>(arg3) as u128));
    }

    entry fun place_launch_ladder<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_version(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::assert_keeper(arg1, arg5);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_active<T0, T1, T2>(arg0);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let v2 = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::place_launch_ladder_tf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::take_ladder_pending<T0, T1, T2>(arg0), arg4, arg5);
        0x1::vector::reverse<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(&mut v2);
            0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::emit_added(0x2::object::id<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>>(arg0), &v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Added>(v2);
    }

    public fun reclaim_crossed<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::reclaim_crossed_tf<T0, T2>(v0, v1, arg1, arg2, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg3), arg4);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg0, &v7, v3, v4, v5, v6);
    }

    public fun redeem<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x2::coin_registry::Currency<T1>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_redeem<T0, T1, T2>(arg0);
        collect<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::redeem_now<T0, T1, T2>(arg0, arg4, arg5, arg7)
    }

    public fun redeem_curve<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &mut 0x2::coin_registry::Currency<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        assert!(0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::has_no_launch<T0, T1, T2>(arg0), 423);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_redeem<T0, T1, T2>(arg0);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::redeem_now<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun redeem_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x2::coin_registry::Currency<T1>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T0>) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_redeem<T0, T1, T2>(arg0);
        collect_qf<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, arg7);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::redeem_now<T0, T1, T2>(arg0, arg4, arg5, arg7)
    }

    public fun remove<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket, arg1: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_ticket(arg0, v0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::take_range_tf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg4), arg5, arg6);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg1, &v7, v3, v4, v5, v6);
    }

    public fun remove_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::Ticket, arg1: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: 0x2::object::ID, arg5: u128, arg6: &0x2::clock::Clock) {
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg1);
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::assert_ticket(arg0, v0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::take_range_qf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg4), arg5, arg6);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg1, &v7, v3, v4, v5, v6);
    }

    public fun unwind<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5), arg6);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::take_range_tf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg4), 340282366920938463463374607431768211455, arg5);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg0, &v7, v3, v4, v5, v6);
    }

    public fun unwind_qf<T0, T1, T2>(arg0: &mut 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::Vault<T0, T1, T2>, arg1: &0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::assert_can_unwind<T0, T1, T2>(arg0, arg1, 0x2::clock::timestamp_ms(arg5), arg6);
        let (v0, v1) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::parts_mut<T0, T1, T2>(arg0);
        let (v2, v3, v4, v5, v6) = 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book_cetus::take_range_qf<T0, T2>(v0, v1, arg2, arg3, 0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::book::range_index<T0, T2>(v1, arg4), 340282366920938463463374607431768211455, arg5);
        let v7 = v2;
        0x9a4652bf711981f677df63463f9b3dca2831a38d7d6dd8fcd1b29f825674337c::vault::keep_removed<T0, T1, T2>(arg0, &v7, v3, v4, v5, v6);
    }

    // decompiled from Move bytecode v7
}

