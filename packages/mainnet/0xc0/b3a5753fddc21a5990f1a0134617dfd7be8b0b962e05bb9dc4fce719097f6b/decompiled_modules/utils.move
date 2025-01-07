module 0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::utils {
    public fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    // decompiled from Move bytecode v6
}

