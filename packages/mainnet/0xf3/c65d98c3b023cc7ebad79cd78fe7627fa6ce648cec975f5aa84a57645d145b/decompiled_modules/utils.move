module 0xf3c65d98c3b023cc7ebad79cd78fe7627fa6ce648cec975f5aa84a57645d145b::utils {
    public fun address_to_bytes(arg0: address) : vector<u8> {
        let v0 = 0x2::object::id_from_address(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    // decompiled from Move bytecode v6
}

