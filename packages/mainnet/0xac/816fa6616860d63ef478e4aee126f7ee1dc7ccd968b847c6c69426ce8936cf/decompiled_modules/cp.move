module 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::cp {
    public fun check_bucket(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: u256, arg2: u256, arg3: u256, arg4: bool) {
        if (!0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::checking(arg0)) {
            return
        };
        let v0 = 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_amount(arg0);
        let v1 = if ((v0 as u256) > arg3) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v1) {
            0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_step(arg0, 0, 0, arg4);
            return
        };
        let v2 = (v0 as u256) * 1000000000 / arg2 / 1000000;
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_step(arg0, v0, ((v2 - (v2 * (1000000 - arg1 / 1000000000) + 500000) / 1000000) as u64), arg4);
    }

    public fun check_suidex<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool, arg3: bool) {
        if (!0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::checking(arg0)) {
            return
        };
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg1);
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        let v5 = 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_amount(arg0);
        let v6 = (v5 as u256) * 9970;
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_step(arg0, v5, ((v6 * v4 / (v3 * 10000 + v6)) as u64), arg3);
    }

    public fun suidex<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool) {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg1);
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        if (v3 == 0 || v4 == 0) {
            0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_closed(arg0);
            return
        };
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold(arg0, v4 * 9970, 9970, v3 * 10000);
    }

    // decompiled from Move bytecode v7
}

