module 0xc66267943479694bafbdaa8bf564486b69e3bbf0029677530b98bb6f6e7c4ad::gaussian {
    fun cell_mid(arg0: u64) : u256 {
        let v0 = ((arg0 as u256) * 2 + 1) * 1000000000000000000 >> 65;
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun normal_down(arg0: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::normal::inv_normal_cdf_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(cell_mid(arg0)))
    }

    public fun normal_up(arg0: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::normal::inv_normal_cdf_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(cell_mid(arg0)))
    }

    // decompiled from Move bytecode v7
}

