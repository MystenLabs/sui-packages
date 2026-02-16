module 0xdeb545c919241a2b8a961b36bdf3e1f421e272d075ea47c09d7d07ac8819caa4::close {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg2);
        assert!(v0 > 0, 999);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, &mut arg2, v0, arg4, arg5, arg0, arg3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T0>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg6)) {
            let v4 = (*0x1::vector::borrow<u8>(&arg6, v3) as u64);
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, v4) > 0) {
                if (v4 == 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
                };
                if (v4 == 1) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
                };
                if (v4 == 2) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T4>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
                };
                if (v4 == 3) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T5>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
                };
                if (v4 == 4) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T6>(arg1, &mut arg2, arg0, arg3, arg8), arg7);
                };
            };
            v3 = v3 + 1;
        };
        let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, &mut arg2, arg0, arg3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, arg7);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg2, arg3, arg8);
    }

    // decompiled from Move bytecode v6
}

