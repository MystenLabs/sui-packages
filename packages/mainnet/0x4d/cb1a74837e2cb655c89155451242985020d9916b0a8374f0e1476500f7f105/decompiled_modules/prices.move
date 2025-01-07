module 0x4dcb1a74837e2cb655c89155451242985020d9916b0a8374f0e1476500f7f105::prices {
    struct PriceEvent has copy, drop, store {
        coin_a: u64,
        coin_b: u64,
    }

    public fun get_price<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container) : (u64, u64) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0));
        let v2 = PriceEvent{
            coin_a : v0,
            coin_b : v1,
        };
        0x2::event::emit<PriceEvent>(v2);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

