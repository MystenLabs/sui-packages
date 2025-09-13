module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::timeout {
    struct Timeout has copy, drop, store {
        expiry: u64,
        fallback_lib: address,
    }

    public(friend) fun create(arg0: u64, arg1: address) : Timeout {
        Timeout{
            expiry       : arg0,
            fallback_lib : arg1,
        }
    }

    public(friend) fun create_with_grace_period(arg0: u64, arg1: address, arg2: &0x2::clock::Clock) : Timeout {
        Timeout{
            expiry       : 0x2::clock::timestamp_ms(arg2) / 1000 + arg0,
            fallback_lib : arg1,
        }
    }

    public fun expiry(arg0: &Timeout) : u64 {
        arg0.expiry
    }

    public fun fallback_lib(arg0: &Timeout) : address {
        arg0.fallback_lib
    }

    public fun is_expired(arg0: &Timeout, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry <= 0x2::clock::timestamp_ms(arg1) / 1000
    }

    // decompiled from Move bytecode v6
}

