module 0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::cp {
    public fun suidex<T0, T1>(arg0: &mut 0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::Probe, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool) {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg1);
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        if (v3 == 0 || v4 == 0) {
            0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::fold_closed(arg0);
            return
        };
        0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::fold(arg0, v4 * 9970, 9970, v3 * 10000);
    }

    // decompiled from Move bytecode v7
}

