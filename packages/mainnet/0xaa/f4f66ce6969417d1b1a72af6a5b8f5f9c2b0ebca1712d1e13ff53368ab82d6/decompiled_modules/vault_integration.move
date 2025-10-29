module 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::vault_integration {
    struct Balances has copy, drop {
        x: u64,
        y: u64,
    }

    public fun deviation(arg0: u128, arg1: u64, arg2: u64, arg3: u128) : u128 {
        0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(arg0, arg0), 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(arg1)), 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(arg2)), arg3) - 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(1)
    }

    public fun emit_virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        let v1 = Balances{
            x : 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(v0, arg0)),
            y : 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(v0, arg0)),
        };
        0x2::event::emit<Balances>(v1);
    }

    public fun liquidity(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(2), arg3), arg2 - 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(1)), arg0), 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(arg1))
    }

    public fun vault_sqrtprice(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(arg0, 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(1) + (0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(arg2, arg1) >> 1))
    }

    public fun virtual_balances(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : Balances {
        let v0 = liquidity(arg0, arg1, arg2, arg3);
        Balances{
            x : 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(v0, arg0)),
            y : 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(v0, arg0)),
        }
    }

    // decompiled from Move bytecode v6
}

