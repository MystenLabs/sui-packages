module 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::counter_error_invalid_increment {
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

