module 0x5bd3eb616bae78f0c30e085a014820ec873fd2a18ae56f002bd35bcee47e63e8::router {
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

    entry fun buy_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, false, true, v0, 0, arg5);
        let v4 = v1;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v3);
        let v5 = 0x2::balance::value<T0>(&v4);
        assert!(v5 >= arg4, 0);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg6), 0x2::tx_context::sender(arg6));
        let v6 = BuyEvent<T0, T1>{
            pool_id             : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1),
            partner_id          : 0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2),
            atob                : false,
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
        let v7 = OrderCompletedEvent{order_id: 0x1::string::utf8(b"BUY_ORDER")};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    entry fun sell_exact_in<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, true, true, v0, 0, arg5);
        let v4 = v2;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v3);
        let v5 = 0x2::balance::value<T1>(&v4);
        assert!(v5 >= arg4, 0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg6), 0x2::tx_context::sender(arg6));
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
        let v7 = OrderCompletedEvent{order_id: 0x1::string::utf8(b"SELL_ORDER")};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

