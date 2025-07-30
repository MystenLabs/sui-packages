module 0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::mmt_adapter {
    public fun get_raw_mmt_price<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : u128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        (((v0 as u256) * (v0 as u256) / (18446744073709551616 as u256)) as u128)
    }

    // decompiled from Move bytecode v6
}

