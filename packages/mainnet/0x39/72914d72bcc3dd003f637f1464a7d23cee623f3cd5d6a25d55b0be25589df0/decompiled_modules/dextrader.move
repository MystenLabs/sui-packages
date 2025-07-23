module 0x3972914d72bcc3dd003f637f1464a7d23cee623f3cd5d6a25d55b0be25589df0::dextrader {
    struct TransferOwnership has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetOperator has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct SetTokenHolder has copy, drop {
        old_token_holder: address,
        new_token_holder: address,
    }

    struct SetPoolWhitelist has copy, drop {
        pool: 0x2::object::ID,
        accepted: bool,
    }

    struct SetPoolTickLimits has copy, drop {
        pool: 0x2::object::ID,
        tick_lowest_idx: u32,
        tick_upperest_idx: u32,
    }

    struct SetPoolPriceLimits has copy, drop {
        pool: 0x2::object::ID,
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    struct CreatePosition has copy, drop {
        position_id: 0x2::object::ID,
        pool: 0x2::object::ID,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
    }

    struct ClosePosition has copy, drop {
        position_id: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operator: address,
        token_holder: address,
        pool_whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        pool_positions: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>,
        pool_tick_limits: 0x2::table::Table<0x2::object::ID, TickLimits>,
        pool_price_limits: 0x2::table::Table<0x2::object::ID, PriceLimits>,
        balances: 0x2::bag::Bag,
    }

    struct TickLimits has drop, store {
        tick_lowest_idx: u32,
        tick_upperest_idx: u32,
    }

    struct PriceLimits has drop, store {
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    entry fun swap<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        check_pool_prices(arg0, check_pool_id<T0, T1>(arg0, arg2), arg3, arg6);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg3) {
        };
        let v6 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v6), v5);
        let v7 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v7), v4);
        let (v8, v9) = if (arg3) {
            let v10 = &mut arg0.balances;
            (0x2::balance::split<T0>(get_balance_mut<T0>(v10), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>())
        } else {
            let v11 = &mut arg0.balances;
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(get_balance_mut<T1>(v11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        let v0 = &mut arg0.balances;
        let v1 = 0x2::balance::split<T0>(get_balance_mut<T0>(v0), arg3);
        let v2 = &mut arg0.balances;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v1, 0x2::balance::split<T1>(get_balance_mut<T1>(v2), arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, check_pool_id<T0, T1>(arg0, arg2)), arg6), arg5, arg7));
    }

    entry fun close_position<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg4);
        let v0 = check_pool_id<T0, T1>(arg0, arg2);
        let v1 = 0x2::table::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, v0), arg3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1) > 0, 105);
        let v2 = ClosePosition{
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            pool        : v0,
        };
        0x2::event::emit<ClosePosition>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v1);
    }

    entry fun collect_fee<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg4);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, check_pool_id<T0, T1>(arg0, arg2)), arg3), true);
        let v2 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v2), v0);
        let v3 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v3), v1);
    }

    entry fun collect_reward<T0, T1, T2>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, check_pool_id<T0, T1>(arg0, arg2)), arg3), arg4, true, arg5), arg6), arg0.token_holder);
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, check_pool_id<T0, T1>(arg0, arg2)), arg4);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, v0, arg3, arg5);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, v0, false);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        let v7 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v7), v4);
        let v8 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v8), v3);
    }

    public fun accept_payment<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        if (!0x2::bag::contains<address>(&arg0.balances, v2)) {
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    fun check_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_pool_id<T0, T1>(arg0: &State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, v0), 104);
        v0
    }

    fun check_pool_prices(arg0: &State, arg1: 0x2::object::ID, arg2: bool, arg3: u128) {
        assert!(0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1), 108);
        if (arg2) {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_a2b <= arg3, 110);
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_b2a >= arg3, 110);
        };
    }

    fun check_pool_ticks(arg0: &State, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        assert!(0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1), 107);
        let v0 = 0x2::table::borrow<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1);
        assert!(v0.tick_lowest_idx <= arg2 && v0.tick_upperest_idx >= arg3, 109);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    entry fun create_position<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        let v0 = check_pool_id<T0, T1>(arg0, arg2);
        check_pool_ticks(arg0, v0, arg3, arg4);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&arg0.pool_positions, v0)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, v0, 0x2::table::new<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5));
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1);
        let v3 = CreatePosition{
            position_id    : v2,
            pool           : v0,
            tick_lower_idx : arg3,
            tick_upper_idx : arg4,
        };
        0x2::event::emit<CreatePosition>(v3);
        0x2::table::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&mut arg0.pool_positions, v0), v2, v1);
    }

    entry fun deposit<T0>(arg0: &mut State, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        if (!0x2::bag::contains<address>(&arg0.balances, v2)) {
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), arg1);
    }

    fun get_balance_mut<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        let v2 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        assert!(0x2::bag::contains<address>(arg0, v2), 106);
        0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(arg0, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id                : 0x2::object::new(arg0),
            version           : 1,
            owner             : v0,
            operator          : v0,
            token_holder      : v0,
            pool_whitelist    : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pool_positions    : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            pool_tick_limits  : 0x2::table::new<0x2::object::ID, TickLimits>(arg0),
            pool_price_limits : 0x2::table::new<0x2::object::ID, PriceLimits>(arg0),
            balances          : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<State>(v1);
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::get_with_original_ids<State>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    entry fun set_operator(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.operator = arg1;
        let v0 = SetOperator{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<SetOperator>(v0);
    }

    entry fun set_pool_price_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1);
        };
        let v0 = PriceLimits{
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::table::add<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1, v0);
        let v1 = SetPoolPriceLimits{
            pool                 : arg1,
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::event::emit<SetPoolPriceLimits>(v1);
    }

    entry fun set_pool_tick_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1);
        };
        let v0 = TickLimits{
            tick_lowest_idx   : arg2,
            tick_upperest_idx : arg3,
        };
        0x2::table::add<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1, v0);
        let v1 = SetPoolTickLimits{
            pool              : arg1,
            tick_lowest_idx   : arg2,
            tick_upperest_idx : arg3,
        };
        0x2::event::emit<SetPoolTickLimits>(v1);
    }

    entry fun set_pool_whitelist(arg0: &mut State, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, arg1)) {
            if (!arg2) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1);
            };
        } else if (arg2) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1, true);
        };
        let v0 = SetPoolWhitelist{
            pool     : arg1,
            accepted : arg2,
        };
        0x2::event::emit<SetPoolWhitelist>(v0);
    }

    entry fun set_token_holder(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.token_holder = arg1;
        let v0 = SetTokenHolder{
            old_token_holder : arg0.token_holder,
            new_token_holder : arg1,
        };
        0x2::event::emit<SetTokenHolder>(v0);
    }

    entry fun transfer_ownership(arg0: &mut State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::package::upgrade_package(&arg2);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 103);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.owner = arg1;
        let v1 = TransferOwnership{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TransferOwnership>(v1);
    }

    entry fun withdraw<T0>(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = &mut arg0.balances;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(get_balance_mut<T0>(v0), arg1, arg2), arg0.token_holder);
    }

    // decompiled from Move bytecode v6
}

