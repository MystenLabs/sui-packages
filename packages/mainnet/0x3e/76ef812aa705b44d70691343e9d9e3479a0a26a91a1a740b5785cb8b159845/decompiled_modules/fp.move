module 0x3e76ef812aa705b44d70691343e9d9e3479a0a26a91a1a740b5785cb8b159845::fp {
    public fun cetus_dlmm<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u32, arg2: bool) {
        assert!(within(((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0)) ^ 2147483648) as u128), ((arg1 ^ 2147483648) as u128), arg2), 113);
    }

    public fun fullsail<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2), 107);
    }

    fun within(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 >= arg1 || arg0 <= arg1
    }

    // decompiled from Move bytecode v7
}

