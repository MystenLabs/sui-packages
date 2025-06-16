module 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::momentum {
    public fun open_position_and_add_liquidity<T0, T1>(arg0: &mut 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::PositionManager, arg1: &0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::OwnerCap, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg8: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg9: &0x2::clock::Clock, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::open_position<T0, T1>(arg0, arg1, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(arg7), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(arg8), arg11);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg2, arg7, arg8, arg10, arg11);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg9, arg10, arg11);
        0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::add_dof_manager<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v0), v0);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

