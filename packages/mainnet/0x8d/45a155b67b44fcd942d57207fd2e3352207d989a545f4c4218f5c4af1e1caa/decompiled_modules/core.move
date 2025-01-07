module 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core {
    struct DEXAdminCap has key {
        id: 0x2::object::UID,
    }

    struct DEXStorage has key {
        id: 0x2::object::UID,
        pools: 0x2::object_bag::ObjectBag,
        fee_to: address,
    }

    struct LPCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Observation has store {
        timestamp: u64,
        balance_x_cumulative: u256,
        balance_y_cumulative: u256,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        k_last: u256,
        lp_coin_supply: 0x2::balance::Supply<LPCoin<T0, T1, T2>>,
        balance_x: 0x2::balance::Balance<T1>,
        balance_y: 0x2::balance::Balance<T2>,
        decimals_x: u64,
        decimals_y: u64,
        is_stable: bool,
        observations: vector<Observation>,
        timestamp_last: u64,
        balance_x_cumulative_last: u256,
        balance_y_cumulative_last: u256,
        locked: bool,
    }

    struct Receipt<phantom T0, phantom T1, phantom T2> {
        pool_id: 0x2::object::ID,
        repay_amount_x: u64,
        repay_amount_y: u64,
        prev_k: u256,
    }

    struct PoolCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        shares: u64,
        value_x: u64,
        value_y: u64,
        sender: address,
    }

    struct SwapTokenX<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        coin_x_in: u64,
        coin_y_out: u64,
    }

    struct SwapTokenY<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        coin_y_in: u64,
        coin_x_out: u64,
    }

    struct AddLiquidity<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        coin_x_amount: u64,
        coin_y_amount: u64,
        shares_minted: u64,
    }

    struct RemoveLiquidity<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        coin_x_out: u64,
        coin_y_out: u64,
        shares_destroyed: u64,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    struct NewFeeTo has copy, drop {
        fee_to: address,
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1, T2>> {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::coin::value<T2>(&arg3);
        let v2 = arg0.fee_to;
        let v3 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v3.locked, 18);
        let v4 = mint_fee<T0, T1, T2>(v3, v2, arg5);
        assert!(v0 != 0 && v1 != 0, 6);
        let (v5, v6, v7) = get_amounts<T0, T1, T2>(v3);
        let (v8, v9) = calculate_optimal_add_liquidity(v0, v1, v5, v6);
        if (v0 > v8) {
            0x2::pay::split_and_transfer<T1>(&mut arg2, v0 - v8, 0x2::tx_context::sender(arg5), arg5);
        };
        if (v1 > v9) {
            0x2::pay::split_and_transfer<T2>(&mut arg3, v1 - v9, 0x2::tx_context::sender(arg5), arg5);
        };
        let v10 = 0x2::math::min(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::mul_div(v0, v7, v5), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::mul_div(v1, v7, v6));
        assert!(v10 >= arg4, 5);
        let v11 = AddLiquidity<Pool<T0, T1, T2>>{
            id            : 0x2::object::uid_to_inner(&v3.id),
            sender        : 0x2::tx_context::sender(arg5),
            coin_x_amount : v0,
            coin_y_amount : v1,
            shares_minted : v10,
        };
        0x2::event::emit<AddLiquidity<Pool<T0, T1, T2>>>(v11);
        if (v4) {
            v3.k_last = k<T0>(0x2::balance::join<T1>(&mut v3.balance_x, 0x2::coin::into_balance<T1>(arg2)), 0x2::balance::join<T2>(&mut v3.balance_y, 0x2::coin::into_balance<T2>(arg3)), v3.decimals_x, v3.decimals_y);
        };
        let v12 = 0x2::coin::from_balance<LPCoin<T0, T1, T2>>(0x2::balance::increase_supply<LPCoin<T0, T1, T2>>(&mut v3.lp_coin_supply, v10), arg5);
        sync_obervations<T0, T1, T2>(v3, arg1);
        v12
    }

    fun borrow_mut_pool<T0, T1, T2>(arg0: &mut DEXStorage) : &mut Pool<T0, T1, T2> {
        0x2::object_bag::borrow_mut<0x1::ascii::String, Pool<T0, T1, T2>>(&mut arg0.pools, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::get_coin_info_string<LPCoin<T0, T1, T2>>())
    }

    public fun borrow_pool<T0, T1, T2>(arg0: &DEXStorage) : &Pool<T0, T1, T2> {
        0x2::object_bag::borrow<0x1::ascii::String, Pool<T0, T1, T2>>(&arg0.pools, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::get_coin_info_string<LPCoin<T0, T1, T2>>())
    }

    fun calculate_optimal_add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 && arg3 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::quote_liquidity(arg0, arg2, arg3);
        if (arg1 >= v0) {
            return (arg0, v0)
        };
        (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::quote_liquidity(arg1, arg3, arg2), arg1)
    }

    public fun calculate_s_value_out<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        assert!(!0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>(), 14);
        let v0 = (arg1 as u256);
        let v1 = (arg0.decimals_x as u256);
        let v2 = (arg0.decimals_y as u256);
        let v3 = (arg2 as u256) * 1000000000000000000 / v1;
        let v4 = (arg3 as u256) * 1000000000000000000 / v2;
        let v5 = if (arg4) {
            v1
        } else {
            v2
        };
        let v6 = if (arg4) {
            v4 - y((v0 - v0 * 500000000000000 / 1000000000000000000) * 1000000000000000000 / v5 + v3, k<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable>(arg2, arg3, arg0.decimals_x, arg0.decimals_y), v4)
        } else {
            v3 - y((v0 - v0 * 500000000000000 / 1000000000000000000) * 1000000000000000000 / v5 + v4, k<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable>(arg2, arg3, arg0.decimals_x, arg0.decimals_y), v3)
        };
        let v7 = if (arg4) {
            v2
        } else {
            v1
        };
        ((v6 * v7 / 1000000000000000000) as u64)
    }

    public fun calculate_v_value_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256);
        let v1 = v0 - v0 * 50000000000000000 / 1000000000000000000;
        (((arg2 as u256) * v1 / ((arg1 as u256) + v1)) as u64)
    }

    fun create_pool<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1, T2>> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::coin::value<T2>(&arg3);
        assert!(v0 != 0 && v1 != 0, 1);
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_coins_sorted<T1, T2>(), 4);
        let v2 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::get_coin_info_string<LPCoin<T0, T1, T2>>();
        assert!(!0x2::object_bag::contains<0x1::ascii::String>(&arg0.pools, v2), 2);
        let v3 = (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::sqrt_u256(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::sqrt_u256((v0 as u256) * (v1 as u256))) as u64);
        let v4 = LPCoin<T0, T1, T2>{dummy_field: false};
        let v5 = 0x2::balance::create_supply<LPCoin<T0, T1, T2>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(0x2::coin::from_balance<LPCoin<T0, T1, T2>>(0x2::balance::increase_supply<LPCoin<T0, T1, T2>>(&mut v5, 100), arg7), @0x0);
        let v6 = 0x2::object::new(arg7);
        let v7 = PoolCreated<Pool<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T1, T2>>{
            id      : 0x2::object::uid_to_inner(&v6),
            shares  : v3,
            value_x : v0,
            value_y : v1,
            sender  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<PoolCreated<Pool<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T1, T2>>>(v7);
        let v8 = 0x2::clock::timestamp_ms(arg1);
        let v9 = Pool<T0, T1, T2>{
            id                        : v6,
            k_last                    : k<T0>(v0, v1, arg4, arg5),
            lp_coin_supply            : v5,
            balance_x                 : 0x2::coin::into_balance<T1>(arg2),
            balance_y                 : 0x2::coin::into_balance<T2>(arg3),
            decimals_x                : arg4,
            decimals_y                : arg5,
            is_stable                 : arg6,
            observations              : init_observation_vector(),
            timestamp_last            : v8,
            balance_x_cumulative_last : 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::calculate_cumulative_balance((v0 as u256), v8, 0),
            balance_y_cumulative_last : 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::calculate_cumulative_balance((v1 as u256), v8, 0),
            locked                    : false,
        };
        0x2::object_bag::add<0x1::ascii::String, Pool<T0, T1, T2>>(&mut arg0.pools, v2, v9);
        0x2::coin::from_balance<LPCoin<T0, T1, T2>>(0x2::balance::increase_supply<LPCoin<T0, T1, T2>>(&mut v5, v3), arg7)
    }

    public fun create_s_pool<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable, T0, T1>> {
        create_pool<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable, T0, T1>(arg0, arg1, arg2, arg3, 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg4)), 0x2::math::pow(10, 0x2::coin::get_decimals<T1>(arg5)), true, arg6)
    }

    public fun create_v_pool<T0, T1>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T0, T1>> {
        create_pool<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T0, T1>(arg0, arg1, arg2, arg3, 0, 0, false, arg4)
    }

    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 / 1000000000000000000 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000 * arg1 / 1000000000000000000
    }

    public fun flash_loan<T0, T1, T2>(arg0: &mut DEXStorage, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Receipt<T0, T1, T2>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v0.locked, 18);
        v0.locked = true;
        let (v1, v2, _) = get_amounts<T0, T1, T2>(v0);
        assert!(0x2::balance::value<T1>(&v0.balance_x) >= arg1 && 0x2::balance::value<T2>(&v0.balance_y) >= arg2, 10);
        let v4 = Receipt<T0, T1, T2>{
            pool_id        : 0x2::object::id<Pool<T0, T1, T2>>(v0),
            repay_amount_x : arg1 + (((arg1 as u256) * 5000000000000000 / 1000000000000000000) as u64),
            repay_amount_y : arg2 + (((arg2 as u256) * 5000000000000000 / 1000000000000000000) as u64),
            prev_k         : k<T0>(v1, v2, v0.decimals_x, v0.decimals_y),
        };
        (v4, 0x2::coin::take<T1>(&mut v0.balance_x, arg1, arg3), 0x2::coin::take<T2>(&mut v0.balance_y, arg2, arg3))
    }

    public fun get_amounts<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.balance_x), 0x2::balance::value<T2>(&arg0.balance_y), 0x2::balance::supply_value<LPCoin<T0, T1, T2>>(&arg0.lp_coin_supply))
    }

    public fun get_coin_x_price<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v0.locked, 18);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x1::vector::borrow<Observation>(&v0.observations, get_first_observation_index(v1));
        let v3 = v1 - v2.timestamp;
        assert!(900000 > v3, 15);
        let v4 = v2.balance_x_cumulative;
        let v5 = v2.balance_y_cumulative;
        sync_obervations<T0, T1, T2>(v0, arg1);
        let v6 = if (v4 > v0.balance_x_cumulative_last) {
            v0.balance_x_cumulative_last + 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::max_u_128() - v4
        } else {
            v0.balance_x_cumulative_last - v4
        };
        let v7 = if (v5 > v0.balance_y_cumulative_last) {
            v0.balance_y_cumulative_last + 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::max_u_128() - v5
        } else {
            v0.balance_y_cumulative_last - v5
        };
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>()) {
            calculate_v_value_out(arg2, ((v6 / (v3 as u256)) as u64), ((v7 / (v3 as u256)) as u64))
        } else {
            calculate_s_value_out<T0, T1, T2>(v0, arg2, ((v6 / (v3 as u256)) as u64), ((v7 / (v3 as u256)) as u64), true)
        }
    }

    public fun get_coin_y_price<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v0.locked, 18);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x1::vector::borrow<Observation>(&v0.observations, get_first_observation_index(v1));
        let v3 = v1 - v2.timestamp;
        assert!(900000 > v3, 15);
        let v4 = v2.balance_x_cumulative;
        let v5 = v2.balance_y_cumulative;
        sync_obervations<T0, T1, T2>(v0, arg1);
        let v6 = if (v4 > v0.balance_x_cumulative_last) {
            v0.balance_x_cumulative_last + 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::max_u_128() - v4
        } else {
            v0.balance_x_cumulative_last - v4
        };
        let v7 = if (v5 > v0.balance_y_cumulative_last) {
            v0.balance_y_cumulative_last + 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::max_u_128() - v5
        } else {
            v0.balance_y_cumulative_last - v5
        };
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>()) {
            calculate_v_value_out(arg2, ((v7 / (v3 as u256)) as u64), ((v6 / (v3 as u256)) as u64))
        } else {
            calculate_s_value_out<T0, T1, T2>(v0, arg2, ((v6 / (v3 as u256)) as u64), ((v7 / (v3 as u256)) as u64), false)
        }
    }

    fun get_first_observation_index(arg0: u64) : u64 {
        (observation_index_of(arg0) + 1) % 5
    }

    public fun get_flash_loan_fee_percent() : (u256, u256) {
        (5000000000000000, 1000000000000000000)
    }

    public fun get_pool_cumulative_balances_last<T0, T1, T2>(arg0: &DEXStorage) : (u256, u256) {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_pool<T0, T1, T2>(arg0);
        (v0.balance_x_cumulative_last, v0.balance_y_cumulative_last)
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &DEXStorage) : 0x2::object::ID {
        0x2::object::id<Pool<T0, T1, T2>>(borrow_pool<T0, T1, T2>(arg0))
    }

    public fun get_pool_info<T0, T1, T2>(arg0: &DEXStorage) : (u64, u64, u64) {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_pool<T0, T1, T2>(arg0);
        (0x2::balance::value<T1>(&v0.balance_x), 0x2::balance::value<T2>(&v0.balance_y), 0x2::balance::supply_value<LPCoin<T0, T1, T2>>(&v0.lp_coin_supply))
    }

    public fun get_receipt_data<T0, T1, T2>(arg0: &Receipt<T0, T1, T2>) : (0x2::object::ID, u64, u64, u256) {
        (arg0.pool_id, arg0.repay_amount_x, arg0.repay_amount_y, arg0.prev_k)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DEXAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DEXAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DEXStorage{
            id     : 0x2::object::new(arg0),
            pools  : 0x2::object_bag::new(arg0),
            fee_to : @0xf0da02c49b96f5ab2cf7529cdcb66161581b92b28c421c11692e097c26315151,
        };
        0x2::transfer::share_object<DEXStorage>(v1);
    }

    fun init_observation_vector() : vector<Observation> {
        let v0 = 0x1::vector::empty<Observation>();
        let v1 = Observation{
            timestamp            : 0,
            balance_x_cumulative : 0,
            balance_y_cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v1);
        let v2 = Observation{
            timestamp            : 0,
            balance_x_cumulative : 0,
            balance_y_cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v2);
        let v3 = Observation{
            timestamp            : 0,
            balance_x_cumulative : 0,
            balance_y_cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v3);
        let v4 = Observation{
            timestamp            : 0,
            balance_x_cumulative : 0,
            balance_y_cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v4);
        let v5 = Observation{
            timestamp            : 0,
            balance_x_cumulative : 0,
            balance_y_cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v5);
        v0
    }

    public fun is_pool_deployed<T0, T1, T2>(arg0: &DEXStorage) : bool {
        0x2::object_bag::contains<0x1::ascii::String>(&arg0.pools, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::get_coin_info_string<LPCoin<T0, T1, T2>>())
    }

    fun k<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u256 {
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>()) {
            (arg0 as u256) * (arg1 as u256)
        } else {
            let v1 = (arg0 as u256) * 1000000000000000000 / (arg2 as u256);
            let v2 = (arg1 as u256) * 1000000000000000000 / (arg3 as u256);
            v1 * v2 / 1000000000000000000 * (v1 * v1 / 1000000000000000000 + v2 * v2 / 1000000000000000000) / 1000000000000000000
        }
    }

    fun mint_fee<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg1 != @0x0;
        if (v0) {
            if (arg0.k_last != 0) {
                let v1 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::sqrt_u256(k<T0>(0x2::balance::value<T1>(&arg0.balance_x), 0x2::balance::value<T2>(&arg0.balance_y), arg0.decimals_x, arg0.decimals_y));
                let v2 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::sqrt_u256(arg0.k_last);
                if (v1 > v2) {
                    let v3 = (0x2::balance::supply_value<LPCoin<T0, T1, T2>>(&arg0.lp_coin_supply) as u256) * (v1 - v2) / (v1 * 5 + v2);
                    if (v3 != 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1, T2>>>(0x2::coin::from_balance<LPCoin<T0, T1, T2>>(0x2::balance::increase_supply<LPCoin<T0, T1, T2>>(&mut arg0.lp_coin_supply, (v3 as u64)), arg2), arg1);
                    };
                };
            };
        } else if (arg0.k_last != 0) {
            arg0.k_last = 0;
        };
        v0
    }

    fun observation_index_of(arg0: u64) : u64 {
        arg0 / 180000 % 5
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<LPCoin<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = 0x2::coin::value<LPCoin<T0, T1, T2>>(&arg2);
        assert!(v0 != 0, 7);
        let v1 = arg0.fee_to;
        let v2 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v2.locked, 18);
        let v3 = mint_fee<T0, T1, T2>(v2, v1, arg5);
        let (v4, v5, v6) = get_amounts<T0, T1, T2>(v2);
        let v7 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::mul_div(v0, v4, v6);
        let v8 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::math::mul_div(v0, v5, v6);
        assert!(v7 >= arg3, 8);
        assert!(v8 >= arg4, 9);
        0x2::balance::decrease_supply<LPCoin<T0, T1, T2>>(&mut v2.lp_coin_supply, 0x2::coin::into_balance<LPCoin<T0, T1, T2>>(arg2));
        let v9 = RemoveLiquidity<Pool<T0, T1, T2>>{
            id               : 0x2::object::uid_to_inner(&v2.id),
            sender           : 0x2::tx_context::sender(arg5),
            coin_x_out       : v7,
            coin_y_out       : v8,
            shares_destroyed : v0,
        };
        0x2::event::emit<RemoveLiquidity<Pool<T0, T1, T2>>>(v9);
        if (v3) {
            v2.k_last = k<T0>(v4 - v7, v5 - v8, v2.decimals_x, v2.decimals_y);
        };
        let v10 = 0x2::coin::take<T1>(&mut v2.balance_x, v7, arg5);
        let v11 = 0x2::coin::take<T2>(&mut v2.balance_y, v8, arg5);
        sync_obervations<T0, T1, T2>(v2, arg1);
        (v10, v11)
    }

    public fun repay_flash_loan<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: Receipt<T0, T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>) {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        let Receipt {
            pool_id        : v1,
            repay_amount_x : v2,
            repay_amount_y : v3,
            prev_k         : v4,
        } = arg2;
        assert!(0x2::object::id<Pool<T0, T1, T2>>(v0) == v1, 11);
        assert!(0x2::coin::value<T1>(&arg3) >= v2, 12);
        assert!(0x2::coin::value<T2>(&arg4) >= v3, 13);
        0x2::coin::put<T1>(&mut v0.balance_x, arg3);
        0x2::coin::put<T2>(&mut v0.balance_y, arg4);
        let (v5, v6, _) = get_amounts<T0, T1, T2>(v0);
        assert!(k<T0>(v5, v6, v0.decimals_x, v0.decimals_y) > v4, 17);
        v0.locked = false;
        sync_obervations<T0, T1, T2>(v0, arg1);
    }

    public fun swap_token_x<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        assert!(0x2::coin::value<T1>(&arg2) != 0, 3);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v0.locked, 18);
        let v1 = 0x2::coin::into_balance<T1>(arg2);
        let (v2, v3, _) = get_amounts<T0, T1, T2>(v0);
        let v5 = k<T0>(v2, v3, v0.decimals_x, v0.decimals_y);
        let v6 = 0x2::balance::value<T1>(&v1);
        let v7 = if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>()) {
            calculate_v_value_out(v6, v2, v3)
        } else {
            calculate_s_value_out<T0, T1, T2>(v0, v6, v2, v3, true)
        };
        assert!(v7 >= arg3, 5);
        let v8 = SwapTokenX<T0, T1, T2>{
            id         : 0x2::object::uid_to_inner(&v0.id),
            sender     : 0x2::tx_context::sender(arg4),
            coin_x_in  : v6,
            coin_y_out : v7,
        };
        0x2::event::emit<SwapTokenX<T0, T1, T2>>(v8);
        0x2::balance::join<T1>(&mut v0.balance_x, v1);
        let v9 = 0x2::coin::take<T2>(&mut v0.balance_y, v7, arg4);
        sync_obervations<T0, T1, T2>(v0, arg1);
        let (v10, v11, _) = get_amounts<T0, T1, T2>(v0);
        assert!(k<T0>(v10, v11, v0.decimals_x, v0.decimals_y) > v5, 17);
        v9
    }

    public fun swap_token_y<T0, T1, T2>(arg0: &mut DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_curve<T0>(), 14);
        assert!(0x2::coin::value<T2>(&arg2) != 0, 3);
        let v0 = borrow_mut_pool<T0, T1, T2>(arg0);
        assert!(!v0.locked, 18);
        let v1 = 0x2::coin::into_balance<T2>(arg2);
        let (v2, v3, _) = get_amounts<T0, T1, T2>(v0);
        let v5 = k<T0>(v2, v3, v0.decimals_x, v0.decimals_y);
        let v6 = 0x2::balance::value<T2>(&v1);
        let v7 = if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::is_volatile<T0>()) {
            calculate_v_value_out(v6, v3, v2)
        } else {
            calculate_s_value_out<T0, T1, T2>(v0, v6, v2, v3, false)
        };
        assert!(v7 >= arg3, 5);
        let v8 = SwapTokenY<T0, T1, T2>{
            id         : 0x2::object::uid_to_inner(&v0.id),
            sender     : 0x2::tx_context::sender(arg4),
            coin_y_in  : v6,
            coin_x_out : v7,
        };
        0x2::event::emit<SwapTokenY<T0, T1, T2>>(v8);
        0x2::balance::join<T2>(&mut v0.balance_y, v1);
        let v9 = 0x2::coin::take<T1>(&mut v0.balance_x, v7, arg4);
        sync_obervations<T0, T1, T2>(v0, arg1);
        let (v10, v11, _) = get_amounts<T0, T1, T2>(v0);
        assert!(k<T0>(v10, v11, v0.decimals_x, v0.decimals_y) > v5, 17);
        v9
    }

    fun sync_obervations<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 - arg0.timestamp_last == 0) {
            return
        };
        arg0.timestamp_last = v0;
        let v1 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::calculate_cumulative_balance((0x2::balance::value<T1>(&arg0.balance_x) as u256), v0, arg0.balance_x_cumulative_last);
        let v2 = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::calculate_cumulative_balance((0x2::balance::value<T2>(&arg0.balance_y) as u256), v0, arg0.balance_y_cumulative_last);
        arg0.balance_x_cumulative_last = v1;
        arg0.balance_y_cumulative_last = v2;
        let v3 = 0x1::vector::borrow_mut<Observation>(&mut arg0.observations, observation_index_of(v0));
        if (v0 - v3.timestamp > 180000) {
            v3.timestamp = v0;
            v3.balance_x_cumulative = v1;
            v3.balance_y_cumulative = v2;
        };
    }

    public entry fun transfer_admin_cap(arg0: DEXAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 16);
        0x2::transfer::transfer<DEXAdminCap>(arg0, arg1);
        let v0 = NewAdmin{admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    public entry fun update_fee_to(arg0: &DEXAdminCap, arg1: &mut DEXStorage, arg2: address) {
        arg1.fee_to = arg2;
        let v0 = NewFeeTo{fee_to: arg2};
        0x2::event::emit<NewFeeTo>(v0);
    }

    fun y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            v0 = v0 + 1;
            let v1 = arg2;
            let v2 = f(arg0, arg2);
            if (v2 < arg1) {
                let v3 = (arg1 - v2) * 1000000000000000000 / d(arg0, arg2) + 1;
                arg2 = arg2 + v3;
            } else {
                let v4 = (v2 - arg1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 - v4;
            };
            if (arg2 > v1) {
                if (arg2 - v1 <= 1) {
                    break
                } else {
                    continue
                };
            };
            if (v1 - arg2 <= 1) {
                break
            };
        };
        arg2
    }

    // decompiled from Move bytecode v6
}

