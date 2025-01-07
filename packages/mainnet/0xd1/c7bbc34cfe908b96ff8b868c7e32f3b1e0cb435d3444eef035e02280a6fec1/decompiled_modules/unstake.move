module 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::unstake {
    public fun unstake<T0>(arg0: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg1: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::StakeReceiptWithPoints, arg2: u64, arg3: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg4: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg3);
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::unstake<T0>(arg0, arg1, arg2, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

