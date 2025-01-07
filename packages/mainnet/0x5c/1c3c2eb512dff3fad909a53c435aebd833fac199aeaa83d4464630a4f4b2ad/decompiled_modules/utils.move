module 0x5c1c3c2eb512dff3fad909a53c435aebd833fac199aeaa83d4464630a4f4b2ad::utils {
    public fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    // decompiled from Move bytecode v6
}

