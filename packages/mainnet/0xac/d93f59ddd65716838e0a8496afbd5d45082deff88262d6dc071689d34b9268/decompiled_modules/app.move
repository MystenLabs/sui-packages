module 0xacd93f59ddd65716838e0a8496afbd5d45082deff88262d6dc071689d34b9268::app {
    public entry fun seal_approve_admin(arg0: vector<u8>, arg1: address) {
        assert!(arg1 == @0x1234, 0);
    }

    public entry fun seal_approve_free(arg0: vector<u8>) {
    }

    public entry fun seal_approve_premium(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
    }

    // decompiled from Move bytecode v6
}

