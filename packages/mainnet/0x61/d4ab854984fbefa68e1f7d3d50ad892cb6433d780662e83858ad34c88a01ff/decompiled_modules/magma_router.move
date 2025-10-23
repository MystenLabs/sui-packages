module 0x61d4ab854984fbefa68e1f7d3d50ad892cb6433d780662e83858ad34c88a01ff::magma_router {
    struct BuyEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        partner_id: address,
        atob: bool,
        amount_in: u64,
        amount_out: u64,
        magma_fee_amount: u64,
        protocol_fee_amount: u64,
        ref_fee_amount: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        steps: u64,
    }

    struct SellEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: address,
        partner_id: address,
        atob: bool,
        amount_in: u64,
        amount_out: u64,
        magma_fee_amount: u64,
        protocol_fee_amount: u64,
        ref_fee_amount: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        steps: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    entry fun buy_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            let v0 = 0x2::coin::value<T0>(&arg3);
            let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, true, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg7);
            let v4 = v2;
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v3);
            let v5 = 0x2::balance::value<T1>(&v4);
            assert!(v5 >= arg5, 0);
            0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg9));
            0x2::balance::destroy_zero<T0>(v1);
            let v6 = BuyEvent<T0, T1>{
                pool_id             : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1),
                partner_id          : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2),
                atob                : true,
                amount_in           : v0,
                amount_out          : v5,
                magma_fee_amount    : 0,
                protocol_fee_amount : 0,
                ref_fee_amount      : 0,
                fee_amount          : 0,
                vault_a_amount      : 0,
                vault_b_amount      : 0,
                before_sqrt_price   : 0,
                after_sqrt_price    : 0,
                steps               : 0,
            };
            0x2::event::emit<BuyEvent<T0, T1>>(v6);
            0x61d4ab854984fbefa68e1f7d3d50ad892cb6433d780662e83858ad34c88a01ff::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg9));
        } else {
            let v7 = 0x2::coin::value<T1>(&arg4);
            let (v8, v9, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, false, true, v7, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg7);
            let v11 = v8;
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), v10);
            let v12 = 0x2::balance::value<T0>(&v11);
            assert!(v12 >= arg5, 0);
            0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v11, arg9));
            0x2::balance::destroy_zero<T1>(v9);
            let v13 = BuyEvent<T0, T1>{
                pool_id             : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1),
                partner_id          : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2),
                atob                : false,
                amount_in           : v7,
                amount_out          : v12,
                magma_fee_amount    : 0,
                protocol_fee_amount : 0,
                ref_fee_amount      : 0,
                fee_amount          : 0,
                vault_a_amount      : 0,
                vault_b_amount      : 0,
                before_sqrt_price   : 0,
                after_sqrt_price    : 0,
                steps               : 0,
            };
            0x2::event::emit<BuyEvent<T0, T1>>(v13);
            0x61d4ab854984fbefa68e1f7d3d50ad892cb6433d780662e83858ad34c88a01ff::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg9));
        };
        let v14 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v14);
    }

    entry fun sell_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            let v0 = 0x2::coin::value<T0>(&arg3);
            let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, true, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg7);
            let v4 = v2;
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v3);
            let v5 = 0x2::balance::value<T1>(&v4);
            assert!(v5 >= arg5, 0);
            0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg9));
            0x2::balance::destroy_zero<T0>(v1);
            let v6 = SellEvent<T0, T1>{
                pool_id             : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1),
                partner_id          : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2),
                atob                : true,
                amount_in           : v0,
                amount_out          : v5,
                magma_fee_amount    : 0,
                protocol_fee_amount : 0,
                ref_fee_amount      : 0,
                fee_amount          : 0,
                vault_a_amount      : 0,
                vault_b_amount      : 0,
                before_sqrt_price   : 0,
                after_sqrt_price    : 0,
                steps               : 0,
            };
            0x2::event::emit<SellEvent<T0, T1>>(v6);
            0x61d4ab854984fbefa68e1f7d3d50ad892cb6433d780662e83858ad34c88a01ff::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg9));
        } else {
            let v7 = 0x2::coin::value<T1>(&arg4);
            let (v8, v9, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, false, true, v7, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg7);
            let v11 = v8;
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), v10);
            let v12 = 0x2::balance::value<T0>(&v11);
            assert!(v12 >= arg5, 0);
            0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v11, arg9));
            0x2::balance::destroy_zero<T1>(v9);
            let v13 = SellEvent<T0, T1>{
                pool_id             : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1),
                partner_id          : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2),
                atob                : false,
                amount_in           : v7,
                amount_out          : v12,
                magma_fee_amount    : 0,
                protocol_fee_amount : 0,
                ref_fee_amount      : 0,
                fee_amount          : 0,
                vault_a_amount      : 0,
                vault_b_amount      : 0,
                before_sqrt_price   : 0,
                after_sqrt_price    : 0,
                steps               : 0,
            };
            0x2::event::emit<SellEvent<T0, T1>>(v13);
            0x61d4ab854984fbefa68e1f7d3d50ad892cb6433d780662e83858ad34c88a01ff::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg9));
        };
        let v14 = OrderCompletedEvent{order_id: arg8};
        0x2::event::emit<OrderCompletedEvent>(v14);
    }

    // decompiled from Move bytecode v6
}

