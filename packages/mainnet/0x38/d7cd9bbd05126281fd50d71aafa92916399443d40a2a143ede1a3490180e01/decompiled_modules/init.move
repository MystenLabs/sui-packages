module 0x38d7cd9bbd05126281fd50d71aafa92916399443d40a2a143ede1a3490180e01::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

