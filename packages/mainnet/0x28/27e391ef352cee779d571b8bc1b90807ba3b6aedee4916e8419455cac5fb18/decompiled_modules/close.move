module 0x2827e391ef352cee779d571b8bc1b90807ba3b6aedee4916e8419455cac5fb18::close {
    public fun close_smart<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg2);
        assert!(v0 > 0, 999);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, &mut arg2, v0, arg4, arg5, arg0, arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T1>(arg1, &mut arg2, arg0, arg3, arg7), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg1, &mut arg2, arg0, arg3, arg7), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg1, &mut arg2, arg0, arg3, arg7), arg6);
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, &mut arg2, arg0, arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, arg6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg2, arg3, arg7);
    }

    // decompiled from Move bytecode v6
}

