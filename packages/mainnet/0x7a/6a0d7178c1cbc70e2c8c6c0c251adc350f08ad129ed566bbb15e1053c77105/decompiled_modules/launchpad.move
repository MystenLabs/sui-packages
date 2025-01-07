module 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

