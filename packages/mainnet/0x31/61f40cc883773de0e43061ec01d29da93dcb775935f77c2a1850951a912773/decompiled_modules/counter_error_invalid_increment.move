module 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_error_invalid_increment {
    public fun emit() {
        abort 9223372131344056321
    }

    public fun message() : vector<u8> {
        b"Number can't be incremented, must be more than 0"
    }

    public fun require(arg0: bool) {
        if (!arg0) {
            emit();
        };
    }

    // decompiled from Move bytecode v6
}

