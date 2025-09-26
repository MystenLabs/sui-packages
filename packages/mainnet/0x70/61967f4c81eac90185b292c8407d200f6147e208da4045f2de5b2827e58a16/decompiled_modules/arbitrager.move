module 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager {
    struct ARBITRAGER has drop {
        dummy_field: bool,
    }

    struct CreateBotEvent has copy, drop, store {
        bot_id: 0x2::object::ID,
        funder: address,
        operator: address,
    }

    struct BotStopEvent has copy, drop, store {
        stopped: bool,
    }

    struct SwapEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        in_coin: 0x1::type_name::TypeName,
        out_coin: 0x1::type_name::TypeName,
        in_amount: u64,
        out_amount: u64,
        timestamp_ms: u64,
    }

    struct LimitOrderEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        current_sqrt_price: u128,
        sqrt_price: u128,
        tick_lower: u32,
        tick_upper: u32,
        timestamp_ms: u64,
    }

    struct DeleteLimitOrderEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        current_sqrt_price: u128,
        amount_a: u64,
        amount_b: u64,
        balance_a: u64,
        balance_b: u64,
        fee_amount_a: u64,
        fee_amount_b: u64,
        tick_lower: u32,
        tick_upper: u32,
        timestamp_ms: u64,
    }

    struct CollectRewardEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct Level has copy, drop, store {
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
    }

    struct Bot has store, key {
        id: 0x2::object::UID,
        funder: address,
        operator: address,
        positions: 0x2::vec_map::VecMap<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        coins: vector<0x1::type_name::TypeName>,
        cex_deposit_address: address,
        stop: bool,
        limit_orders: 0x2::table::Table<u32, 0x2::object::ID>,
        balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    public fun swap<T0, T1>(arg0: &mut Bot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        only_operator_funder(arg0, 0x2::tx_context::sender(arg8));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0;
        let (v3, v4) = available_balances<T0, T1>(arg0);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let (v11, v12, v13) = if (arg3) {
            if (arg4) {
                assert!(v3 >= arg5, 4);
                let (v14, v15) = check_out<T0, T1>(arg0, arg5, 0);
                (v14, v15, arg5)
            } else {
                assert!(v3 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), 4);
                let (v16, v17) = check_out<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), 0);
                (v16, v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8))
            }
        } else {
            v0 = 0x1::type_name::with_defining_ids<T1>();
            v1 = 0x1::type_name::with_defining_ids<T0>();
            if (arg4) {
                assert!(v4 >= arg5, 5);
                let (v18, v19) = check_out<T0, T1>(arg0, 0, arg5);
                (v18, v19, arg5)
            } else {
                assert!(v4 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), 5);
                let (v20, v21) = check_out<T0, T1>(arg0, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8));
                (v20, v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8))
            }
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v11, v12, v8);
        if (0x2::balance::value<T0>(&v10) > 0) {
            v2 = 0x2::balance::value<T0>(&v10);
            deposit<T0>(arg0, v10, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        if (0x2::balance::value<T1>(&v9) > 0) {
            v2 = 0x2::balance::value<T1>(&v9);
            deposit<T1>(arg0, v9, arg8);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
        };
        let v22 = SwapEvent{
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            in_coin      : v0,
            out_coin     : v1,
            in_amount    : v13,
            out_amount   : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<SwapEvent>(v22);
    }

    public fun all_balances(arg0: &Bot) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coins)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coins, v2);
            let v4 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, v3)) {
                *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, v3)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun available_balance<T0>(arg0: &Bot) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        }
    }

    public fun available_balances<T0, T1>(arg0: &Bot) : (u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        };
        let v3 = if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v1))
        };
        (v2, v3)
    }

    public fun balance_is_empty(arg0: &Bot) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coins)) {
            if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coins, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun cex_deposit_address(arg0: &Bot) : address {
        arg0.cex_deposit_address
    }

    public fun change_funder(arg0: &0x2::package::Publisher, arg1: &mut Bot, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<ARBITRAGER>(arg0), 13906837837950484479);
        assert!(arg1.funder != arg2, 13906837842245451775);
        arg1.funder = arg2;
    }

    public fun change_operator(arg0: &0x2::package::Publisher, arg1: &mut Bot, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<ARBITRAGER>(arg0), 13906837885195124735);
        assert!(arg1.operator != arg2, 13906837889490092031);
        arg1.operator = arg2;
    }

    fun check_out<T0, T1>(arg0: &mut Bot, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            assert!(0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) >= arg1, 4);
        } else {
            assert!(arg1 == 0, 13906836235927683071);
        };
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            assert!(0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, v1)) >= arg2, 5);
        } else {
            assert!(arg2 == 0, 13906836270287421439);
        };
        let v2 = if (arg1 > 0) {
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
            *v3 = *v3 - arg1;
            0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
        } else {
            0x2::balance::zero<T0>()
        };
        let v4 = if (arg2 > 0) {
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v1);
            *v5 = *v5 - arg2;
            0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, v1), arg2)
        } else {
            0x2::balance::zero<T1>()
        };
        (v2, v4)
    }

    public fun collect_position_reward<T0, T1, T2>(arg0: &mut Bot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        only_operator_funder(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0x2::vec_map::get<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, &arg3), arg4, true, arg5);
        deposit<T2>(arg0, v0, arg6);
        let v1 = CollectRewardEvent{
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id  : arg3,
            reward       : 0x1::type_name::with_defining_ids<T2>(),
            amount       : 0x2::balance::value<T2>(&v0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
    }

    public fun create_bot(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Bot {
        assert!(0x2::package::from_module<ARBITRAGER>(arg0), 13906834702624358399);
        let v0 = Bot{
            id                  : 0x2::object::new(arg4),
            funder              : arg2,
            operator            : arg1,
            positions           : 0x2::vec_map::empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            coins               : 0x1::vector::empty<0x1::type_name::TypeName>(),
            cex_deposit_address : arg3,
            stop                : false,
            limit_orders        : 0x2::table::new<u32, 0x2::object::ID>(arg4),
            balances            : 0x2::table::new<0x1::type_name::TypeName, u64>(arg4),
        };
        let v1 = CreateBotEvent{
            bot_id   : 0x2::object::id<Bot>(&v0),
            funder   : arg2,
            operator : arg1,
        };
        0x2::event::emit<CreateBotEvent>(v1);
        v0
    }

    entry fun create_bot_ex(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Bot>(create_bot(arg0, arg1, arg2, arg3, arg4));
    }

    public fun delete_limit_order<T0, T1>(arg0: &mut Bot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        only_operator_funder(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, &arg3), 9);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, &arg3);
        let v2 = v1;
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v2, true);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v2, v3, arg4);
        let v10 = v9;
        let v11 = v8;
        deposit<T0>(arg0, v11, arg5);
        deposit<T1>(arg0, v10, arg5);
        deposit<T0>(arg0, v7, arg5);
        deposit<T1>(arg0, v6, arg5);
        let (v12, v13) = available_balances<T0, T1>(arg0);
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v2);
        0x2::table::remove<u32, 0x2::object::ID>(&mut arg0.limit_orders, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v2);
        let v16 = DeleteLimitOrderEvent{
            pool_id            : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id        : arg3,
            liquidity          : v3,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2),
            amount_a           : 0x2::balance::value<T0>(&v11),
            amount_b           : 0x2::balance::value<T1>(&v10),
            balance_a          : v12,
            balance_b          : v13,
            fee_amount_a       : 0x2::balance::value<T0>(&v7),
            fee_amount_b       : 0x2::balance::value<T1>(&v6),
            tick_lower         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v14),
            tick_upper         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v15),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeleteLimitOrderEvent>(v16);
    }

    public fun deposit<T0>(arg0: &mut Bot, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0, 0x2::balance::value<T0>(&arg1));
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coins, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
            *v1 = *v1 + 0x2::balance::value<T0>(&arg1);
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        };
    }

    entry fun deposit_ex<T0>(arg0: &mut Bot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    public(friend) fun extract_position(arg0: &mut Bot, arg1: 0x2::object::ID) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, &arg1);
        v1
    }

    public fun get_pool_current_depth<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32) : (vector<Level>, vector<Level>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0);
        assert!(arg1 / v2 * v2 == arg1, 13906837507238002687);
        let v3 = arg1 / v2;
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2));
        let v5 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4) + v2);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::fetch_ticks(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), v5, ((arg2 * v3) as u64));
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0);
        let v8 = 0;
        let v9 = 0x1::vector::empty<Level>();
        while (v8 < 5) {
            let v10 = arg2 + v8;
            let v11 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4) >= arg1 * v10 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick())) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4) - arg1 * v10
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick())
            };
            if (v8 > 0 && v11 == 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick())) {
                break
            };
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v11), false);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v12)) {
                break
            };
            let (v13, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v12), false);
            let v15 = 0x1::vector::empty<u32>();
            0x1::vector::push_back<u32>(&mut v15, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v13)));
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::fetch_ticks(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), v15, ((v10 * arg1) as u64));
            0x1::vector::reverse<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&mut v16);
            v9 = translate_bid_levels<T0, T1>(arg0, v0, v1, v7, &v16, v2, v3);
            if (0x1::vector::length<Level>(&v9) >= (arg2 as u64)) {
                break
            };
            v8 = v8 + 1;
        };
        (translate_ask_levels<T0, T1>(arg0, v0, v1, v7, &v6, v2, v3), v9)
    }

    public fun has_position(arg0: &Bot) : bool {
        !0x2::vec_map::is_empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions)
    }

    fun init(arg0: ARBITRAGER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ARBITRAGER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun limit_order<T0, T1>(arg0: &mut Bot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        only_operator_funder(arg0, 0x2::tx_context::sender(arg8));
        assert!(arg5 > arg4 && arg5 - arg4 == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2), 6);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg8);
        let (v2, v3) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4))) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v1, arg6, true, arg7), true)
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)), 7);
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v1, arg6, false, arg7), false)
        };
        let v4 = v2;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v4);
        let v7 = if (v3) {
            if (v6 == 0) {
                v5 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v8 = if (v7) {
            true
        } else if (!v3) {
            if (v6 > 0) {
                v5 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 7);
        let (v9, v10) = check_out<T0, T1>(arg0, v5, v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1);
        0x2::vec_map::insert<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, v11, v1);
        0x2::table::add<u32, 0x2::object::ID>(&mut arg0.limit_orders, arg4, v11);
        let v12 = if (v3) {
            0x1::type_name::with_defining_ids<T0>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        let v13 = LimitOrderEvent{
            pool_id            : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id        : v11,
            coin               : v12,
            amount             : arg6,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2),
            sqrt_price         : arg3,
            tick_lower         : arg4,
            tick_upper         : arg5,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<LimitOrderEvent>(v13);
    }

    public fun limit_order_by_sqrt_price<T0, T1>(arg0: &mut Bot, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        only_operator_funder(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg3)) / v1 * v1;
        let v3 = v2 + v1;
        assert!(v0 <= v2 || v0 > v3, 8);
        limit_order<T0, T1>(arg0, arg1, arg2, arg3, v2, v3, arg4, arg5, arg6);
    }

    public fun only_funder(arg0: &Bot, arg1: address) {
        assert!(arg1 == arg0.funder, 2);
    }

    public fun only_operator(arg0: &Bot, arg1: address) {
        assert!(arg1 == arg0.operator, 1);
    }

    public fun only_operator_funder(arg0: &Bot, arg1: address) {
        assert!(arg1 == arg0.operator || arg1 == arg0.funder, 13906834874423050239);
    }

    public fun stop_bot(arg0: &mut Bot, arg1: bool) {
        assert!(arg0.stop != arg1, 13906837945324666879);
        arg0.stop = arg1;
        let v0 = BotStopEvent{stopped: arg1};
        0x2::event::emit<BotStopEvent>(v0);
    }

    public fun stopped(arg0: &Bot) : bool {
        arg0.stop
    }

    fun translate_ask_levels<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: &vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>, arg5: u32, arg6: u32) : vector<Level> {
        let v0 = 0x1::vector::empty<Level>();
        let v1 = 0;
        let v2 = 0;
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5 * arg6);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg1, v3), v3));
        let v5 = arg1;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4)) {
            while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4, v6)), arg1)) {
                v6 = v6 + 1;
            };
            let v7 = *0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4, v6);
            let (v8, v9) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v7), v4)) {
                let (v10, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(arg1, v4, arg1, arg2, arg3, true);
                let (v12, v13, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v4), arg3, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), false, false);
                arg1 = v4;
                (v12, v13)
            } else {
                let (v16, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v7), arg1, arg2, arg3, true);
                let (v18, v19, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v7)), arg3, v16, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), false, false);
                arg1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v7);
                (v18, v19)
            };
            let v22 = v1 + v9;
            v1 = v22;
            let v23 = v2 + v8;
            v2 = v23;
            arg2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg1, v4)) {
                let v24 = Level{
                    tick_lower : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5),
                    tick_upper : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4),
                    amount_a   : v22,
                    amount_b   : v23,
                };
                0x1::vector::push_back<Level>(&mut v0, v24);
                v1 = 0;
                v2 = 0;
                v5 = v4;
                v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v4, v3);
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v7))) {
                let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(&v7);
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v25)) {
                    arg3 = arg3 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v25);
                } else {
                    arg3 = arg3 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v25);
                };
            };
            v6 = v6 + 1;
        };
        if (v1 > 0 || v2 > 0) {
            let v26 = Level{
                tick_lower : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg1),
                tick_upper : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4),
                amount_a   : v1,
                amount_b   : v2,
            };
            0x1::vector::push_back<Level>(&mut v0, v26);
        };
        v0
    }

    fun translate_bid_levels<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: &vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>, arg5: u32, arg6: u32) : vector<Level> {
        let v0 = 0x1::vector::empty<Level>();
        let v1 = 0;
        let v2 = 0;
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5 * arg6);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg1, v3), v3);
        let v5 = arg1;
        let v6 = v4;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v4, arg1)) {
            arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4)) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4, v7)), arg1)) {
                v7 = v7 + 1;
            } else {
                break
            };
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4, v7)), arg1)) {
            arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v7 = v7 + 1;
        };
        while (v7 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4)) {
            let v8 = *0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(arg4, v7);
            let (v9, v10) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v8))) {
                let (_, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(arg1, v6, arg1, arg2, arg3, true);
                v2 = v2 + v12;
                let (v13, _, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6), arg3, v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), true, false);
                arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                (v13, v12)
            } else {
                let (_, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v8), arg1, arg2, arg3, true);
                let (v19, _, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v8)), arg3, v18, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), true, false);
                arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v8), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
                (v19, v18)
            };
            let v23 = v1 + v9;
            v1 = v23;
            let v24 = v2 + v10;
            v2 = v24;
            arg2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(arg1);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(&v8), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)))) {
                let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(&v8);
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v25)) {
                    arg3 = arg3 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v25);
                } else {
                    arg3 = arg3 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v25);
                };
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg1, v6)) {
                let v26 = Level{
                    tick_lower : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v6),
                    tick_upper : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5),
                    amount_a   : v23,
                    amount_b   : v24,
                };
                0x1::vector::push_back<Level>(&mut v0, v26);
                v1 = 0;
                v2 = 0;
                v5 = v6;
                v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v6, v3);
            };
            v7 = v7 + 1;
        };
        if (v1 > 0 || v2 > 0) {
            let v27 = Level{
                tick_lower : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v6),
                tick_upper : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg1),
                amount_a   : v1,
                amount_b   : v2,
            };
            0x1::vector::push_back<Level>(&mut v0, v27);
        };
        v0
    }

    public fun withdraw<T0>(arg0: &mut Bot, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        only_funder(arg0, 0x2::tx_context::sender(arg1));
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::with_defining_ids<T0>()), 3);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T0>());
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    entry fun withdraw_ex<T0>(arg0: &mut Bot, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

