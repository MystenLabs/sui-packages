module 0x7304f71f782b1058f79732f6c937256bd06830bd9ea6258b05063f150e869a3f::curve {
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

