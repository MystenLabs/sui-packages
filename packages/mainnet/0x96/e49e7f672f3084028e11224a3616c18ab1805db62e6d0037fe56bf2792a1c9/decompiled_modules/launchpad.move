module 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

