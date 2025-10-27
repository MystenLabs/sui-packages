module 0xfd5d94af944d1384a2f7dbda84c4480509c5ddab99b1b9fec1f2768ae7baaa3c::simple_burn {
    public fun burn_nft<T0: store + key>(arg0: T0) {
        0x2::transfer::public_transfer<T0>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

