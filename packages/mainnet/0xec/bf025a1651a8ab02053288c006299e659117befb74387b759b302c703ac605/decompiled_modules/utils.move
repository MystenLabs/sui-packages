module 0xecbf025a1651a8ab02053288c006299e659117befb74387b759b302c703ac605::utils {
    public fun get_key() : vector<u8> {
        x"483ea7c2895606cd386c8274b8c9a33dba0105195aa8d36e7a33bea7af0a34dc"
    }

    public fun get_time_day() : u64 {
        86400000
    }

    public fun get_time_one_month() : u64 {
        2592000000
    }

    public fun get_time_phut() : u64 {
        60000
    }

    public fun get_time_week() : u64 {
        604800000
    }

    public fun math_time_claim(arg0: u64, arg1: u64) : u64 {
        arg0 + 86400000 - arg0 % 86400000 + arg1 * 2592000000
    }

    // decompiled from Move bytecode v6
}

