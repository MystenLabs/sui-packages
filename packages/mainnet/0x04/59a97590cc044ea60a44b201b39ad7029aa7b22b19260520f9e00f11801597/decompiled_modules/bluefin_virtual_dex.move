module 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::bluefin_virtual_dex {
    struct VirtualPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        protocol_fee_share: u64,
        fee_growth_global_coin_a: u128,
        fee_growth_global_coin_b: u128,
        protocol_fee_coin_a: u64,
        protocol_fee_coin_b: u64,
        current_sqrt_price: u128,
        current_tick_index: u32,
        liquidity: u128,
        is_paused: bool,
        icon_url: 0x1::string::String,
        position_index: u128,
        sequence_number: u128,
    }

    struct VirtualSwapResult has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount_specified: u64,
        amount_specified_remaining: u64,
        amount_calculated: u64,
        fee_growth_global: u128,
        fee_amount: u64,
        protocol_fee: u64,
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        current_tick_index: u32,
        is_exceed: bool,
        starting_liquidity: u128,
        liquidity: u128,
        steps: u64,
    }

    struct VirtualFlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        a2b: bool,
        pay_amount: u64,
    }

    struct VirtualPosition has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        fee_rate: u64,
        initial_sqrt_price: u128,
    }

    struct AssetSwap has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol_fee: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
    }

    struct LiquidityProvided has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_delta: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct UserFeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    public fun swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut VirtualPool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_paused, 3);
        assert!(arg6 > 0, 1);
        if (arg4) {
            assert!(0x2::balance::value<T0>(&arg2) >= arg6, 0);
            assert!(0x2::balance::value<T1>(&arg3) == 0, 1);
            let v2 = if (arg5) {
                arg6
            } else {
                calculate_amount_in<T0, T1>(arg1, arg6, true)
            };
            let v3 = calculate_amount_out<T0, T1>(arg1, v2, true);
            assert!(v3 >= arg7, 2);
            let v4 = v2 * (arg1.fee_rate as u64) / (1000000 as u64);
            let v5 = v4 * (arg1.protocol_fee_share as u64) / (1000000 as u64);
            0x2::balance::join<T0>(&mut arg1.coin_a, 0x2::balance::split<T0>(&mut arg2, v2));
            arg1.fee_growth_global_coin_a = arg1.fee_growth_global_coin_a + ((v4 - v5) as u128) * 1000000 / arg1.liquidity;
            arg1.protocol_fee_coin_a = arg1.protocol_fee_coin_a + v5;
            arg1.current_sqrt_price = calculate_new_sqrt_price(arg1.current_sqrt_price, 0x2::balance::value<T0>(&arg1.coin_a), 0x2::balance::value<T1>(&arg1.coin_b));
            arg1.sequence_number = arg1.sequence_number + 1;
            let v6 = AssetSwap{
                pool_id           : 0x2::object::id<VirtualPool<T0, T1>>(arg1),
                a2b               : true,
                amount_in         : v2,
                amount_out        : v3,
                fee_amount        : v4,
                protocol_fee      : v5,
                sqrt_price_before : arg1.current_sqrt_price,
                sqrt_price_after  : arg1.current_sqrt_price,
            };
            0x2::event::emit<AssetSwap>(v6);
            0x2::balance::destroy_zero<T1>(arg3);
            (arg2, 0x2::balance::split<T1>(&mut arg1.coin_b, v3))
        } else {
            assert!(0x2::balance::value<T1>(&arg3) >= arg6, 0);
            assert!(0x2::balance::value<T0>(&arg2) == 0, 1);
            let v7 = if (arg5) {
                arg6
            } else {
                calculate_amount_in<T0, T1>(arg1, arg6, false)
            };
            let v8 = calculate_amount_out<T0, T1>(arg1, v7, false);
            assert!(v8 >= arg7, 2);
            let v9 = v7 * (arg1.fee_rate as u64) / (1000000 as u64);
            let v10 = v9 * (arg1.protocol_fee_share as u64) / (1000000 as u64);
            0x2::balance::join<T1>(&mut arg1.coin_b, 0x2::balance::split<T1>(&mut arg3, v7));
            arg1.fee_growth_global_coin_b = arg1.fee_growth_global_coin_b + ((v9 - v10) as u128) * 1000000 / arg1.liquidity;
            arg1.protocol_fee_coin_b = arg1.protocol_fee_coin_b + v10;
            arg1.current_sqrt_price = calculate_new_sqrt_price(arg1.current_sqrt_price, 0x2::balance::value<T0>(&arg1.coin_a), 0x2::balance::value<T1>(&arg1.coin_b));
            arg1.sequence_number = arg1.sequence_number + 1;
            let v11 = AssetSwap{
                pool_id           : 0x2::object::id<VirtualPool<T0, T1>>(arg1),
                a2b               : false,
                amount_in         : v7,
                amount_out        : v8,
                fee_amount        : v9,
                protocol_fee      : v10,
                sqrt_price_before : arg1.current_sqrt_price,
                sqrt_price_after  : arg1.current_sqrt_price,
            };
            0x2::event::emit<AssetSwap>(v11);
            0x2::balance::destroy_zero<T0>(arg2);
            (0x2::balance::split<T0>(&mut arg1.coin_a, v8), arg3)
        }
    }

    public fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut VirtualPool<T0, T1>, arg2: &mut VirtualPosition, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg2.pool_id == 0x2::object::id<VirtualPool<T0, T1>>(arg1), 3);
        let (v0, v1) = calculate_amounts_for_liquidity(arg2.lower_tick, arg2.upper_tick, arg1.current_tick_index, arg1.current_sqrt_price, arg5);
        assert!(0x2::balance::value<T0>(&arg3) >= v0, 0);
        assert!(0x2::balance::value<T1>(&arg4) >= v1, 0);
        0x2::balance::join<T0>(&mut arg1.coin_a, 0x2::balance::split<T0>(&mut arg3, v0));
        0x2::balance::join<T1>(&mut arg1.coin_b, 0x2::balance::split<T1>(&mut arg4, v1));
        arg2.liquidity = arg2.liquidity + arg5;
        arg1.liquidity = arg1.liquidity + arg5;
        arg1.sequence_number = arg1.sequence_number + 1;
        let v2 = LiquidityProvided{
            pool_id         : 0x2::object::id<VirtualPool<T0, T1>>(arg1),
            position_id     : 0x2::object::id<VirtualPosition>(arg2),
            liquidity_delta : arg5,
            amount_a        : v0,
            amount_b        : v1,
        };
        0x2::event::emit<LiquidityProvided>(v2);
        (v0, v1, arg3, arg4)
    }

    fun calculate_amount_in<T0, T1>(arg0: &VirtualPool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            0x2::balance::value<T0>(&arg0.coin_a)
        } else {
            0x2::balance::value<T1>(&arg0.coin_b)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T1>(&arg0.coin_b)
        } else {
            0x2::balance::value<T0>(&arg0.coin_a)
        };
        (((v0 as u128) * (arg1 as u128) / ((v1 as u128) - (arg1 as u128))) as u64) * (1000000 as u64) / ((1000000 as u64) - arg0.fee_rate)
    }

    fun calculate_amount_out<T0, T1>(arg0: &VirtualPool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            0x2::balance::value<T0>(&arg0.coin_a)
        } else {
            0x2::balance::value<T1>(&arg0.coin_b)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T1>(&arg0.coin_b)
        } else {
            0x2::balance::value<T0>(&arg0.coin_a)
        };
        let v2 = arg1 - arg1 * (arg0.fee_rate as u64) / (1000000 as u64);
        (((v2 as u128) * (v1 as u128) / ((v0 as u128) + (v2 as u128))) as u64)
    }

    fun calculate_amounts_for_liquidity(arg0: u32, arg1: u32, arg2: u32, arg3: u128, arg4: u128) : (u64, u64) {
        (((arg4 / 2) as u64), ((arg4 / 2) as u64))
    }

    fun calculate_initial_liquidity(arg0: u64, arg1: u64, arg2: u128) : u128 {
        sqrt_u128((arg0 as u128) * (arg1 as u128))
    }

    fun calculate_new_sqrt_price(arg0: u128, arg1: u64, arg2: u64) : u128 {
        if (arg1 == 0 || arg2 == 0) {
            return arg0
        };
        sqrt_u128((arg2 as u128) * 1000000 / (arg1 as u128) * 79228162514264337593543950336)
    }

    public fun calculate_swap_results<T0, T1>(arg0: &VirtualPool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : VirtualSwapResult {
        let v0 = if (arg2) {
            arg3
        } else {
            calculate_amount_in<T0, T1>(arg0, arg3, arg1)
        };
        let v1 = calculate_amount_out<T0, T1>(arg0, v0, arg1);
        let v2 = v0 * (arg0.fee_rate as u64) / (1000000 as u64);
        let v3 = if (arg1) {
            calculate_new_sqrt_price(arg0.current_sqrt_price, 0x2::balance::value<T0>(&arg0.coin_a) + v0, 0x2::balance::value<T1>(&arg0.coin_b) - v1)
        } else {
            calculate_new_sqrt_price(arg0.current_sqrt_price, 0x2::balance::value<T0>(&arg0.coin_a) - v1, 0x2::balance::value<T1>(&arg0.coin_b) + v0)
        };
        let v4 = if (arg2) {
            v1
        } else {
            v0
        };
        let v5 = if (arg1) {
            arg0.fee_growth_global_coin_a
        } else {
            arg0.fee_growth_global_coin_b
        };
        VirtualSwapResult{
            a2b                        : arg1,
            by_amount_in               : arg2,
            amount_specified           : arg3,
            amount_specified_remaining : 0,
            amount_calculated          : v4,
            fee_growth_global          : v5,
            fee_amount                 : v2,
            protocol_fee               : v2 * (arg0.protocol_fee_share as u64) / (1000000 as u64),
            start_sqrt_price           : arg0.current_sqrt_price,
            end_sqrt_price             : v3,
            current_tick_index         : arg0.current_tick_index,
            is_exceed                  : false,
            starting_liquidity         : arg0.liquidity,
            liquidity                  : arg0.liquidity,
            steps                      : 1,
        }
    }

    public fun create_virtual_pool<T0, T1>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u128, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : VirtualPool<T0, T1> {
        let v0 = 0x2::object::new(arg6);
        let v1 = VirtualPool<T0, T1>{
            id                       : v0,
            name                     : 0x1::string::utf8(arg0),
            coin_a                   : 0x2::coin::into_balance<T0>(arg4),
            coin_b                   : 0x2::coin::into_balance<T1>(arg5),
            fee_rate                 : arg2,
            protocol_fee_share       : 250000,
            fee_growth_global_coin_a : 0,
            fee_growth_global_coin_b : 0,
            protocol_fee_coin_a      : 0,
            protocol_fee_coin_b      : 0,
            current_sqrt_price       : arg3,
            current_tick_index       : 0,
            liquidity                : calculate_initial_liquidity(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5), arg3),
            is_paused                : false,
            icon_url                 : 0x1::string::utf8(arg1),
            position_index           : 0,
            sequence_number          : 1,
        };
        let v2 = PoolCreated{
            pool_id            : 0x2::object::uid_to_inner(&v0),
            coin_type_a        : 0x1::string::utf8(b"CoinTypeA"),
            coin_type_b        : 0x1::string::utf8(b"CoinTypeB"),
            fee_rate           : arg2,
            initial_sqrt_price : arg3,
        };
        0x2::event::emit<PoolCreated>(v2);
        v1
    }

    public fun flash_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut VirtualPool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, VirtualFlashSwapReceipt<T0, T1>) {
        assert!(!arg1.is_paused, 3);
        assert!(arg4 > 0, 1);
        let (v0, v1) = if (arg3) {
            (arg4, calculate_amount_out<T0, T1>(arg1, arg4, arg2))
        } else {
            (calculate_amount_in<T0, T1>(arg1, arg4, arg2), arg4)
        };
        let v2 = VirtualFlashSwapReceipt<T0, T1>{
            pool_id    : 0x2::object::id<VirtualPool<T0, T1>>(arg1),
            a2b        : arg2,
            pay_amount : v0 + v0 * (arg1.fee_rate as u64) / (1000000 as u64),
        };
        let (v3, v4) = if (arg2) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1.coin_b, v1))
        } else {
            (0x2::balance::split<T0>(&mut arg1.coin_a, v1), 0x2::balance::zero<T1>())
        };
        (v3, v4, v2)
    }

    public fun get_current_sqrt_price<T0, T1>(arg0: &VirtualPool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun get_fee_rate<T0, T1>(arg0: &VirtualPool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun get_flash_swap_pay_amount<T0, T1>(arg0: &VirtualFlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun get_pool_liquidity<T0, T1>(arg0: &VirtualPool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun get_pool_reserves<T0, T1>(arg0: &VirtualPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun get_sequence_number<T0, T1>(arg0: &VirtualPool<T0, T1>) : u128 {
        arg0.sequence_number
    }

    public fun open_position<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : VirtualPosition {
        let v0 = (arg1 as u32);
        let v1 = (arg2 as u32);
        assert!(v0 < v1, 5);
        arg0.position_index = arg0.position_index + 1;
        VirtualPosition{
            id                  : 0x2::object::new(arg3),
            pool_id             : 0x2::object::id<VirtualPool<T0, T1>>(arg0),
            lower_tick          : v0,
            upper_tick          : v1,
            liquidity           : 0,
            fee_growth_inside_a : 0,
            fee_growth_inside_b : 0,
            tokens_owed_a       : 0,
            tokens_owed_b       : 0,
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: VirtualFlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let VirtualFlashSwapReceipt {
            pool_id    : v0,
            a2b        : v1,
            pay_amount : v2,
        } = arg3;
        assert!(v0 == 0x2::object::id<VirtualPool<T0, T1>>(arg0), 6);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) >= v2, 0);
            assert!(0x2::balance::value<T1>(&arg2) == 0, 1);
            0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) >= v2, 0);
            assert!(0x2::balance::value<T0>(&arg1) == 0, 1);
            0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
        arg0.sequence_number = arg0.sequence_number + 1;
    }

    public fun share_pool<T0, T1>(arg0: VirtualPool<T0, T1>) {
        0x2::transfer::share_object<VirtualPool<T0, T1>>(arg0);
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            1
        } else if (arg0 < 4) {
            1
        } else if (arg0 < 9) {
            2
        } else if (arg0 < 16) {
            3
        } else {
            arg0 / 10 + 1
        }
    }

    public fun swap_result_a2b(arg0: &VirtualSwapResult) : bool {
        arg0.a2b
    }

    public fun swap_result_amount_calculated(arg0: &VirtualSwapResult) : u64 {
        arg0.amount_calculated
    }

    public fun swap_result_amount_specified(arg0: &VirtualSwapResult) : u64 {
        arg0.amount_specified
    }

    public fun swap_result_by_amount_in(arg0: &VirtualSwapResult) : bool {
        arg0.by_amount_in
    }

    public fun swap_result_end_sqrt_price(arg0: &VirtualSwapResult) : u128 {
        arg0.end_sqrt_price
    }

    public fun swap_result_fee_amount(arg0: &VirtualSwapResult) : u64 {
        arg0.fee_amount
    }

    public fun swap_result_protocol_fee(arg0: &VirtualSwapResult) : u64 {
        arg0.protocol_fee
    }

    public fun swap_result_start_sqrt_price(arg0: &VirtualSwapResult) : u128 {
        arg0.start_sqrt_price
    }

    // decompiled from Move bytecode v6
}

