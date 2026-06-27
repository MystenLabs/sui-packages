module 0xd19e0550add69b8e334e35a34c22760c3dca9ddd9899c1b24765745d4306ee32::t {
    public fun go<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : u32 {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0)
    }

    // decompiled from Move bytecode v7
}

