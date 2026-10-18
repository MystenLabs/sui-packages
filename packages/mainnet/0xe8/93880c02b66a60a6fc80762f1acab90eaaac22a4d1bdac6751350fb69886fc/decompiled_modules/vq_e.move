module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_e {
    public fun e<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock) {
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::checked_package_version(arg1);
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::global_paused(arg1) || p(0x2::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2));
        let v1 = 0;
        while (v1 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v2 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v1);
            if (v2 > 0) {
                let v3 = if (v0) {
                    0
                } else {
                    let (v4, v5, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg2, v2, arg3, arg4);
                    if (v4 > 0) {
                        0
                    } else {
                        v5
                    }
                };
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v1, v3);
            };
            v1 = v1 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg2), arg3);
    }

    fun p(arg0: vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(&arg0) > 32, 186);
        let v0 = *0x1::vector::borrow<u8>(&arg0, 32);
        assert!(v0 <= 1, 186);
        v0 == 1
    }

    // decompiled from Move bytecode v7
}

