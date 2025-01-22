module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32 {
    struct Bytes32 has copy, drop, store {
        bytes: address,
    }

    public fun length(arg0: &Bytes32) : u64 {
        32
    }

    public fun from_bytes(arg0: vector<u8>) : Bytes32 {
        new(0x2::address::from_bytes(arg0))
    }

    public fun to_bytes(arg0: Bytes32) : vector<u8> {
        0x2::address::to_bytes(arg0.bytes)
    }

    public fun default() : Bytes32 {
        Bytes32{bytes: @0x0}
    }

    public fun from_address(arg0: address) : Bytes32 {
        new(arg0)
    }

    public fun new(arg0: address) : Bytes32 {
        Bytes32{bytes: arg0}
    }

    public(friend) fun peel(arg0: &mut 0x2::bcs::BCS) : Bytes32 {
        new(0x2::bcs::peel_address(arg0))
    }

    // decompiled from Move bytecode v6
}

