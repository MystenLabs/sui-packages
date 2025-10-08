module 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::mB {
    public fun dC<T0, T1>(arg0: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::dB::AP, arg1: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        if (arg3) {
            dD<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun dD<T0, T1>(arg0: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::dB::AP, arg1: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::gO<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, true, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, v0, 0x2::balance::zero<T1>(), arg3, arg5);
        0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::dB::eA<T0>(arg0, v2);
        0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::eA<T1>(arg1, v3);
    }

    fun eF<T0, T1>(arg0: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::dB::AP, arg1: &mut 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::AC, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::gO<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, false, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v4, 0x2::balance::zero<T0>(), v0, arg3, arg5);
        0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::dB::eA<T1>(arg0, v3);
        0x41d8f208dd534f41ea5af1a18ea027f786643832be510c7ab0b92610b4a6d906::cB::eA<T0>(arg1, v2);
    }

    // decompiled from Move bytecode v6
}

