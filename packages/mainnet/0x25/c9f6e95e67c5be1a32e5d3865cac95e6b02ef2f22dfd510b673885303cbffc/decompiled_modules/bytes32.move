module 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32 {
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

