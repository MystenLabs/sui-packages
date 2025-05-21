module 0xb4c104b006bbee28fce459ae40bc4db6931b9d9276615205b468e4ab22aadbf5::address_utils {
    public fun address_to_string(arg0: address) : 0x1::string::String {
        0x2::address::to_string(arg0)
    }

    public fun string_to_address(arg0: &vector<u8>) : address {
        0x2::address::from_ascii_bytes(arg0)
    }

    // decompiled from Move bytecode v6
}

