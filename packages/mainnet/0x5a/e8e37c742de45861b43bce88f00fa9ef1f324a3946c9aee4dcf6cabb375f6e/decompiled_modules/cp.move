module 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::cp {
    public fun suidex<T0, T1>(arg0: &mut 0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::Probe, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool) {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg1);
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        if (v3 == 0 || v4 == 0) {
            0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold_closed(arg0);
            return
        };
        0x5ae8e37c742de45861b43bce88f00fa9ef1f324a3946c9aee4dcf6cabb375f6e::probe::fold(arg0, v4 * 9970, 9970, v3 * 10000);
    }

    // decompiled from Move bytecode v7
}

