module 0x754755ca0ffa2e8143a770ed9ca282249713ff2b86b20245737ab92aa5ea70d6::cetus_dlmm {
    struct SwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
    }

    public fun flash_swap<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v1;
        let v4 = v0;
        let v5 = if (arg1) {
            0x2::balance::value<T1>(&v3)
        } else {
            0x2::balance::value<T0>(&v4)
        };
        let v6 = SwapEvent{
            amount_in  : arg3,
            amount_out : v5,
        };
        0x2::event::emit<SwapEvent>(v6);
        (v4, v3, v2)
    }

    // decompiled from Move bytecode v6
}

