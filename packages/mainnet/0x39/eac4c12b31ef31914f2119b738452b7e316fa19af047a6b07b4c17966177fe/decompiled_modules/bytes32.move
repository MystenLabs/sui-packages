module 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32 {
    struct Bytes32 has copy, drop, store {
        bytes: address,
    }

    public fun to_u256(arg0: &Bytes32) : u256 {
        0x2::address::to_u256(arg0.bytes)
    }

    public fun from_address(arg0: address) : Bytes32 {
        Bytes32{bytes: arg0}
    }

    public fun from_vec(arg0: vector<u8>) : Bytes32 {
        Bytes32{bytes: 0x2::address::from_bytes(arg0)}
    }

    public fun to_address(arg0: &Bytes32) : address {
        arg0.bytes
    }

    public fun to_vec(arg0: &Bytes32) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0.bytes)
    }

    // decompiled from Move bytecode v6
}

