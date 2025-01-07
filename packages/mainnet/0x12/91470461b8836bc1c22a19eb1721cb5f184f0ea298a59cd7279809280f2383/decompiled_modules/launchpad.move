module 0x1291470461b8836bc1c22a19eb1721cb5f184f0ea298a59cd7279809280f2383::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

