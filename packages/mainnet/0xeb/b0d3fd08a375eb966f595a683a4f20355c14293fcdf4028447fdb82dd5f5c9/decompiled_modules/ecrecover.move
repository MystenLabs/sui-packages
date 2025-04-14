module 0xebb0d3fd08a375eb966f595a683a4f20355c14293fcdf4028447fdb82dd5f5c9::ecrecover {
    struct EvmRecoveredEvent has copy, drop {
        evm_addr: vector<u8>,
    }

    fun sub_range(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun test_ecrecover(arg0: address, arg1: u64, arg2: &vector<u8>, arg3: &0x2::clock::Clock) : vector<u8> {
        assert!(0x2::clock::timestamp_ms(arg3) < arg1, 12);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 784;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, x"c0badfdeb4a0dfe2dc31d578b5df74f7e294f9617bc9d459ca2f9af5c4844251");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, x"19457468657265756d205369676e6564204d6573736167653a0a3332");
        0x1::vector::append<u8>(&mut v2, 0x2::hash::keccak256(&v0));
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg2, &v2, 1);
        let v4 = 0x2::hash::keccak256(&v3);
        sub_range(&v4, 12, 32)
    }

    public entry fun test_ecrecover_entry(arg0: u64, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = EvmRecoveredEvent{evm_addr: test_ecrecover(0x2::tx_context::sender(arg3), arg0, &arg1, arg2)};
        0x2::event::emit<EvmRecoveredEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

