module 0xa6cb59708fde10083ad9d5f857785624d43b4c59d589c3e238284433b4a5f239::magma {
    public fun swap<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    public fun flash_swap_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg2, arg4, arg5);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(v1, arg6), v2, arg2)
    }

    public fun flash_swap_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, arg3, arg2, arg4, arg5);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(v1, arg6), v2, arg2)
    }

    public fun repay_flash_swap_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3);
        0x2::coin::zero<T0>(arg4)
    }

    public fun repay_flash_swap_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3);
        0x2::coin::zero<T1>(arg4)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg4);
        let v5 = v3;
        let v6 = v2;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v4);
        let v7 = 0x2::balance::value<T0>(&v6);
        if (arg3 == 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::max_amount_in()) {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::transfer_balance<T0>(v6, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, v6);
        };
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T1>(arg0, v5);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"MAGMA", 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::balance::value<T1>(&v5), v7, true);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        let (v2, v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg4);
        let v5 = v3;
        let v6 = v2;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v4);
        let v7 = 0x2::balance::value<T1>(&v5);
        if (arg3 == 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::max_amount_in()) {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::transfer_balance<T1>(v5, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T1>(arg0, v5);
        };
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, v6);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"MAGMA", 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::balance::value<T0>(&v6), v7, false);
    }

    // decompiled from Move bytecode v6
}

