module 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::mmt_adapter {
    public fun get_raw_mmt_price<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : u128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        (((v0 as u256) * (v0 as u256) / (18446744073709551616 as u256)) as u128)
    }

    // decompiled from Move bytecode v6
}

