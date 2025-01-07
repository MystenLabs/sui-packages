module 0x6828f083daf25b92dcc5f7bad2800f2fbd6d1d8a1e3ea15e1f148c26e84529cb::getter {
    struct OracleInfo has copy, drop {
        oracle_id: u8,
        price: u256,
        decimals: u8,
        valid: bool,
    }

    public fun get_oracle_info(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: vector<u8>) : vector<OracleInfo> {
        let v0 = 0x1::vector::empty<OracleInfo>();
        let v1 = 0x1::vector::length<u8>(&arg2);
        while (v1 > 0) {
            let v2 = 0x1::vector::borrow<u8>(&arg2, v1 - 1);
            let (v3, v4, v5) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::get_token_price(arg0, arg1, *v2);
            let v6 = OracleInfo{
                oracle_id : *v2,
                price     : v4,
                decimals  : v5,
                valid     : v3,
            };
            0x1::vector::push_back<OracleInfo>(&mut v0, v6);
            v1 = v1 - 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

