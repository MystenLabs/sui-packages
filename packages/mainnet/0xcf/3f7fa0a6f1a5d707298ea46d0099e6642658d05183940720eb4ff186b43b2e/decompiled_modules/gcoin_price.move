module 0xcf3f7fa0a6f1a5d707298ea46d0099e6642658d05183940720eb4ff186b43b2e::gcoin_price {
    public fun get_price<T0>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: u64) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0);
        let (v0, _, v2, _, v4, _) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::house_metadata<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0));
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(v0 + v4, v2), arg1))
    }

    // decompiled from Move bytecode v6
}

