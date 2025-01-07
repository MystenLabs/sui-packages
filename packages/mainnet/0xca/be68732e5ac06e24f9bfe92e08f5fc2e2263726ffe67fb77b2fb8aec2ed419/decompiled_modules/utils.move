module 0xcabe68732e5ac06e24f9bfe92e08f5fc2e2263726ffe67fb77b2fb8aec2ed419::utils {
    public fun get_key() : vector<u8> {
        x"5a10a38ac6bd0bcb49032237b8860b497e0326badaf0d6b30a47573644710421"
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

