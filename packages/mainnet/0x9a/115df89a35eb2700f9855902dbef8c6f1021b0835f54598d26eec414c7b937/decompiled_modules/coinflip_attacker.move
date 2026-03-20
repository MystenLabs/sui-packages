module 0x9a115df89a35eb2700f9855902dbef8c6f1021b0835f54598d26eec414c7b937::coinflip_attacker {
    public entry fun attack(arg0: &mut 0x9a115df89a35eb2700f9855902dbef8c6f1021b0835f54598d26eec414c7b937::flash_pool::FlashPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

