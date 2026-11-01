module 0x36b4a91087080d013a45cc5d1ff62d9248719e8375a33b93d3f5696222effde7::ferra_lb {
    public(friend) fun consumed(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        (arg0 - arg1, arg2)
    }

    public fun quote<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg1, arg2, arg3);
        consumed(arg1, v0, v1)
    }

    public fun upper<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool) : (u256, u256) {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        upper_rate((0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0)) as u256), (0x2::bcs::peel_u16(&mut v0) as u256), (0x2::bcs::peel_u32(&mut v0) as u256), arg1)
    }

    public(friend) fun upper_rate(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : (u256, u256) {
        let v0 = arg2 * arg1;
        let v1 = if (v0 > 100000000) {
            100000000
        } else {
            v0
        };
        let v2 = 1000000000;
        if (arg3) {
            (arg0 * (v2 - v1), 18446744073709551616 * v2)
        } else {
            (18446744073709551616 * (v2 - v1), arg0 * v2)
        }
    }

    // decompiled from Move bytecode v7
}

