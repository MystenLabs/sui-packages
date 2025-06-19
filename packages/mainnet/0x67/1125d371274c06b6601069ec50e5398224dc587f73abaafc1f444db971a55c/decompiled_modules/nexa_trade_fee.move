module 0x671125d371274c06b6601069ec50e5398224dc587f73abaafc1f444db971a55c::nexa_trade_fee {
    struct NexaTradeEvent has copy, drop {
        user: address,
        coin_traded: 0x1::type_name::TypeName,
        sui_amount: u64,
        fee_sui: u64,
        fee_usd: u64,
        sui_price: u256,
        volume: u64,
        is_buy: bool,
    }

    struct NexaSwapEvent has copy, drop {
        user: address,
        coin_traded_a: 0x1::type_name::TypeName,
        coin_traded_b: 0x1::type_name::TypeName,
        sui_amount: u64,
        fee_sui: u64,
        fee_usd: u64,
        sui_price: u256,
        volume: u64,
    }

    struct NexaTradeFee has store, key {
        id: 0x2::object::UID,
        buy_fee: u256,
        sell_fee: u256,
        version: u8,
    }

    public fun new(arg0: &0x671125d371274c06b6601069ec50e5398224dc587f73abaafc1f444db971a55c::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NexaTradeFee{
            id       : 0x2::object::new(arg1),
            buy_fee  : 10000000000000000,
            sell_fee : 10000000000000000,
            version  : 1,
        };
        0x2::transfer::public_share_object<NexaTradeFee>(v0);
    }

    fun calculate_fee_amount(arg0: u256, arg1: u256) : u256 {
        let v0 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up(arg0, arg1, 1000000000000000000);
        let v1 = if (v0 != 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 == 0
        };
        assert!(v1, 1);
        v0
    }

    public fun register_fee<T0, T1>(arg0: &NexaTradeFee, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v1 as u256), arg2, 1000000000000000000);
        if (arg3) {
            0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1, (calculate_fee_amount((v1 as u256), arg0.buy_fee) as u64), arg4));
        } else {
            0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1, (calculate_fee_amount(v2, arg0.sell_fee) as u64), arg4));
        };
        let v3 = 0x2::coin::value<T0>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, @0x4a81a450d6cbb3c373c80b542c20523f7eab8c39c346ef521c54526e61d2baa6);
        let v4 = NexaTradeEvent{
            user        : 0x2::tx_context::sender(arg4),
            coin_traded : 0x1::type_name::get<T1>(),
            sui_amount  : v1,
            fee_sui     : v3,
            fee_usd     : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v3 as u256), arg2, 1000000000000000000) as u64),
            sui_price   : arg2,
            volume      : (v2 as u64),
            is_buy      : arg3,
        };
        0x2::event::emit<NexaTradeEvent>(v4);
        arg1
    }

    public fun register_fee_for_swap<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x1764e88da180ad063ac8dbfc652f4546cadc543b94683c2d64962f7a1b04bfcc);
        let v2 = NexaSwapEvent{
            user          : 0x2::tx_context::sender(arg2),
            coin_traded_a : 0x1::type_name::get<T1>(),
            coin_traded_b : 0x1::type_name::get<T2>(),
            sui_amount    : v1,
            fee_sui       : v0,
            fee_usd       : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v0 as u256), arg1, 1000000000000000000) as u64),
            sui_price     : arg1,
            volume        : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v1 as u256), arg1, 1000000000000000000) as u64),
        };
        0x2::event::emit<NexaSwapEvent>(v2);
    }

    public fun register_fee_v2<T0, T1>(arg0: &NexaTradeFee, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        if (arg3) {
            0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1, (calculate_fee_amount((v1 as u256), arg0.buy_fee) as u64), arg4));
        } else {
            0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1, (calculate_fee_amount((v1 as u256), arg0.sell_fee) as u64), arg4));
        };
        let v2 = 0x2::coin::value<T0>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, @0x1764e88da180ad063ac8dbfc652f4546cadc543b94683c2d64962f7a1b04bfcc);
        let v3 = NexaTradeEvent{
            user        : 0x2::tx_context::sender(arg4),
            coin_traded : 0x1::type_name::get<T1>(),
            sui_amount  : v1,
            fee_sui     : v2,
            fee_usd     : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v2 as u256), arg2, 1000000000000000000) as u64),
            sui_price   : arg2,
            volume      : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v1 as u256), arg2, 1000000000000000000) as u64),
            is_buy      : arg3,
        };
        0x2::event::emit<NexaTradeEvent>(v3);
        arg1
    }

    public fun update_nexa_trade_fee(arg0: &0x671125d371274c06b6601069ec50e5398224dc587f73abaafc1f444db971a55c::app::AdminCap, arg1: &mut NexaTradeFee, arg2: 0x1::option::Option<u256>, arg3: 0x1::option::Option<u256>) {
        if (0x1::option::is_some<u256>(&arg2)) {
            let v0 = 0x1::option::extract<u256>(&mut arg2);
            assert!(v0 <= 20000000000000000, 0);
            arg1.buy_fee = v0;
        };
        if (0x1::option::is_some<u256>(&arg3)) {
            let v1 = 0x1::option::extract<u256>(&mut arg3);
            assert!(v1 <= 20000000000000000, 0);
            arg1.sell_fee = v1;
        };
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

