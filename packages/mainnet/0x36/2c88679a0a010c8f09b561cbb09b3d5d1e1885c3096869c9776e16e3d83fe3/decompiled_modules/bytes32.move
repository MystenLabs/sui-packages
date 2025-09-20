module 0x362c88679a0a010c8f09b561cbb09b3d5d1e1885c3096869c9776e16e3d83fe3::bytes32 {
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

