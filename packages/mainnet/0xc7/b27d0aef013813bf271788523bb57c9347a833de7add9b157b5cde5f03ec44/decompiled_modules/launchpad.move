module 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::launchpad {
    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAUNCHPAD>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

