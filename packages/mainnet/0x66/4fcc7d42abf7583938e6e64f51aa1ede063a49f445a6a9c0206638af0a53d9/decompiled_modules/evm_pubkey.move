module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey {
    struct EvmPubkey has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun from_bytes(arg0: vector<u8>) : EvmPubkey {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 0);
        EvmPubkey{bytes: arg0}
    }

    public fun get_bytes(arg0: &EvmPubkey) : vector<u8> {
        arg0.bytes
    }

    // decompiled from Move bytecode v6
}

