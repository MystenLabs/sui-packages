module 0xe8bb367882a48a19d523a0288011a38996ac9856fd4b485b761288ee88e816ed::turbos {
    fun assert_spent<T0>(arg0: 0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(&arg0) == 0, 3);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun close_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = &mut arg2;
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(take<T0>(v0, owed<T0, T1>(&arg3)), arg4), 0x2::coin::zero<T1>(arg4), arg3, arg1);
        arg2
    }

    public fun close_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T1>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = &mut arg2;
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(take<T1>(v0, owed<T0, T1>(&arg3)), arg4), arg3, arg1);
        arg2
    }

    public fun open_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), true, (arg3 as u128), true, 4295048017, arg2, arg1, arg4);
        let v3 = v2;
        0x2::coin::destroy_zero<T0>(v0);
        assert!(owed<T0, T1>(&v3) == arg3, 3);
        (0x2::coin::into_balance<T1>(v1), v3)
    }

    public fun open_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg4), false, (arg3 as u128), true, 79226673515401279992447579054, arg2, arg1, arg4);
        let v3 = v2;
        0x2::coin::destroy_zero<T1>(v1);
        assert!(owed<T0, T1>(&v3) == arg3, 3);
        (0x2::coin::into_balance<T0>(v0), v3)
    }

    fun owed<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) : u64 {
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(arg0);
        v2
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = open_a2b<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::value<T0>(&arg3), arg4);
        assert_spent<T0>(close_a2b<T0, T1, T2>(arg0, arg1, arg3, v1, arg4));
        v0
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = open_b2a<T0, T1, T2>(arg0, arg1, arg2, 0x2::balance::value<T1>(&arg3), arg4);
        assert_spent<T1>(close_b2a<T0, T1, T2>(arg0, arg1, arg3, v1, arg4));
        v0
    }

    fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

