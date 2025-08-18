module 0x1a84ec20523396bcd536a3a2405a6f7cacf9c80506b39196ca0d3c9fe4dbf28e::reward_collector {
    public fun collectFees<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg0, arg1, arg2, arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg4);
    }

    public fun collectReward<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

