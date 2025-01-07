module 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_error_invalid_increment {
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

