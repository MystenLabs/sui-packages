module 0x807dd1660c8c04f6f06b1c4f9abc045f3bfd2d1a46f6092c5e78149e751e2fb3::m9d2351a7eede1c7933ce7785 {
    public fun f2be3312cb35d57652f89fcb5<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun f84deec1b5206f45c5091c6d7<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

