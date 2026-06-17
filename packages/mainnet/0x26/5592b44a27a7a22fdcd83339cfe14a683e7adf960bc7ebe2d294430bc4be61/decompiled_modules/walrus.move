module 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::walrus {
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

