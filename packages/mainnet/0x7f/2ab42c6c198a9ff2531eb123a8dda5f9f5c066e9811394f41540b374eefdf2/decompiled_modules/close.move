module 0x7f2ab42c6c198a9ff2531eb123a8dda5f9f5c066e9811394f41540b374eefdf2::close {
    public fun close_smart<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg6);
        let v1 = false;
        if (v0 >= 1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 0) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 2 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 1) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 3 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 2) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 4 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 3) as u64)) > 0) {
            v1 = true;
        };
        if (v0 >= 5 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 4) as u64)) > 0) {
            v1 = true;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, arg7);
        if (v1) {
            if (v0 >= 1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 0) as u64)) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg1, &mut arg2, arg0, arg5, arg8), arg7);
            };
            if (v0 >= 2 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 1) as u64)) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T3>(arg1, &mut arg2, arg0, arg5, arg8), arg7);
            };
            if (v0 >= 3 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 2) as u64)) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T4>(arg1, &mut arg2, arg0, arg5, arg8), arg7);
            };
            if (v0 >= 4 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 3) as u64)) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T5>(arg1, &mut arg2, arg0, arg5, arg8), arg7);
            };
            if (v0 >= 5 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::coins_owed_reward(&arg2, (*0x1::vector::borrow<u8>(&arg6, 4) as u64)) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T6>>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T6>(arg1, &mut arg2, arg0, arg5, arg8), arg7);
            };
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg2, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

