module 0xdcdfb1631b919b6f57af8d59ae81854150da865d5f481db3307cde0619fc5bad::dextrader {
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
        pool_positons: 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        balances: 0x2::bag::Bag,
    }

    entry fun swap<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        get_pool_id<T0, T1>(arg0, arg2);
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

    entry fun add_liquidity<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg7);
        let v0 = &mut arg0.balances;
        let v1 = 0x2::balance::split<T0>(get_balance_mut<T0>(v0), arg3);
        let v2 = &mut arg0.balances;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v1, 0x2::balance::split<T1>(get_balance_mut<T1>(v2), arg4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, get_pool_id<T0, T1>(arg0, arg2)), arg5, arg6));
    }

    entry fun close_position<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg3);
        let v0 = get_pool_id<T0, T1>(arg0, arg2);
        let v1 = 0x2::table::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1) > 0, 106);
        let v2 = ClosePosition{
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            pool        : v0,
        };
        0x2::event::emit<ClosePosition>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v1);
    }

    entry fun collect_fee<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg3);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, get_pool_id<T0, T1>(arg0, arg2)), true);
        let v2 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v2), v0);
        let v3 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v3), v1);
    }

    entry fun collect_reward<T0, T1, T2>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, get_pool_id<T0, T1>(arg0, arg2)), arg3, true, arg4), arg5), arg0.token_holder);
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, get_pool_id<T0, T1>(arg0, arg2));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, v0, arg3, arg4);
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

    fun check_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    entry fun create_position<T0, T1>(arg0: &mut State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.pool_positons, v0), 104);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        let v2 = CreatePosition{
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            pool           : v0,
            tick_lower_idx : arg3,
            tick_upper_idx : arg4,
        };
        0x2::event::emit<CreatePosition>(v2);
        0x2::table::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.pool_positons, v0, v1);
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
        assert!(0x2::bag::contains<address>(arg0, v2), 107);
        0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(arg0, v2)
    }

    fun get_pool_id<T0, T1>(arg0: &State, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.pool_positons, v0), 105);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id             : 0x2::object::new(arg0),
            version        : 1,
            owner          : v0,
            operator       : v0,
            token_holder   : v0,
            pool_whitelist : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pool_positons  : 0x2::table::new<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
            balances       : 0x2::bag::new(arg0),
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

