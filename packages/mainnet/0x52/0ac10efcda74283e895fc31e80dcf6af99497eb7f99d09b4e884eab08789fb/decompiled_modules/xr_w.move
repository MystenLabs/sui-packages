module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::xr_w {
    fun pay_amount<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) : u64 {
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(arg0);
        v2
    }

    public fun wf0<T0, T1, T2>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg4), true, (v0 as u128), true, 4295048017, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        assert!(pay_amount<T0, T1>(&v4) == v0, 159);
        (0x2::coin::into_balance<T1>(v2), 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun wf1<T0, T1, T2>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg4), false, (v0 as u128), true, 79226673515401279992447579054, arg2, arg3, arg4);
        let v4 = v3;
        0x2::coin::destroy_zero<T1>(v2);
        assert!(pay_amount<T0, T1>(&v4) == v0, 159);
        (0x2::coin::into_balance<T0>(v1), 0x1::option::some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun wg0<T0, T1, T2>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>, arg3: 0x2::balance::Balance<T0>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&arg2), 160);
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T0>(&mut arg3, pay_amount<T0, T1>(&v0)), arg5), 0x2::coin::zero<T1>(arg5), v0, arg4);
        arg3
    }

    public fun wg1<T0, T1, T2>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>, arg3: 0x2::balance::Balance<T1>, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&arg2), 160);
            0x1::option::destroy_none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>>(arg2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T1>(&mut arg3, pay_amount<T0, T1>(&v0)), arg5), v0, arg4);
        arg3
    }

    public fun ws0<T0, T1, T2>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg5), true, (v0 as u128), true, 4295048017, arg3, arg4, arg5);
        let v4 = v3;
        0x2::coin::destroy_zero<T0>(v1);
        assert!(pay_amount<T0, T1>(&v4) == v0, 159);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), 0x2::coin::zero<T1>(arg5), v4, arg4);
        0x2::coin::into_balance<T1>(v2)
    }

    public fun ws1<T0, T1, T2>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg5), false, (v0 as u128), true, 79226673515401279992447579054, arg3, arg4, arg5);
        let v4 = v3;
        0x2::coin::destroy_zero<T1>(v2);
        assert!(pay_amount<T0, T1>(&v4) == v0, 159);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(arg2, arg5), v4, arg4);
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

