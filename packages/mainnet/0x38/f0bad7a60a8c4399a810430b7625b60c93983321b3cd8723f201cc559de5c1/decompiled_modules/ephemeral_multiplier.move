module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier {
    struct EphemeralMultiplier has copy, drop, store {
        multiplier: u64,
        expiry_time: u64,
        is_lock_based: bool,
    }

    public(friend) fun get_expiry_time(arg0: &EphemeralMultiplier) : u64 {
        arg0.expiry_time
    }

    public(friend) fun get_is_lock_based(arg0: &EphemeralMultiplier) : bool {
        arg0.is_lock_based
    }

    public(friend) fun get_multiplier(arg0: &EphemeralMultiplier) : u64 {
        arg0.multiplier
    }

    public(friend) fun new_ephemeral_multiplier(arg0: u64, arg1: u64, arg2: bool) : EphemeralMultiplier {
        EphemeralMultiplier{
            multiplier    : arg0,
            expiry_time   : arg1,
            is_lock_based : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

