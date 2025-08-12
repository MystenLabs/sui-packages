module 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        controls: PoolControls,
        maintainer: address,
        oracle_config: PoolOracleConfig,
        base_coin_decimals: u8,
        quote_coin_decimals: u8,
        core_data: PoolCoreData,
        coins: PoolCoins<T0, T1>,
        tx_data: PoolTxData,
    }

    struct PoolControls has store {
        closed: bool,
        deposit_base_allowed: bool,
        deposit_quote_allowed: bool,
        trade_allowed: bool,
        buying_allowed: bool,
        selling_allowed: bool,
        base_balance_limit: u64,
        quote_balance_limit: u64,
    }

    struct PoolOracleConfig has store {
        base_price_id: vector<u8>,
        base_usd_price_age: u64,
    }

    struct PoolTxData has store {
        quote_usd_price: u64,
        trade_num: u64,
        liquidity_change_num: u64,
        in_rebalance: bool,
        init_base_balance: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64,
        init_quote_balance: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::I64,
        last_operate_base_balance: u64,
        last_operate_quote_balance: u64,
        last_rebalance_base_balance: u64,
        last_rebalance_quote_balance: u64,
    }

    struct PoolCoins<phantom T0, phantom T1> has store {
        base_coin: 0x2::balance::Balance<T0>,
        quote_coin: 0x2::balance::Balance<T1>,
        base_capital_coin_supply: 0x2::balance::Supply<BasePoolLiquidityCoin<T0, T1>>,
        quote_capital_coin_supply: 0x2::balance::Supply<QuotePoolLiquidityCoin<T0, T1>>,
    }

    struct PoolCoreData has store {
        k_deviation_tiers: vector<u64>,
        deviation_thresholds: vector<u64>,
        k_without_deviation: u64,
        base_balance: u64,
        quote_balance: u64,
    }

    struct BasePoolLiquidityCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct QuotePoolLiquidityCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolVersionUpdated has copy, drop {
        operator: address,
        old_version: u64,
        new_version: u64,
    }

    struct AddPoolEvent has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        base_coin_type: 0x1::string::String,
        quote_coin_type: 0x1::string::String,
        base_coin_decimals: u8,
        quote_coin_decimals: u8,
        k_without_deviation: u64,
    }

    struct UpdateKWithoutDeviationEvent has copy, drop {
        pool_id: 0x2::object::ID,
        operator: address,
        old_k_without_deviation: u64,
        new_k_without_deviation: u64,
    }

    struct TokenUpdateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_base_coin_update: bool,
        is_increase: bool,
        amount: u64,
    }

    struct UpdateKDeviationTiersAndDeviationThresholdEvent has copy, drop {
        pool_id: 0x2::object::ID,
        new_k_deviation_tiers: vector<u64>,
        new_deviation_thresholds: vector<u64>,
    }

    struct LiquidityOperateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
    }

    struct UpdateQuotePriceEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    struct SetTradingAllowedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        new_trading_allowed: bool,
    }

    struct ClaimAssetsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        base_coin_amount: u64,
        quote_coin_amount: u64,
        liquidity_change_num: u64,
    }

    public(friend) fun add_init_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        arg0.tx_data.init_base_balance = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::add(arg0.tx_data.init_base_balance, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from_u64(arg1));
        arg0.tx_data.init_quote_balance = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::add(arg0.tx_data.init_quote_balance, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from_u64(arg2));
    }

    public fun add_pool<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::assert_version(arg0);
        let v0 = 0x2::coin::get_decimals<T0>(arg1);
        let v1 = 0x2::coin::get_decimals<T1>(arg2);
        let v2 = make_pool<T0, T1>(v0, v1, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x2::object::id<Pool<T0, T1>>(&v2);
        check_parameters<T0, T1>(&v2);
        let (v4, v5, v6) = get_coin_types<T0, T1>();
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::register_pool(arg0, 0x1::string::from_ascii(v6), v3);
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        let v7 = AddPoolEvent{
            sender              : 0x2::tx_context::sender(arg7),
            pool_id             : v3,
            base_coin_type      : 0x1::string::from_ascii(v4),
            quote_coin_type     : 0x1::string::from_ascii(v5),
            base_coin_decimals  : v0,
            quote_coin_decimals : v1,
            k_without_deviation : arg5,
        };
        0x2::event::emit<AddPoolEvent>(v7);
    }

    public fun assert_buying_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.controls.buying_allowed, 10);
    }

    public fun assert_closed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(get_closed<T0, T1>(arg0), 13);
    }

    public fun assert_deposit_base_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.controls.deposit_base_allowed, 3);
    }

    public fun assert_deposit_quote_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.controls.deposit_quote_allowed, 4);
    }

    public fun assert_not_closed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(!get_closed<T0, T1>(arg0), 12);
    }

    public fun assert_selling_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.controls.selling_allowed, 11);
    }

    public fun assert_trade_allowed<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.controls.trade_allowed, 9);
    }

    public fun assert_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.version == 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::version::get_program_version(), 15);
    }

    public(friend) fun base_coin_pay_in<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.core_data.base_balance = get_base_balance<T0, T1>(arg0) + v0;
        assert!(get_base_balance<T0, T1>(arg0) <= get_base_balance_limit<T0, T1>(arg0), 7);
        0x2::balance::join<T0>(&mut arg0.coins.base_coin, arg1);
        let v1 = TokenUpdateEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_base_coin_update : true,
            is_increase         : true,
            amount              : v0,
        };
        0x2::event::emit<TokenUpdateEvent>(v1);
    }

    public(friend) fun base_coin_pay_out<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.core_data.base_balance = get_base_balance<T0, T1>(arg0) - arg1;
        let v0 = TokenUpdateEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_base_coin_update : true,
            is_increase         : false,
            amount              : arg1,
        };
        0x2::event::emit<TokenUpdateEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coins.base_coin, arg1), arg2)
    }

    public(friend) fun burn_base_capital_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<BasePoolLiquidityCoin<T0, T1>>) {
        0x2::balance::decrease_supply<BasePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.base_capital_coin_supply, arg1);
    }

    public(friend) fun burn_quote_capital_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<QuotePoolLiquidityCoin<T0, T1>>) {
        0x2::balance::decrease_supply<QuotePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.quote_capital_coin_supply, arg1);
    }

    fun calculate_deviation(arg0: u64, arg1: u64) : (u64, bool) {
        let v0 = if (arg1 >= arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        (v0, arg1 >= arg0)
    }

    fun calculate_deviation_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (vector<u64>, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        while (v0 < 0x1::vector::length<u64>(&arg0.core_data.deviation_thresholds)) {
            let v3 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(*0x1::vector::borrow<u64>(&arg0.core_data.deviation_thresholds, v0), arg1, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one());
            0x1::vector::push_back<u64>(&mut v2, v3);
            let v4 = if (v0 == 0) {
                v3
            } else {
                v3 - *0x1::vector::borrow<u64>(&v2, v0 - 1)
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    fun calculate_k_tier_amounts(arg0: u64, arg1: u64, arg2: bool, arg3: &vector<u64>, arg4: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg3);
        let v1 = 0;
        if (!arg2) {
            let v2 = v0 - 1;
            while (v2 >= 0) {
                if (arg1 > *0x1::vector::borrow<u64>(arg4, v2)) {
                    v1 = v2 + 1;
                    break
                };
                if (v2 == 0) {
                    break
                };
                v2 = v2 - 1;
            };
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        let v5 = arg0;
        if (arg2 && arg0 < arg1 + *0x1::vector::borrow<u64>(arg3, 0)) {
            v4 = arg0;
            v5 = arg0 - arg0;
        } else if (arg2) {
            let v6 = arg1 + *0x1::vector::borrow<u64>(arg3, 0);
            v4 = v6;
            v5 = arg0 - v6;
        } else {
            let v7 = if (!arg2) {
                if (v1 == 0) {
                    arg0 < *0x1::vector::borrow<u64>(arg3, 0) - arg1
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                v4 = arg0;
                v5 = 0;
            } else {
                let v8 = if (!arg2) {
                    if (v1 == 0) {
                        arg0 >= *0x1::vector::borrow<u64>(arg3, 0) - arg1
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v8) {
                    let v9 = *0x1::vector::borrow<u64>(arg3, 0) - arg1;
                    v4 = v9;
                    v5 = arg0 - v9;
                };
            };
        };
        0x1::vector::push_back<u64>(&mut v3, v4);
        let v10 = 0;
        while (v10 < v0) {
            if (v5 == 0) {
                break
            };
            let v11 = v10 + 1;
            if (v1 > v11) {
                0x1::vector::push_back<u64>(&mut v3, 0);
                continue
            };
            if (v11 == v0) {
                0x1::vector::push_back<u64>(&mut v3, v5);
                break
            };
            let v12 = if (v1 == v11) {
                *0x1::vector::borrow<u64>(arg4, v11) - arg1
            } else {
                *0x1::vector::borrow<u64>(arg3, v10)
            };
            if (v5 > v12) {
                0x1::vector::push_back<u64>(&mut v3, v12);
                v5 = v5 - v12;
            } else {
                0x1::vector::push_back<u64>(&mut v3, v5);
                v5 = 0;
            };
            v10 = v10 + 1;
        };
        v3
    }

    fun calculate_slippage<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64) : u64 {
        let (v0, v1) = get_balances<T0, T1>(arg0, arg2);
        let (v2, v3) = calculate_deviation(v0, v1);
        let (v4, v5) = calculate_deviation_amounts<T0, T1>(arg0, v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = calculate_k_tier_amounts(arg1, v2, v3, &v7, &v6);
        let v9 = if (arg2) {
            v8
        } else {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = 0;
            while (v11 < 0x1::vector::length<u64>(&v8)) {
                0x1::vector::push_back<u64>(&mut v10, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(*0x1::vector::borrow<u64>(&v8, v11), arg3));
                v11 = v11 + 1;
            };
            v10
        };
        let v12 = v9;
        let v13 = get_base_coin_decimals<T0, T1>(arg0);
        let v14 = 0;
        let v15 = 0;
        while (v14 < 0x1::vector::length<u64>(&v12)) {
            let v16 = *0x1::vector::borrow<u64>(&v12, v14);
            let v17 = v16;
            if (v16 > 0) {
                if (v13 > 9) {
                    v17 = v16 / 0x1::u64::pow(10, v13 - 9);
                } else if (v13 < 9) {
                    v17 = v16 * 0x1::u64::pow(10, 9 - v13);
                };
                if (v14 == 0) {
                    v15 = v15 + 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(v17, arg0.core_data.k_without_deviation);
                } else {
                    v15 = v15 + 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(v17, *0x1::vector::borrow<u64>(&arg0.core_data.k_deviation_tiers, v14 - 1));
                };
            };
            v14 = v14 + 1;
        };
        v15
    }

    public fun check_parameters<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::lt_one(get_k_without_deviation<T0, T1>(arg0)), 2);
        assert!(get_k_without_deviation<T0, T1>(arg0) > 0, 2);
    }

    public(friend) fun claim_assets<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_closed<T0, T1>(arg0);
        increase_liquidity_change_num<T0, T1>(arg0);
        let v0 = 0x2::coin::value<QuotePoolLiquidityCoin<T0, T1>>(&arg2);
        let v1 = 0x2::coin::value<BasePoolLiquidityCoin<T0, T1>>(&arg1);
        assert!(v0 > 0 || v1 > 0, 14);
        let v2 = if (v0 > 0) {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(get_quote_balance<T0, T1>(arg0), v0, get_quote_capital_coin_supply<T0, T1>(arg0))
        } else {
            0
        };
        let v3 = if (v1 > 0) {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(get_base_balance<T0, T1>(arg0), v1, get_base_capital_coin_supply<T0, T1>(arg0))
        } else {
            0
        };
        let v4 = base_coin_pay_out<T0, T1>(arg0, v3, arg3);
        let v5 = quote_coin_pay_out<T0, T1>(arg0, v2, arg3);
        0x2::balance::decrease_supply<BasePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.base_capital_coin_supply, 0x2::coin::into_balance<BasePoolLiquidityCoin<T0, T1>>(arg1));
        0x2::balance::decrease_supply<QuotePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.quote_capital_coin_supply, 0x2::coin::into_balance<QuotePoolLiquidityCoin<T0, T1>>(arg2));
        let v6 = ClaimAssetsEvent{
            pool_id              : 0x2::object::id<Pool<T0, T1>>(arg0),
            user                 : 0x2::tx_context::sender(arg3),
            base_coin_amount     : v3,
            quote_coin_amount    : v2,
            liquidity_change_num : get_liquidity_change_num<T0, T1>(arg0),
        };
        0x2::event::emit<ClaimAssetsEvent>(v6);
        (v4, v5)
    }

    public fun compare_a_lt_b_string(arg0: 0x1::string::String, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::into_bytes(arg0);
        let v1 = 0x1::string::into_bytes(arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0x1::u64::min(0x1::vector::length<u8>(&v0), 0x1::vector::length<u8>(&v1));
        let v3 = 0;
        let v4 = false;
        while (v3 < v2) {
            let v5 = 0x1::vector::pop_back<u8>(&mut v0);
            let v6 = 0x1::vector::pop_back<u8>(&mut v1);
            if (v5 != v6) {
                v4 = v5 < v6;
                v3 = v2;
                continue
            };
            v3 = v3 + 1;
        };
        v4
    }

    public(friend) fun decrease_init_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        arg0.tx_data.init_base_balance = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::sub(arg0.tx_data.init_base_balance, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from_u64(arg1));
        arg0.tx_data.init_quote_balance = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::sub(arg0.tx_data.init_quote_balance, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::from_u64(arg2));
    }

    public(friend) fun destroy_pool<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::AdminCap, arg1: &Pool<T0, T1>) {
        assert_closed<T0, T1>(arg1);
        assert!(get_base_balance<T0, T1>(arg1) == 0 || get_quote_balance<T0, T1>(arg1) == 0, 16);
        let (_, _, v2) = get_coin_types<T0, T1>();
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::destroy_pool(arg0, 0x1::string::from_ascii(v2));
    }

    public(friend) fun final_settlement<T0, T1>(arg0: &mut Pool<T0, T1>) {
        assert_not_closed<T0, T1>(arg0);
        arg0.controls.closed = true;
        arg0.controls.deposit_base_allowed = false;
        arg0.controls.deposit_quote_allowed = false;
        arg0.controls.trade_allowed = false;
    }

    fun get_balances<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool) : (u64, u64) {
        let v0 = if (arg1) {
            arg0.tx_data.last_operate_base_balance
        } else {
            arg0.tx_data.last_operate_quote_balance
        };
        let v1 = if (arg1) {
            arg0.core_data.base_balance
        } else {
            arg0.core_data.quote_balance
        };
        (v0, v1)
    }

    public fun get_base_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.core_data.base_balance
    }

    public fun get_base_balance_limit<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.controls.base_balance_limit
    }

    public fun get_base_capital_coin_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<BasePoolLiquidityCoin<T0, T1>>(&arg0.coins.base_capital_coin_supply)
    }

    public fun get_base_coin_decimals<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.base_coin_decimals
    }

    public fun get_base_one<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1::u64::pow(10, get_base_coin_decimals<T0, T1>(arg0))
    }

    public fun get_base_price_id<T0, T1>(arg0: &Pool<T0, T1>) : vector<u8> {
        arg0.oracle_config.base_price_id
    }

    public fun get_base_usd_price_age<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.oracle_config.base_usd_price_age
    }

    public fun get_closed<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.controls.closed
    }

    public fun get_coin_types<T0, T1>() : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = if (compare_a_lt_b_string(0x1::string::from_ascii(v0), 0x1::string::from_ascii(v1))) {
            let v2 = v0;
            0x1::ascii::append(&mut v2, v1);
            v2
        } else {
            let v2 = v1;
            0x1::ascii::append(&mut v2, v0);
            v2
        };
        (v0, v1, v2)
    }

    public fun get_in_rebalance<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.tx_data.in_rebalance
    }

    public fun get_k_without_deviation<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.core_data.k_without_deviation
    }

    public fun get_liquidity_change_num<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tx_data.liquidity_change_num
    }

    public fun get_lp_base_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = get_base_capital_coin_supply<T0, T1>(arg0);
        if (v0 == 0) {
            0
        } else {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(arg1, get_base_balance<T0, T1>(arg0), v0)
        }
    }

    public fun get_lp_quote_balance<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = get_quote_capital_coin_supply<T0, T1>(arg0);
        if (v0 == 0) {
            0
        } else {
            0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(arg1, get_quote_balance<T0, T1>(arg0), v0)
        }
    }

    public fun get_maintainer<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.maintainer
    }

    public fun get_quote_balance<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.core_data.quote_balance
    }

    public fun get_quote_balance_limit<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.controls.quote_balance_limit
    }

    public fun get_quote_capital_coin_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<QuotePoolLiquidityCoin<T0, T1>>(&arg0.coins.quote_capital_coin_supply)
    }

    public fun get_quote_coin_decimals<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.quote_coin_decimals
    }

    public fun get_quote_one<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1::u64::pow(10, get_quote_coin_decimals<T0, T1>(arg0))
    }

    public fun get_quote_usd_price<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tx_data.quote_usd_price
    }

    public fun get_trade_num<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.tx_data.trade_num
    }

    public(friend) fun increase_liquidity_change_num<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.tx_data.liquidity_change_num = arg0.tx_data.liquidity_change_num + 1;
    }

    public(friend) fun increase_trade_num<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.tx_data.trade_num = arg0.tx_data.trade_num + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::ownable::grant_admin_cap(0x2::tx_context::sender(arg0), arg0);
    }

    fun make_pool<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = BasePoolLiquidityCoin<T0, T1>{dummy_field: false};
        let v1 = QuotePoolLiquidityCoin<T0, T1>{dummy_field: false};
        let v2 = PoolOracleConfig{
            base_price_id      : arg3,
            base_usd_price_age : arg5,
        };
        let v3 = PoolControls{
            closed                : false,
            deposit_base_allowed  : false,
            deposit_quote_allowed : false,
            trade_allowed         : false,
            buying_allowed        : true,
            selling_allowed       : true,
            base_balance_limit    : 18446744073709551615,
            quote_balance_limit   : 18446744073709551615,
        };
        let v4 = PoolCoreData{
            k_deviation_tiers    : 0x1::vector::empty<u64>(),
            deviation_thresholds : 0x1::vector::empty<u64>(),
            k_without_deviation  : arg4,
            base_balance         : 0,
            quote_balance        : 0,
        };
        let v5 = PoolCoins<T0, T1>{
            base_coin                 : 0x2::balance::zero<T0>(),
            quote_coin                : 0x2::balance::zero<T1>(),
            base_capital_coin_supply  : 0x2::balance::create_supply<BasePoolLiquidityCoin<T0, T1>>(v0),
            quote_capital_coin_supply : 0x2::balance::create_supply<QuotePoolLiquidityCoin<T0, T1>>(v1),
        };
        let v6 = PoolTxData{
            quote_usd_price              : 0,
            trade_num                    : 0,
            liquidity_change_num         : 0,
            in_rebalance                 : false,
            init_base_balance            : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::zero(),
            init_quote_balance           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i64::zero(),
            last_operate_base_balance    : 0,
            last_operate_quote_balance   : 0,
            last_rebalance_base_balance  : 0,
            last_rebalance_quote_balance : 0,
        };
        Pool<T0, T1>{
            id                  : 0x2::object::new(arg6),
            version             : 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::version::get_program_version(),
            controls            : v3,
            maintainer          : arg2,
            oracle_config       : v2,
            base_coin_decimals  : arg0,
            quote_coin_decimals : arg1,
            core_data           : v4,
            coins               : v5,
            tx_data             : v6,
        }
    }

    public(friend) fun migrate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::version::get_program_version();
        assert!(arg0.version < v0, 15);
        let v1 = PoolVersionUpdated{
            operator    : 0x2::tx_context::sender(arg1),
            old_version : arg0.version,
            new_version : v0,
        };
        0x2::event::emit<PoolVersionUpdated>(v1);
        arg0.version = v0;
    }

    public(friend) fun mint_base_capital<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BasePoolLiquidityCoin<T0, T1>> {
        base_coin_pay_in<T0, T1>(arg0, arg1);
        0x2::coin::from_balance<BasePoolLiquidityCoin<T0, T1>>(0x2::balance::increase_supply<BasePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.base_capital_coin_supply, arg2), arg3)
    }

    public(friend) fun mint_quote_capital<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<QuotePoolLiquidityCoin<T0, T1>> {
        quote_coin_pay_in<T0, T1>(arg0, arg1);
        0x2::coin::from_balance<QuotePoolLiquidityCoin<T0, T1>>(0x2::balance::increase_supply<QuotePoolLiquidityCoin<T0, T1>>(&mut arg0.coins.quote_capital_coin_supply, arg2), arg3)
    }

    public fun query_buy_base_coin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        query_buy_base_coin_internal<T0, T1>(arg0, arg1, arg3)
    }

    fun query_buy_base_coin_internal<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(arg2, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one() + calculate_slippage<T0, T1>(arg0, arg2, true, 0)), arg1)
    }

    public fun query_sell_base_coin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        query_sell_base_coin_internal<T0, T1>(arg0, arg1, arg3)
    }

    fun query_sell_base_coin_internal<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(arg2, arg1, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one() + calculate_slippage<T0, T1>(arg0, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(arg2, arg1), false, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one(), 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one(), arg1)))
    }

    public fun query_sell_quote_coin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        query_sell_quote_coin_internal<T0, T1>(arg0, arg1, arg3)
    }

    fun query_sell_quote_coin_internal<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::safe_mul_div_u64(arg2, arg1, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::get_one() + calculate_slippage<T0, T1>(arg0, 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::safe_math::mul(arg2, arg1), true, 0))
    }

    public(friend) fun quote_coin_pay_in<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        arg0.core_data.quote_balance = get_quote_balance<T0, T1>(arg0) + v0;
        assert!(get_quote_balance<T0, T1>(arg0) <= get_quote_balance_limit<T0, T1>(arg0), 8);
        0x2::balance::join<T1>(&mut arg0.coins.quote_coin, arg1);
        let v1 = TokenUpdateEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_base_coin_update : false,
            is_increase         : true,
            amount              : v0,
        };
        0x2::event::emit<TokenUpdateEvent>(v1);
    }

    public(friend) fun quote_coin_pay_out<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg0.core_data.quote_balance = get_quote_balance<T0, T1>(arg0) - arg1;
        let v0 = TokenUpdateEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            is_base_coin_update : false,
            is_increase         : false,
            amount              : arg1,
        };
        0x2::event::emit<TokenUpdateEvent>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coins.quote_coin, arg1), arg2)
    }

    public(friend) fun return_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun set_base_balance_limit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.controls.base_balance_limit = arg1;
    }

    public(friend) fun set_base_usd_price_age<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.oracle_config.base_usd_price_age = arg1;
    }

    public(friend) fun set_buying_allowed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.controls.buying_allowed = arg1;
    }

    public(friend) fun set_deposit_base_allowed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.controls.deposit_base_allowed = arg1;
    }

    public(friend) fun set_deposit_quote_allowed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.controls.deposit_quote_allowed = arg1;
    }

    public(friend) fun set_in_rebalance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.tx_data.in_rebalance = arg1;
    }

    public(friend) fun set_k<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = UpdateKWithoutDeviationEvent{
            pool_id                 : 0x2::object::id<Pool<T0, T1>>(arg0),
            operator                : 0x2::tx_context::sender(arg2),
            old_k_without_deviation : arg0.core_data.k_without_deviation,
            new_k_without_deviation : arg1,
        };
        0x2::event::emit<UpdateKWithoutDeviationEvent>(v0);
        arg0.core_data.k_without_deviation = arg1;
        check_parameters<T0, T1>(arg0);
    }

    public(friend) fun set_k_tiers<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u64>, arg2: vector<u64>) {
        arg0.core_data.k_deviation_tiers = arg1;
        arg0.core_data.deviation_thresholds = arg2;
        let v0 = UpdateKDeviationTiersAndDeviationThresholdEvent{
            pool_id                  : 0x2::object::id<Pool<T0, T1>>(arg0),
            new_k_deviation_tiers    : arg1,
            new_deviation_thresholds : arg2,
        };
        0x2::event::emit<UpdateKDeviationTiersAndDeviationThresholdEvent>(v0);
    }

    public(friend) fun set_maintainer<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: address) {
        arg0.maintainer = arg1;
    }

    public(friend) fun set_operate_balance<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.tx_data.last_operate_base_balance = get_base_balance<T0, T1>(arg0);
        arg0.tx_data.last_operate_quote_balance = get_quote_balance<T0, T1>(arg0);
        let v0 = LiquidityOperateEvent{
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            base_amount  : get_base_balance<T0, T1>(arg0),
            quote_amount : get_quote_balance<T0, T1>(arg0),
        };
        0x2::event::emit<LiquidityOperateEvent>(v0);
    }

    public(friend) fun set_prices<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.tx_data.quote_usd_price = arg1;
    }

    public(friend) fun set_quote_balance_limit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.controls.quote_balance_limit = arg1;
    }

    public(friend) fun set_quote_usd_price<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        let v0 = UpdateQuotePriceEvent{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_price : arg0.tx_data.quote_usd_price,
            new_price : arg1,
        };
        0x2::event::emit<UpdateQuotePriceEvent>(v0);
        arg0.tx_data.quote_usd_price = arg1;
    }

    public(friend) fun set_rebalance_balance<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.tx_data.last_rebalance_base_balance = get_base_balance<T0, T1>(arg0);
        arg0.tx_data.last_rebalance_quote_balance = get_quote_balance<T0, T1>(arg0);
    }

    public(friend) fun set_selling_allowed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.controls.selling_allowed = arg1;
    }

    public(friend) fun set_trade_allowed<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool) {
        arg0.controls.trade_allowed = arg1;
        let v0 = SetTradingAllowedEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            new_trading_allowed : arg1,
        };
        0x2::event::emit<SetTradingAllowedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

