module 0xbefdf372ed7b01a45561b71eb62ba2aed0370f7b79221d42ba1a14e8f75d6fe9::walrus {
    struct WalrusBlobId has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun from_bytes(arg0: vector<u8>) : WalrusBlobId {
        WalrusBlobId{bytes: arg0}
    }

    public fun to_bytes(arg0: &WalrusBlobId) : vector<u8> {
        arg0.bytes
    }

    // decompiled from Move bytecode v7
}

