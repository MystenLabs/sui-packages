module 0x9bc6d0db23ee3023c5700beaf08bfe1345a5ce29111d0ec89b37526671fde4ef::drain {
    struct DRAIN has drop {
        dummy_field: bool,
    }

    struct DrainNft has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DRAIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : DrainNft {
        DrainNft{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

