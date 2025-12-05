module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Mint has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct Burn has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct Swap has copy, drop {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_a_in: u64,
        amount_b_in: u64,
        amount_a_out: u64,
        amount_b_out: u64,
    }

    struct PoolLiquidityCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        version: u8,
        stable: bool,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        decimals_a: u8,
        decimals_b: u8,
        lp_locked: 0x2::balance::Balance<PoolLiquidityCoin<T0, T1, T2>>,
        lp_supply: 0x2::balance::Supply<PoolLiquidityCoin<T0, T1, T2>>,
        fee_vault: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::FeeVault<T0, T1, T2>,
        custom_fee: 0x1::option::Option<u64>,
    }

    struct PoolState has copy, drop {
        id: 0x2::object::ID,
        stable: bool,
        coin_a_type: 0x1::type_name::TypeName,
        coin_b_type: 0x1::type_name::TypeName,
        coin_a_balance: u64,
        coin_b_balance: u64,
        decimals_a: u8,
        decimals_b: u8,
        lp_supply: u64,
        lp_coin_type: 0x1::type_name::TypeName,
        custom_fee: u64,
    }

    public fun swap<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        swap_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun id<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<Pool<T0, T1, T2>>(arg0)
    }

    public fun distribute_fees<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::distribute_fees<T0, T1, T2>(&mut arg0.fee_vault, arg1, arg2);
    }

    public(friend) fun set_gauge_active<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: bool) {
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::set_gauge_active<T0, T1, T2>(&mut arg0.fee_vault, arg1);
    }

    public fun fee<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig) : u64 {
        0x1::option::get_with_default<u64>(&arg0.custom_fee, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::fee(arg1, arg0.stable))
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PoolLiquidityCoin<T0, T1, T2>>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        add_liquidity_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun add_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<PoolLiquidityCoin<T0, T1, T2>>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 1, 7);
        let (v0, v1, _) = quote_add_liquidity<T0, T1, T2>(arg0, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&arg2));
        if (v0 < arg3 || v1 < arg4) {
            abort 2
        };
        let v3 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v0, arg5));
        let v4 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v1, arg5));
        (mint<T0, T1, T2>(arg0, v3, v4, arg5), arg1, arg2)
    }

    fun burn<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<PoolLiquidityCoin<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 1, 7);
        let v0 = 0x2::balance::value<PoolLiquidityCoin<T0, T1, T2>>(&arg1);
        let (v1, v2) = get_reserves<T0, T1, T2>(arg0);
        let v3 = 0x2::balance::supply_value<PoolLiquidityCoin<T0, T1, T2>>(&arg0.lp_supply);
        let v4 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v0, v1, v3);
        let v5 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v0, v2, v3);
        assert!(v4 > 0 && v5 > 0, 4);
        0x2::balance::decrease_supply<PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.lp_supply, arg1);
        let v6 = Burn{
            sender   : 0x2::tx_context::sender(arg2),
            pool_id  : id<T0, T1, T2>(arg0),
            amount_a : v4,
            amount_b : v5,
        };
        0x2::event::emit<Burn>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v4), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v5), arg2))
    }

    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 / 1000000000000000000 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000 * arg1 / 1000000000000000000
    }

    public fun fee_vault_mut<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>) : &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::FeeVault<T0, T1, T2> {
        &mut arg0.fee_vault
    }

    public fun get_amounts_in<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig) : (u64, u64) {
        get_amounts_in_<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    fun get_amounts_in_<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig) : (u64, u64) {
        assert!(arg1 > 0 && arg2 == 0 || arg1 == 0 && arg2 > 0, 6);
        let (v0, v1) = get_reserves<T0, T1, T2>(arg0);
        assert!(v0 > 0 && v1 > 0, 5);
        if (arg0.stable) {
            let v2 = k<T0, T1, T2>(arg0, (v0 as u256), (v1 as u256));
            let v3 = 0x1::u256::pow(10, arg0.decimals_a);
            let v4 = 0x1::u256::pow(10, arg0.decimals_b);
            let v5 = (v0 as u256) * 1000000000000000000 / v3;
            let v6 = (v1 as u256) * 1000000000000000000 / v4;
            let v7 = 0;
            let v8 = 0;
            if (arg2 > 0) {
                let v9 = (arg2 as u256) * 1000000000000000000 / v4;
                assert!(v9 < v6, 6);
                let v10 = get_x(v6 - v9, v2, v5);
                let v11 = if (v10 > v5) {
                    v10 - v5
                } else {
                    0
                };
                v7 = gross_up_fee_u64(unscale_ceil_u256_to_u64(v11, v3), fee<T0, T1, T2>(arg0, arg3));
            };
            if (arg1 > 0) {
                let v12 = (arg1 as u256) * 1000000000000000000 / v3;
                assert!(v12 < v5, 6);
                let v13 = get_x(v5 - v12, v2, v6);
                let v14 = if (v13 > v6) {
                    v13 - v6
                } else {
                    0
                };
                v8 = gross_up_fee_u64(unscale_ceil_u256_to_u64(v14, v4), fee<T0, T1, T2>(arg0, arg3));
            };
            return (v7, v8)
        };
        if (arg2 > 0) {
            assert!(arg2 < v1, 6);
            return (gross_up_fee_u64(mul_div_ceil_u64(arg2, v0, v1 - arg2), fee<T0, T1, T2>(arg0, arg3)), 0)
        };
        assert!(arg1 < v0, 6);
        (0, gross_up_fee_u64(mul_div_ceil_u64(arg1, v1, v0 - arg1), fee<T0, T1, T2>(arg0, arg3)))
    }

    public fun get_amounts_out<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig) : (u64, u64) {
        get_amounts_out_<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    fun get_amounts_out_<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig) : (u64, u64) {
        assert!(arg1 > 0 && arg2 == 0 || arg1 == 0 && arg2 > 0, 6);
        let (v0, v1) = get_reserves<T0, T1, T2>(arg0);
        let v2 = fee<T0, T1, T2>(arg0, arg3);
        let v3 = arg1 - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg1, v2, 10000);
        let v4 = arg2 - 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg2, v2, 10000);
        if (arg0.stable) {
            let v5 = k<T0, T1, T2>(arg0, (v0 as u256), (v1 as u256));
            let v6 = 0x1::u256::pow(10, arg0.decimals_a);
            let v7 = 0x1::u256::pow(10, arg0.decimals_b);
            let v8 = (v0 as u256) * 1000000000000000000 / v6;
            let v9 = (v1 as u256) * 1000000000000000000 / v7;
            let v10 = 0;
            let v11 = 0;
            if (v3 > 0) {
                v10 = v9 - get_y((v3 as u256) * 1000000000000000000 / v6 + v8, v5, v9);
            };
            if (v4 > 0) {
                v11 = v8 - get_y((v4 as u256) * 1000000000000000000 / v7 + v9, v5, v8);
            };
            return (((v11 * v6 / 1000000000000000000) as u64), ((v10 * v7 / 1000000000000000000) as u64))
        };
        (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v4, v0, v1 + v4), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v3, v1, v0 + v3))
    }

    public fun get_reserves<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    fun get_x(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            let v1 = f(arg2, arg0);
            let v2 = arg2;
            if (v1 < arg1) {
                let v3 = (arg1 - v1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 + v3;
            } else {
                let v4 = (v1 - arg1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 - v4;
            };
            if (arg2 > v2) {
                if (arg2 - v2 <= 1) {
                    return arg2
                };
            } else if (v2 - arg2 <= 1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            let v1 = f(arg0, arg2);
            let v2 = arg2;
            if (v1 < arg1) {
                let v3 = (arg1 - v1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 + v3;
            } else {
                let v4 = (v1 - arg1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 - v4;
            };
            if (arg2 > v2) {
                if (arg2 - v2 <= 1) {
                    return arg2
                };
            } else if (v2 - arg2 <= 1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    fun gross_up_fee_u64(arg0: u64, arg1: u64) : u64 {
        mul_div_ceil_u64(arg0, 10000, 10000 - arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun init_pool<T0, T1, T2>(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        init_pool_<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun init_pool_<T0, T1, T2>(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        let v0 = PoolLiquidityCoin<T0, T1, T2>{dummy_field: false};
        Pool<T0, T1, T2>{
            id         : 0x2::object::new(arg2),
            version    : 1,
            stable     : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>(),
            coin_a     : 0x2::balance::zero<T0>(),
            coin_b     : 0x2::balance::zero<T1>(),
            decimals_a : arg0,
            decimals_b : arg1,
            lp_locked  : 0x2::balance::zero<PoolLiquidityCoin<T0, T1, T2>>(),
            lp_supply  : 0x2::balance::create_supply<PoolLiquidityCoin<T0, T1, T2>>(v0),
            fee_vault  : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::init_vault<T0, T1, T2>(arg2),
            custom_fee : 0x1::option::none<u64>(),
        }
    }

    fun k<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u256, arg2: u256) : u256 {
        if (arg0.stable) {
            let v0 = arg1 * 1000000000000000000 / 0x1::u256::pow(10, arg0.decimals_a);
            let v1 = arg2 * 1000000000000000000 / 0x1::u256::pow(10, arg0.decimals_b);
            return v0 * v1 / 1000000000000000000 * (v0 * v0 / 1000000000000000000 + v1 * v1 / 1000000000000000000) / 1000000000000000000
        };
        arg1 * arg2
    }

    entry fun migrate<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13906836837223104511);
        arg0.version = 1;
    }

    fun mint<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PoolLiquidityCoin<T0, T1, T2>> {
        assert!(arg0.version == 1, 7);
        let (v0, v1) = get_reserves<T0, T1, T2>(arg0);
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        let v4 = 0x2::balance::supply_value<PoolLiquidityCoin<T0, T1, T2>>(&arg0.lp_supply);
        let v5 = if (v4 == 0) {
            0x2::balance::join<PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.lp_locked, 0x2::balance::increase_supply<PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.lp_supply, 10));
            if (arg0.stable) {
                assert!((v2 as u256) * 1000000000000000000 / 0x1::u256::pow(10, arg0.decimals_a) == (v3 as u256) * 1000000000000000000 / 0x1::u256::pow(10, arg0.decimals_b), 0);
                assert!(k<T0, T1, T2>(arg0, (v2 as u256), (v3 as u256)) > 100000, 1);
            };
            (0x1::u128::sqrt((v2 as u128) * (v3 as u128)) as u64) - 10
        } else {
            0x1::u64::min(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v2, v4, v0), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v3, v4, v1))
        };
        assert!(v5 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
        let v6 = Mint{
            sender   : 0x2::tx_context::sender(arg3),
            pool_id  : id<T0, T1, T2>(arg0),
            amount_a : v2,
            amount_b : v3,
        };
        0x2::event::emit<Mint>(v6);
        0x2::coin::from_balance<PoolLiquidityCoin<T0, T1, T2>>(0x2::balance::increase_supply<PoolLiquidityCoin<T0, T1, T2>>(&mut arg0.lp_supply, v5), arg3)
    }

    fun mul_div_ceil_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        if (v0 % v1 == 0) {
            ((v0 / v1) as u64)
        } else {
            ((v0 / v1) as u64) + 1
        }
    }

    public fun quote_add_liquidity<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        quote_add_liquidity_<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun quote_add_liquidity_<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let (v0, v1) = get_reserves<T0, T1, T2>(arg0);
        let v2 = total_supply<T0, T1, T2>(arg0);
        if (v0 == 0 && v1 == 0) {
            (arg1, arg2, (0x1::u128::sqrt((arg1 as u128) * (arg2 as u128)) as u64) - 10)
        } else {
            let v6 = quote_liquidity(arg1, v0, v1);
            if (v6 < arg2) {
                (arg1, v6, 0x1::u64::min(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg1, v2, v0), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v6, v2, v1)))
            } else {
                let v7 = quote_liquidity(arg2, v1, v0);
                (v7, arg2, 0x1::u64::min(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(v7, v2, v0), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg2, v2, v1)))
            }
        }
    }

    public fun quote_liquidity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            abort 5
        };
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg0, arg2, arg1)
    }

    public fun quote_remove_liquidity<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : (u64, u64) {
        quote_remove_liquidity_<T0, T1, T2>(arg0, arg1)
    }

    fun quote_remove_liquidity_<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : (u64, u64) {
        let (v0, v1) = get_reserves<T0, T1, T2>(arg0);
        let v2 = total_supply<T0, T1, T2>(arg0);
        (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg1, v0, v2), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(arg1, v1, v2))
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<PoolLiquidityCoin<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        remove_liquidity_<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun remove_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<PoolLiquidityCoin<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 1, 7);
        burn<T0, T1, T2>(arg0, 0x2::coin::into_balance<PoolLiquidityCoin<T0, T1, T2>>(arg1), arg2)
    }

    entry fun set_custom_fee<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::option::Option<u64>, arg2: &AdminCap) {
        arg0.custom_fee = arg1;
    }

    public fun state<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : PoolState {
        PoolState{
            id             : id<T0, T1, T2>(arg0),
            stable         : arg0.stable,
            coin_a_type    : 0x1::type_name::get<T0>(),
            coin_b_type    : 0x1::type_name::get<T1>(),
            coin_a_balance : 0x2::balance::value<T0>(&arg0.coin_a),
            coin_b_balance : 0x2::balance::value<T1>(&arg0.coin_b),
            decimals_a     : arg0.decimals_a,
            decimals_b     : arg0.decimals_b,
            lp_supply      : 0x2::balance::supply_value<PoolLiquidityCoin<T0, T1, T2>>(&arg0.lp_supply),
            lp_coin_type   : 0x1::type_name::get<PoolLiquidityCoin<T0, T1, T2>>(),
            custom_fee     : 0x1::option::get_with_default<u64>(&arg0.custom_fee, 0),
        }
    }

    fun swap_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::paused(arg5), 8);
        assert!(arg0.version == 1, 7);
        let (v0, v1) = get_amounts_out<T0, T1, T2>(arg0, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&arg2), arg5);
        assert!(v0 >= arg3 && v1 >= arg4, 2);
        let (v2, v3) = get_reserves<T0, T1, T2>(arg0);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        let v6 = Swap{
            sender       : 0x2::tx_context::sender(arg6),
            pool_id      : id<T0, T1, T2>(arg0),
            amount_a_in  : 0x2::balance::value<T0>(&v4),
            amount_b_in  : 0x2::balance::value<T1>(&v5),
            amount_a_out : v0,
            amount_b_out : v1,
        };
        0x2::event::emit<Swap>(v6);
        let v7 = fee<T0, T1, T2>(arg0, arg5);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::fee_vault::deposit<T0, T1, T2>(&mut arg0.fee_vault, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::balance::value<T0>(&v4), v7, 10000), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::protocol_fee(arg5), 10000)), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::amm_math::safe_mul_div_u64(0x2::balance::value<T1>(&v5), v7, 10000), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::protocol_fee(arg5), 10000)), arg6), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config::distribution_config(arg5), arg6);
        0x2::balance::join<T0>(&mut arg0.coin_a, v4);
        0x2::balance::join<T1>(&mut arg0.coin_b, v5);
        let (v8, v9) = get_reserves<T0, T1, T2>(arg0);
        if (k<T0, T1, T2>(arg0, (v8 as u256), (v9 as u256)) < k<T0, T1, T2>(arg0, (v2 as u256), (v3 as u256))) {
            abort 1
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v0), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v1), arg6))
    }

    public fun total_supply<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<PoolLiquidityCoin<T0, T1, T2>>(&arg0.lp_supply)
    }

    fun unscale_ceil_u256_to_u64(arg0: u256, arg1: u256) : u64 {
        let v0 = arg0 * arg1;
        if (v0 % 1000000000000000000 == 0) {
            ((v0 / 1000000000000000000) as u64)
        } else {
            ((v0 / 1000000000000000000) as u64) + 1
        }
    }

    // decompiled from Move bytecode v6
}

