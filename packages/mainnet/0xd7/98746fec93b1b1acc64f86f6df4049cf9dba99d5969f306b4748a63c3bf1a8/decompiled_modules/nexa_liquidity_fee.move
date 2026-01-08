module 0xd798746fec93b1b1acc64f86f6df4049cf9dba99d5969f306b4748a63c3bf1a8::nexa_liquidity_fee {
    struct NexaLiquidityManageEvent has copy, drop {
        user: address,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        sui_amount: u64,
        fee_sui: u64,
        fee_usd: u64,
        sui_price: u256,
        volume: u64,
        pool_id: 0x1::string::String,
        position_id: 0x1::string::String,
        action_type: 0x1::string::String,
    }

    public fun register_fee_for_liquidity_management<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: u256, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = v0 * 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x1764e88da180ad063ac8dbfc652f4546cadc543b94683c2d64962f7a1b04bfcc);
        let v2 = NexaLiquidityManageEvent{
            user        : 0x2::tx_context::sender(arg5),
            coin_a      : 0x1::type_name::get<T1>(),
            coin_b      : 0x1::type_name::get<T2>(),
            sui_amount  : v1,
            fee_sui     : v0,
            fee_usd     : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v0 as u256), arg1, 1000000000000000000) as u64),
            sui_price   : arg1,
            volume      : (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::mul_div_up((v1 as u256), arg1, 1000000000000000000) as u64),
            pool_id     : arg2,
            position_id : arg3,
            action_type : arg4,
        };
        0x2::event::emit<NexaLiquidityManageEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

