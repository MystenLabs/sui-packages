module 0xd33de2108b263a216ab82943b3f068ebd69e3544a25da626f139d6425381ba30::app {
    public entry fun seal_approve_admin(arg0: vector<u8>, arg1: address) {
        assert!(arg1 == @0x1234, 0);
    }

    public entry fun seal_approve_free(arg0: vector<u8>) {
    }

    public entry fun seal_approve_premium(arg0: vector<u8>, arg1: &0x2::clock::Clock) {
    }

    // decompiled from Move bytecode v6
}

