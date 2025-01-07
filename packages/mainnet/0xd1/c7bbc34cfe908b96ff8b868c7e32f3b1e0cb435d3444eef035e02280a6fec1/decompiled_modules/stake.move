module 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::stake {
    public fun increase_stake<T0>(arg0: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::StakeReceiptWithPoints, arg3: &0x2::clock::Clock, arg4: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg5: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg4);
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::increase_stake<T0>(arg0, arg1, arg2, arg5, arg3, arg6);
    }

    public fun stake<T0>(arg0: &mut 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::Version, arg4: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::StakeReceiptWithPoints {
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::version::assert_supported_version(arg3);
        0xd1c7bbc34cfe908b96ff8b868c7e32f3b1e0cb435d3444eef035e02280a6fec1::farm::stake<T0>(arg0, arg1, arg2, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

