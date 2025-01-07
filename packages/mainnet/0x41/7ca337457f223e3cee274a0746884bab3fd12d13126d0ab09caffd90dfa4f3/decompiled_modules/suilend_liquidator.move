module 0x417ca337457f223e3cee274a0746884bab3fd12d13126d0ab09caffd90dfa4f3::suilend_liquidator {
    struct ObligationData has copy, drop {
        liquidator_id: 0x2::object::ID,
        is_healthy: bool,
        is_liquidatable: bool,
    }

    public fun get_obligations<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: vector<0x2::object::ID>) : vector<ObligationData> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<ObligationData>();
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, v2);
            let v4 = ObligationData{
                liquidator_id   : v2,
                is_healthy      : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_healthy<T0>(v3),
                is_liquidatable : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(v3),
            };
            0x1::vector::push_back<ObligationData>(&mut v1, v4);
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

