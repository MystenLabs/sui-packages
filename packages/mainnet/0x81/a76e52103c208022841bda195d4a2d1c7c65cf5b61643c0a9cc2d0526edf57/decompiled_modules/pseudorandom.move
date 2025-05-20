module 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::pseudorandom {
    struct PseudoRandomCounter has store, key {
        id: 0x2::object::UID,
        value: u256,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PseudoRandomCounter {
        PseudoRandomCounter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    fun increment(arg0: &mut PseudoRandomCounter) : u256 {
        let v0 = &mut arg0.value;
        *v0 = *v0 + 1;
        *v0
    }

    public(friend) fun rand(arg0: &mut PseudoRandomCounter, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = increment(arg0);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x2::object::new(arg2);
        0x2::object::delete(v3);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::append<u8>(v5, arg1);
        0x1::vector::append<u8>(v5, 0x1::bcs::to_bytes<u256>(&v0));
        0x1::vector::append<u8>(v5, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(v5, 0x1::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(v5, 0x2::object::uid_to_bytes(&v3));
        0x1::hash::sha3_256(*v5)
    }

    public(friend) fun select_u64(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 32, 2);
        ((u256_from_bytes(arg1) % (arg0 as u256)) as u64)
    }

    fun u256_from_bytes(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(v1 <= 32, 1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 << 8;
            v0 = v3 + (*0x1::vector::borrow<u8>(arg0, v2) as u256);
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

