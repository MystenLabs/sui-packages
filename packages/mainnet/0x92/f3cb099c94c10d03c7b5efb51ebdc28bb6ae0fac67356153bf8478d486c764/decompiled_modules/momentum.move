module 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::momentum {
    public fun close_position_and_remove_liquidity<T0, T1>(arg0: &mut 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::PositionManager, arg1: &0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::ManagerCap, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u128, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::verify_manager_cap(arg0, arg1), 0);
        assert!(0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::position_exists<T0, T1>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), arg4, arg5), 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5);
        0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::remove_df_position<T0, T1>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), arg4, arg5);
        let v0 = 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::remove_dof_position<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2));
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg2, &mut v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v0), arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::get_manager_owner(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::get_manager_owner(arg0));
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg2, &mut v0, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::get_manager_owner(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::get_manager_owner(arg0));
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v0, arg9, arg10);
    }

    public fun open_position_and_add_liquidity<T0, T1>(arg0: &mut 0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::PositionManager, arg1: &0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::OwnerCap, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg8: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg9: &0x2::clock::Clock, arg10: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::open_position<T0, T1>(arg0, arg1, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(arg7), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(arg8), arg11);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg2, arg7, arg8, arg10, arg11);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg2, &mut v0, arg3, arg4, arg5, arg6, arg9, arg10, arg11);
        0xc75fa0e12c1f93f97ad56a060337ed525b43871632b33c6f9c73e5c6bb43026a::portfolio::add_dof_manager<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), v0);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

