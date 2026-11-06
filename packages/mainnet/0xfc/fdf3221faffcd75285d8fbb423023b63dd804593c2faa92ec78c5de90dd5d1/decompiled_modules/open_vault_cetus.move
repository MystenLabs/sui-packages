module 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault_cetus {
    public fun add_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(arg0, v0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::add_qf<T0, T1>(arg0, v0, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_added(0x2::object::id<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>>(arg1), &v2);
    }

    public fun begin<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::begin<T0, T1>(v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 0x2::clock::timestamp_ms(arg3))
    }

    public fun close_retired_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: 0x2::object::ID) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_closed<T0, T1>(arg0, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::close_retired_qf<T0, T1>(v0, v1, arg1, arg2, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retired_index<T0, T1>(v1, arg3)));
    }

    public fun collect_reward_qf<T0, T1, T2>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::holds<T0, T1>(v1, arg5), 512);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_reward<T0, T1, T2>(arg0, arg1, arg5, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_reward_qf<T0, T1, T2>(v0, v1, arg2, arg3, arg4, arg5, arg6), arg7);
    }

    public fun reclaim_crossed_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let (v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::reclaim_crossed_qf<T0, T1>(v0, v1, arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(v1, arg4), arg5);
        let v7 = v2;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::keep_removed<T0, T1>(arg0, arg1, &v7, v3, v4, v5, v6, arg6);
    }

    public fun add<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(arg0, v0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::add_tf<T0, T1>(arg0, v0, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_added(0x2::object::id<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>>(arg1), &v2);
    }

    public fun begin_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::begin<T0, T1>(v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), 0x2::clock::timestamp_ms(arg3))
    }

    public fun close_retired<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_closed<T0, T1>(arg0, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::close_retired_tf<T0, T1>(v0, v1, arg1, arg2, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::retired_index<T0, T1>(v1, arg3)));
    }

    public fun collect<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_tf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg4);
        };
    }

    public fun collect_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_qf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg4);
        };
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        assert!(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::holds<T0, T1>(v1, arg5), 512);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_reward<T0, T1, T2>(arg0, arg1, arg5, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_reward_tf<T0, T1, T2>(v0, v1, arg2, arg3, arg4, arg5, arg6), arg7);
    }

    public fun deposit<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::Deposit<T0, T1> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::assert_can_deposit<T0, T1>(arg0, arg1);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_tf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg6);
        };
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::deposit_at<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg3), 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public fun deposit_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::Deposit<T0, T1> {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::assert_can_deposit<T0, T1>(arg0, arg1);
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_qf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg6);
        };
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::deposit_at<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg4), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::spot_qf<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T0>(arg3), 0x2::clock::timestamp_ms(arg5), arg6)
    }

    entry fun observe<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), false), 0x2::balance::value<T0>(v0), 0x2::balance::value<T1>(v1));
    }

    entry fun observe_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_version(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::assert_keeper(arg1, arg4);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg2), 1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T1, T0>(arg2);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::observe_reserves<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3), 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::token_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg2), true), 0x2::balance::value<T0>(v1), 0x2::balance::value<T1>(v0));
    }

    public fun open<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::open_on<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 1, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1), arg2, arg3);
    }

    public fun open_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::open_on<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1), 1, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T1, T0>(arg1), arg2, arg3);
    }

    public fun reclaim_crossed<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let (v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::reclaim_crossed_tf<T0, T1>(v0, v1, arg2, arg3, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(v1, arg4), arg5);
        let v7 = v2;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::keep_removed<T0, T1>(arg0, arg1, &v7, v3, v4, v5, v6, arg6);
    }

    public fun remove<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg2: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(arg0, v0);
        let (v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::take_range_tf<T0, T1>(v0, v1, arg3, arg4, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(v1, arg5), arg6, arg7);
        let v7 = v2;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::keep_removed<T0, T1>(arg1, arg2, &v7, v3, v4, v5, v6, arg8);
    }

    public fun remove_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::Ticket, arg1: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg2: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: 0x2::object::ID, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_ticket(arg0, v0);
        let (v2, v3, v4, v5, v6) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::take_range_qf<T0, T1>(v0, v1, arg3, arg4, 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_index<T0, T1>(v1, arg5), arg6, arg7);
        let v7 = v2;
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::keep_removed<T0, T1>(arg1, arg2, &v7, v3, v4, v5, v6, arg8);
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::Deposit<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), 1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::check_withdraw<T0, T1>(arg0, &arg4, 0x2::clock::timestamp_ms(arg5));
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_tf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg6);
        };
        let (v10, v11, v12, v13, v14) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_idle<T0, T1>(arg0, arg4);
        let v15 = v14;
        let v16 = v13;
        let v17 = &mut v16;
        let v18 = &mut v15;
        let v19 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0));
        while (v19 > 0) {
            v19 = v19 - 1;
            let (v20, v21) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
            let v22 = (((0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::range_liquidity<T0, T1>(v20, v21, v19) as u256) * (v11 as u256) / (v12 as u256)) as u128);
            if (v22 > 0 || v11 == v12) {
                let (v23, v24, v25, v26, v27) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::take_range_tf<T0, T1>(v20, v21, arg2, arg3, v19, v22, arg5);
                let v28 = v23;
                0x2::balance::join<T0>(v17, v24);
                0x2::balance::join<T1>(v18, v25);
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_removed(0x2::object::id<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>>(arg0), &v28);
                let (v29, v30) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v26, v27);
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v29, v30, arg1, arg6);
                continue
            };
        };
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::finish_withdraw<T0, T1>(arg0, v10, v11, v12, v16, v15, arg6)
    }

    public fun withdraw_qf<T0, T1>(arg0: &mut 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>, arg1: &0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::Deposit<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::assert_pool_id<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3), 1);
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::check_withdraw<T0, T1>(arg0, &arg4, 0x2::clock::timestamp_ms(arg5));
        let (v0, v1) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
        let v2 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(v1);
        if (v2 > 0) {
            let v3 = 0x2::balance::zero<T0>();
            let v4 = 0x2::balance::zero<T1>();
            let v5 = 0;
            while (v5 < v2) {
                let (v6, v7) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::collect_range_fees_qf<T0, T1>(v0, v1, arg2, arg3, v5);
                0x2::balance::join<T0>(&mut v3, v6);
                0x2::balance::join<T1>(&mut v4, v7);
                v5 = v5 + 1;
            };
            let (v8, v9) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v3, v4);
            0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v8, v9, arg1, arg6);
        };
        let (v10, v11, v12, v13, v14) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_idle<T0, T1>(arg0, arg4);
        let v15 = v14;
        let v16 = v13;
        let v17 = &mut v16;
        let v18 = &mut v15;
        let v19 = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book::range_count<T0, T1>(0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::book_ref<T0, T1>(arg0));
        while (v19 > 0) {
            v19 = v19 - 1;
            let (v20, v21) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::parts_mut<T0, T1>(arg0);
            let v22 = (((0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::range_liquidity<T0, T1>(v20, v21, v19) as u256) * (v11 as u256) / (v12 as u256)) as u128);
            if (v22 > 0 || v11 == v12) {
                let (v23, v24, v25, v26, v27) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::book_cetus::take_range_qf<T0, T1>(v20, v21, arg2, arg3, v19, v22, arg5);
                let v28 = v23;
                0x2::balance::join<T0>(v17, v24);
                0x2::balance::join<T1>(v18, v25);
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::emit_removed(0x2::object::id<0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::OpenVault<T0, T1>>(arg0), &v28);
                let (v29, v30) = 0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::take_fees<T0, T1>(arg0, v26, v27);
                0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::pay_fees<T0, T1>(v29, v30, arg1, arg6);
                continue
            };
        };
        0xfcfdf3221faffcd75285d8fbb423023b63dd804593c2faa92ec78c5de90dd5d1::open_vault::finish_withdraw<T0, T1>(arg0, v10, v11, v12, v16, v15, arg6)
    }

    // decompiled from Move bytecode v7
}

