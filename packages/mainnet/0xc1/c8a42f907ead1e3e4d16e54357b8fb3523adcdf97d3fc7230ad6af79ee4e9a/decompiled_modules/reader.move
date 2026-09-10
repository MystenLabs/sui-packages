module 0xc1c8a42f907ead1e3e4d16e54357b8fb3523adcdf97d3fc7230ad6af79ee4e9a::reader {
    public fun current<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : (u128, u128, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global>(arg0);
        assert!(0x1::vector::length<u8>(&v0) <= 4096, 901);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        let v2 = 0x2::bcs::new(0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1));
        0x2::bcs::peel_address(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        0x2::bcs::peel_u64(&mut v2);
        let v3 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::is_empty<u8>(&v3), 900);
        ((0x2::bcs::peel_u64(&mut v2) as u128), (0x2::bcs::peel_u64(&mut v2) as u128), 0x2::bcs::peel_u64(&mut v2), !0x2::bcs::peel_bool(&mut v1))
    }

    public fun pool_bcs<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : vector<u8> {
        0x1::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0)
    }

    // decompiled from Move bytecode v7
}

