module 0x7808c5c73fb46da980905c867789aa33900f4ad8e874b139354a1bf379be26eb::mmt_adapter {
    public fun get_mmt_price<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>) : u128 {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, 0x2::sui::SUI>(arg0)
    }

    // decompiled from Move bytecode v6
}

