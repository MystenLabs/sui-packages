module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

