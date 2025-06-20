module 0x46b724808593965aef919b9a25632b998e12e1f4bc7c41d9c64d9c5c51faf889::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referal_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort 1
        };
        let v1 = OrderRecord{
            order_id   : arg4,
            decimal    : arg5,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        if (arg2 > 0) {
            let v2 = &mut arg0;
            let (v3, _) = split_with_percentage_for_commission<T0>(v2, arg2, arg3, arg6);
            destroy_or_transfer<T0>(v3, arg6);
            destroy_or_transfer<T0>(arg0, arg6);
        } else {
            destroy_or_transfer<T0>(arg0, arg6);
        };
    }

    public fun magma_swap_token_x_with_return<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg5);
        let v3 = v1;
        let v4 = 0x2::balance::value<T1>(&v3);
        assert!(v4 >= arg4, 6);
        0x2::balance::destroy_zero<T0>(v0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v2);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (0x2::coin::from_balance<T1>(v3, arg6), v4)
    }

    public fun magma_swap_token_y_with_return<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg5);
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(v4 >= arg4, 6);
        0x2::balance::destroy_zero<T1>(v1);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v2);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (0x2::coin::from_balance<T0>(v3, arg6), v4)
    }

    public fun split_with_percentage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = (((v0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg0, v1, arg2), v1, 0x2::coin::split<T0>(arg0, v0 - v1, arg2), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 300, 3);
        assert!(arg1 == 0 || arg1 > 0 && arg2 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg3);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referal_address   : arg2,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

