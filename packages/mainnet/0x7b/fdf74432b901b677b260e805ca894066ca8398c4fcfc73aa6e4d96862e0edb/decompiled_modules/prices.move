module 0x7bfdf74432b901b677b260e805ca894066ca8398c4fcfc73aa6e4d96862e0edb::prices {
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

