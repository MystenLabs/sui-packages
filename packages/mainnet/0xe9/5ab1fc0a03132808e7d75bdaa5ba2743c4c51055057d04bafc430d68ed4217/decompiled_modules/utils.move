module 0xe95ab1fc0a03132808e7d75bdaa5ba2743c4c51055057d04bafc430d68ed4217::utils {
    public fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    // decompiled from Move bytecode v6
}

