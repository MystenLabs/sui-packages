module 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::swap {
    public fun exact_in(arg0: bool, arg1: u64, arg2: u128, arg3: u128) : u64 {
        if (arg0) {
            0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(arg3, arg2 - 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(arg3, 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(arg3, arg2) + 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(arg1))))
        } else {
            0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::floor(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(arg3, arg2) - 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(arg3, 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::mul_128(arg3, arg2) + 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::to_128(arg1), arg3)))
        }
    }

    // decompiled from Move bytecode v6
}

