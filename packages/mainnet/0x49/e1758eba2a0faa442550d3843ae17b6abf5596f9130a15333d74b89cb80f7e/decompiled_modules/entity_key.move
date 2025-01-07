module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::entity_key {
    public fun from_bytes(arg0: vector<u8>) : address {
        0x2::address::from_bytes(0x2::hash::keccak256(&arg0))
    }

    public fun from_u256(arg0: u256) : address {
        0x2::address::from_u256(arg0)
    }

    public fun from_object<T0: store + key>(arg0: &T0) : address {
        0x2::object::id_address<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

