module 0xeee97ede5cfd660d1a62af17a3842c1798c949f734c3bf64d8f57249d31d737e::base_module {
    struct X {
        field0: u64,
        field1: u64,
    }

    entry fun private_entry_fun(arg0: u64) {
    }

    fun private_fun() : u64 {
        30
    }

    public fun public_fun() : u64 {
        30
    }

    // decompiled from Move bytecode v6
}

