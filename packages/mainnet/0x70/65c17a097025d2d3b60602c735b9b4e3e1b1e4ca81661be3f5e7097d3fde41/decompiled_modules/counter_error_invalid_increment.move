module 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_error_invalid_increment {
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

