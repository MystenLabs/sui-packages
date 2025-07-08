module 0x393b714abca9f150026d820cf922ac0032614702e2102da574fc01db2a8e3302::earnos {
    public fun earnos_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

