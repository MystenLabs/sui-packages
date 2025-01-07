module 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::treasury {
    struct Treasury has store {
        treasurer: address,
    }

    public fun appoint(arg0: &mut Treasury, arg1: address) {
        abort 0
    }

    public(friend) fun new(arg0: address) : Treasury {
        abort 0
    }

    public fun treasurer(arg0: &Treasury) : address {
        abort 0
    }

    // decompiled from Move bytecode v6
}

