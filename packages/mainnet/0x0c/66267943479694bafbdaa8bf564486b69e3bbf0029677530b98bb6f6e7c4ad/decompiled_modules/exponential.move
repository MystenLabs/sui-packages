module 0xc66267943479694bafbdaa8bf564486b69e3bbf0029677530b98bb6f6e7c4ad::exponential {
    public fun exponential_down(arg0: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::neg(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(unit_raw(arg0))))
    }

    public fun exponential_up(arg0: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::neg(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(unit_raw(arg0))))
    }

    fun unit_raw(arg0: u64) : u256 {
        1000000000000000000 - ((arg0 as u256) * 1000000000000000000 >> 64)
    }

    // decompiled from Move bytecode v7
}

