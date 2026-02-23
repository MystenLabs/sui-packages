module 0xfbe80a932600e422235aa6cbff8d30f106ea354723ba1b31008dcf2c7f55f5c6::cetus_virtual_dex {
    struct VirtualPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount_to_pay: u64,
        is_a_to_b: bool,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    struct AddLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        provider: address,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        is_a_to_b: bool,
        user: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 103);
        assert!(v1 > 0, 103);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        let v2 = AddLiquidityEvent{
            pool_id  : 0x2::object::id<VirtualPool<T0, T1>>(arg0),
            amount_a : v0,
            amount_b : v1,
            provider : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddLiquidityEvent>(v2);
    }

    fun calculate_input_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 101);
        assert!(arg1 > 0 && arg2 > 0, 100);
        assert!(arg2 > arg0, 100);
        ((((arg0 as u128) * (arg1 as u128) / ((arg2 - arg0) as u128)) as u64) + 1) * 10000 / (10000 - arg3) + 1
    }

    public fun calculate_swap_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg0 > 0, 101);
        assert!(arg1 > 0 && arg2 > 0, 100);
        let v0 = arg0 * arg3 / 10000;
        let v1 = arg0 - v0;
        ((((v1 as u128) * (arg2 as u128) / ((arg1 as u128) + (v1 as u128))) as u64), v0)
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 103);
        assert!(v1 > 0, 103);
        let v2 = VirtualPool<T0, T1>{
            id        : 0x2::object::new(arg3),
            reserve_a : 0x2::coin::into_balance<T0>(arg0),
            reserve_b : 0x2::coin::into_balance<T1>(arg1),
            fee_rate  : arg2,
        };
        let v3 = 0x2::object::id<VirtualPool<T0, T1>>(&v2);
        let v4 = AddLiquidityEvent{
            pool_id  : v3,
            amount_a : v0,
            amount_b : v1,
            provider : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AddLiquidityEvent>(v4);
        0x2::transfer::share_object<VirtualPool<T0, T1>>(v2);
        v3
    }

    public fun flash_swap<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let (v2, v3, v4) = if (arg2) {
            assert!(v1 >= arg1, 100);
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.reserve_b, arg1), calculate_input_amount(arg1, v0, v1, arg0.fee_rate))
        } else {
            assert!(v0 >= arg1, 100);
            (0x2::balance::split<T0>(&mut arg0.reserve_a, arg1), 0x2::balance::zero<T1>(), calculate_input_amount(arg1, v1, v0, arg0.fee_rate))
        };
        let v5 = FlashSwapReceipt<T0, T1>{
            id            : 0x2::object::new(arg3),
            pool_id       : 0x2::object::id<VirtualPool<T0, T1>>(arg0),
            amount_to_pay : v4,
            is_a_to_b     : arg2,
        };
        (v2, v3, v5)
    }

    public fun get_fee_rate<T0, T1>(arg0: &VirtualPool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun get_flash_swap_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.amount_to_pay
    }

    public fun get_reserves<T0, T1>(arg0: &VirtualPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun preview_swap<T0, T1>(arg0: &VirtualPool<T0, T1>, arg1: u64, arg2: bool) : SwapResult {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        let (v2, v3) = if (arg2) {
            calculate_swap_amount(arg1, v0, v1, arg0.fee_rate)
        } else {
            calculate_swap_amount(arg1, v1, v0, arg0.fee_rate)
        };
        SwapResult{
            amount_in  : arg1,
            amount_out : v2,
            fee_amount : v3,
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let FlashSwapReceipt {
            id            : v0,
            pool_id       : v1,
            amount_to_pay : v2,
            is_a_to_b     : v3,
        } = arg3;
        assert!(v1 == 0x2::object::id<VirtualPool<T0, T1>>(arg0), 104);
        if (v3) {
            assert!(0x2::balance::value<T0>(&arg1) >= v2, 100);
            assert!(0x2::balance::value<T1>(&arg2) == 0, 101);
            0x2::balance::join<T0>(&mut arg0.reserve_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) >= v2, 100);
            assert!(0x2::balance::value<T0>(&arg1) == 0, 101);
            0x2::balance::join<T1>(&mut arg0.reserve_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
        0x2::object::delete(v0);
        let v4 = SwapEvent{
            pool_id    : v1,
            amount_in  : v2,
            amount_out : 0,
            fee_amount : 0,
            is_a_to_b  : v3,
            user       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public fun swap_exact_input<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2) = calculate_swap_amount(v0, 0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), arg0.fee_rate);
        assert!(v1 >= arg2, 102);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        let v3 = SwapEvent{
            pool_id    : 0x2::object::id<VirtualPool<T0, T1>>(arg0),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : v2,
            is_a_to_b  : true,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v1), arg3)
    }

    public fun swap_exact_input_reverse<T0, T1>(arg0: &mut VirtualPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let (v1, v2) = calculate_swap_amount(v0, 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::value<T0>(&arg0.reserve_a), arg0.fee_rate);
        assert!(v1 >= arg2, 102);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v3 = SwapEvent{
            pool_id    : 0x2::object::id<VirtualPool<T0, T1>>(arg0),
            amount_in  : v0,
            amount_out : v1,
            fee_amount : v2,
            is_a_to_b  : false,
            user       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v1), arg3)
    }

    // decompiled from Move bytecode v6
}

