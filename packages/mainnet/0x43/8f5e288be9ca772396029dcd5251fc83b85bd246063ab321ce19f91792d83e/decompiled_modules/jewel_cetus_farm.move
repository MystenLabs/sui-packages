module 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_farm {
    struct CetusPositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SharesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateFarmEvent has copy, drop {
        sender: address,
        farm_pool_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        sender: address,
        farm_pool_id: 0x2::object::ID,
        base_position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        delta_cetus_liquidity: u128,
        delta_base_liquidity: u128,
    }

    struct RemoveLiquidityEvent has copy, drop {
        sender: address,
        farm_pool_id: 0x2::object::ID,
        base_position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        delta_cetus_liquidity: u128,
        delta_base_liquidity: u128,
    }

    struct FarmPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        cetus_pool_address: address,
        cetus_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        total_liquidity: u128,
        last_position_index: u64,
        surplus_balance_a: 0x2::balance::Balance<T0>,
        surplus_balance_b: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun new<T0, T1>(arg0: &mut AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = FarmPool<T0, T1>{
            id                  : 0x2::object::new(arg5),
            cetus_pool_address  : 0x2::object::id_to_address(&v1),
            cetus_position      : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            total_liquidity     : 0,
            last_position_index : 0,
            surplus_balance_a   : 0x2::balance::zero<T0>(),
            surplus_balance_b   : 0x2::balance::zero<T1>(),
        };
        let v3 = CetusPositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v2.id, v3, v0);
        let v4 = SharesKey{dummy_field: false};
        0x2::dynamic_field::add<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&mut v2.id, v4, 0x2::table::new<0x2::object::ID, u128>(arg5));
        0x2::object::id<FarmPool<T0, T1>>(&v2);
        0x2::transfer::share_object<FarmPool<T0, T1>>(v2);
    }

    public entry fun add_coin_a_to_surplus<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.surplus_balance_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun add_coin_b_to_surplus<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.surplus_balance_b, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun add_initial_liquidity<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_migrated<T0, T1>(arg0), 125);
        let v0 = get_next_position_index<T0, T1>(arg0);
        let v1 = 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::create(v0, 0x2::object::id<FarmPool<T0, T1>>(arg0), arg7);
        let v2 = SharesKey{dummy_field: false};
        0x2::table::add<0x2::object::ID, u128>(0x2::dynamic_field::borrow_mut<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.id, v2), 0x2::object::id<0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position>(&v1), 0);
        let v3 = &mut v1;
        do_add_liquidity<T0, T1>(arg0, v3, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7);
        0x2::transfer::public_transfer<0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &mut 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        do_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8);
    }

    public entry fun add_rewards<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = cetus_pos_mut<T0, T1>(arg0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, v2, arg5, arg6);
        let v4 = 0x2::balance::value<T0>(&v0);
        let v5 = 0x2::balance::value<T1>(&v1);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        assert!(v4 >= v6, 106);
        assert!(v5 >= v7, 107);
        if (v4 > v6) {
            0x2::balance::join<T0>(&mut arg0.surplus_balance_a, 0x2::balance::split<T0>(&mut v0, v4 - v6));
        };
        if (v5 > v7) {
            0x2::balance::join<T1>(&mut arg0.surplus_balance_b, 0x2::balance::split<T1>(&mut v1, v5 - v7));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, v0, v1, v3);
    }

    fun cetus_pos<T0, T1>(arg0: &FarmPool<T0, T1>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        if (is_migrated<T0, T1>(arg0)) {
            let v1 = CetusPositionKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, v1)
        } else {
            0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.cetus_position)
        }
    }

    fun cetus_pos_mut<T0, T1>(arg0: &mut FarmPool<T0, T1>) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        if (is_migrated<T0, T1>(arg0)) {
            let v1 = CetusPositionKey{dummy_field: false};
            0x2::dynamic_object_field::borrow_mut<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v1)
        } else {
            0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_position)
        }
    }

    fun cetus_repay_add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x2::balance::value<T1>(&arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 >= v2, 106);
        assert!(v1 >= v3, 107);
        let v4 = if (v0 > v2) {
            0x2::balance::split<T0>(&mut arg3, v0 - v2)
        } else {
            0x2::balance::zero<T0>()
        };
        let v5 = if (v1 > v3) {
            0x2::balance::split<T1>(&mut arg4, v1 - v3)
        } else {
            0x2::balance::zero<T1>()
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, arg3, arg4, arg2);
        (v4, v5)
    }

    fun checked_shares<T0, T1>(arg0: &FarmPool<T0, T1>, arg1: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position) : u128 {
        assert!(is_migrated<T0, T1>(arg0), 125);
        assert!(0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::get_farm_pool_id(arg1) == 0x2::object::id<FarmPool<T0, T1>>(arg0), 104);
        let v0 = SharesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&arg0.id, v0);
        let v2 = 0x2::object::id<0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, u128>(v1, v2), 126);
        *0x2::table::borrow<0x2::object::ID, u128>(v1, v2)
    }

    public fun collect_fee<T0, T1>(arg0: &mut AdminCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, cetus_pos<T0, T1>(arg1), true)
    }

    public entry fun collect_fee_and_keep<T0, T1>(arg0: &mut AdminCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, cetus_pos<T0, T1>(arg1), true);
        0x2::balance::join<T0>(&mut arg1.surplus_balance_a, v0);
        0x2::balance::join<T1>(&mut arg1.surplus_balance_b, v1);
    }

    public entry fun collect_fee_and_keep_v2<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, cetus_pos<T0, T1>(arg1), true);
        0x2::balance::join<T0>(&mut arg1.surplus_balance_a, v0);
        0x2::balance::join<T1>(&mut arg1.surplus_balance_b, v1);
    }

    public fun collect_fee_v2<T0, T1>(arg0: &mut 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, cetus_pos<T0, T1>(arg1), true)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut AdminCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, cetus_pos<T0, T1>(arg1), arg4, true, arg5), arg6)
    }

    public entry fun collect_reward_and_keep<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: bool) {
        if (arg5) {
            0x2::balance::join<T0>(&mut arg0.surplus_balance_a, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg1, arg2, cetus_pos<T0, T1>(arg0), arg3, true, arg4));
        } else {
            0x2::balance::join<T1>(&mut arg0.surplus_balance_b, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg2, cetus_pos<T0, T1>(arg0), arg3, true, arg4));
        };
    }

    public fun collect_reward_v2<T0, T1, T2>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, cetus_pos<T0, T1>(arg1), arg4, true, arg5), arg6)
    }

    public entry fun collect_reward_v3<T0, T1, T2>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, cetus_pos<T0, T1>(arg1), arg4, true, arg5), arg6), 0x2::tx_context::sender(arg6));
    }

    fun do_add_liquidity<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &mut 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = checked_shares<T0, T1>(arg0, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(cetus_pos<T0, T1>(arg0));
        let v2 = arg0.total_liquidity;
        let v3 = 0x2::balance::value<T0>(&arg4);
        let v4 = 0x2::balance::value<T1>(&arg5);
        let v5 = cetus_pos_mut<T0, T1>(arg0);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg2, arg3, v5, arg6, arg7);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
        assert!(v3 >= v7, 106);
        assert!(v4 >= v8, 107);
        if (v3 > v7) {
            0x2::balance::join<T0>(&mut arg0.surplus_balance_a, 0x2::balance::split<T0>(&mut arg4, v3 - v7));
        };
        if (v4 > v8) {
            0x2::balance::join<T1>(&mut arg0.surplus_balance_b, 0x2::balance::split<T1>(&mut arg5, v4 - v8));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, arg4, arg5, v6);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(cetus_pos<T0, T1>(arg0));
        let v10 = if (v9 >= v1) {
            v9 - v1
        } else {
            0
        };
        let v11 = if (v1 == 0) {
            v10
        } else {
            v2 * v10 / v1
        };
        assert!(v11 > 0, 128);
        set_shares<T0, T1>(arg0, arg1, v0 + v11);
        arg0.total_liquidity = arg0.total_liquidity + v11;
    }

    fun get_next_position_index<T0, T1>(arg0: &mut FarmPool<T0, T1>) : u64 {
        arg0.last_position_index = arg0.last_position_index + 1;
        arg0.last_position_index
    }

    public fun is_migrated<T0, T1>(arg0: &FarmPool<T0, T1>) : bool {
        let v0 = CetusPositionKey{dummy_field: false};
        0x2::dynamic_object_field::exists_<CetusPositionKey>(&arg0.id, v0)
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public entry fun migrate_farm<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!is_migrated<T0, T1>(arg0), 130);
        assert!(arg0.total_liquidity == 0, 129);
        let v0 = CetusPositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, v0, 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_position));
        let v1 = SharesKey{dummy_field: false};
        0x2::dynamic_field::add<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.id, v1, 0x2::table::new<0x2::object::ID, u128>(arg1));
    }

    public entry fun new_v2<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = FarmPool<T0, T1>{
            id                  : 0x2::object::new(arg5),
            cetus_pool_address  : 0x2::object::id_to_address(&v1),
            cetus_position      : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            total_liquidity     : 0,
            last_position_index : 0,
            surplus_balance_a   : 0x2::balance::zero<T0>(),
            surplus_balance_b   : 0x2::balance::zero<T1>(),
        };
        let v3 = CetusPositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<CetusPositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v2.id, v3, v0);
        let v4 = SharesKey{dummy_field: false};
        0x2::dynamic_field::add<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&mut v2.id, v4, 0x2::table::new<0x2::object::ID, u128>(arg5));
        0x2::object::id<FarmPool<T0, T1>>(&v2);
        0x2::transfer::share_object<FarmPool<T0, T1>>(v2);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &mut 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = checked_shares<T0, T1>(arg0, arg1);
        assert!(arg5 > 0, 127);
        assert!(arg5 <= v0, 105);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(cetus_pos<T0, T1>(arg0)) * arg5 / arg0.total_liquidity;
        set_shares<T0, T1>(arg0, arg1, v0 - arg5);
        let v2 = cetus_pos_mut<T0, T1>(arg0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v2, v1, arg4);
        arg0.total_liquidity = arg0.total_liquidity - arg5;
        (0x2::coin::from_balance<T0>(v3, arg6), 0x2::coin::from_balance<T1>(v4, arg6))
    }

    fun set_shares<T0, T1>(arg0: &mut FarmPool<T0, T1>, arg1: &mut 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position, arg2: u128) {
        let v0 = SharesKey{dummy_field: false};
        *0x2::table::borrow_mut<0x2::object::ID, u128>(0x2::dynamic_field::borrow_mut<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.id, v0), 0x2::object::id<0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::Position>(arg1)) = arg2;
        0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position::set_liquidity(arg1, arg2);
    }

    public fun shares_of<T0, T1>(arg0: &FarmPool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        if (!is_migrated<T0, T1>(arg0)) {
            return 0
        };
        let v0 = SharesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<SharesKey, 0x2::table::Table<0x2::object::ID, u128>>(&arg0.id, v0);
        if (0x2::table::contains<0x2::object::ID, u128>(v1, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u128>(v1, arg1)
        } else {
            0
        }
    }

    public fun withdraw_surplus_a<T0, T1>(arg0: &mut AdminCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.surplus_balance_a), arg2)
    }

    public fun withdraw_surplus_a_v2<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.surplus_balance_a), arg2)
    }

    public entry fun withdraw_surplus_a_v3<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.surplus_balance_a), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_surplus_b<T0, T1>(arg0: &mut AdminCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.surplus_balance_b), arg2)
    }

    public fun withdraw_surplus_b_v2<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.surplus_balance_b), arg2)
    }

    public entry fun withdraw_surplus_b_v3<T0, T1>(arg0: &0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::ownership::OperatorCap, arg1: &mut FarmPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.surplus_balance_b), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

