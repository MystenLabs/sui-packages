module 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::curve {
    public fun curve(arg0: u128, arg1: u64, arg2: bool) : u64 {
        let v0 = (arg1 as u128) * arg0;
        if (arg2) {
            ((v0 * 0x1::u128::sqrt(1000000000000000000) / 0x1::u128::sqrt(1000000000000000000) * 0x1::u128::sqrt(1000000000000000000 + 0x1::u128::pow(v0 / 0x1::u128::sqrt(1000000000000000000), 2)) * 0x1::u128::sqrt(1000000000000000000)) as u64)
        } else {
            ((1000000000000000000 - v0 * 0x1::u128::sqrt(1000000000000000000) / 0x1::u128::sqrt(1000000000000000000) * 0x1::u128::sqrt(1000000000000000000 + 0x1::u128::pow(v0 / 0x1::u128::sqrt(1000000000000000000), 2)) * 0x1::u128::sqrt(1000000000000000000)) as u64)
        }
    }

    // decompiled from Move bytecode v6
}

