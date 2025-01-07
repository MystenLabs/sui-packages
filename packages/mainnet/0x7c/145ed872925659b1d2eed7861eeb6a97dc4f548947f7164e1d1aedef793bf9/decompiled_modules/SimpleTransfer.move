module 0x7c145ed872925659b1d2eed7861eeb6a97dc4f548947f7164e1d1aedef793bf9::SimpleTransfer {
    public entry fun transfer_all_sui(arg0: 0x2::coin::Coin<u64>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

