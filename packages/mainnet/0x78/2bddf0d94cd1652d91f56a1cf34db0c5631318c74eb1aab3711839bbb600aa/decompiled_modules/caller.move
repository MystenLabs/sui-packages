module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::caller {
    struct PRIVASUI has drop {
        version: u32,
    }

    public(friend) fun get_caller() : PRIVASUI {
        PRIVASUI{version: 1}
    }

    // decompiled from Move bytecode v6
}

