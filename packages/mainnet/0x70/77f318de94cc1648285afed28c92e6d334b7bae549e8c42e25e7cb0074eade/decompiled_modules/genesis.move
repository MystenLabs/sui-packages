module 0x7077f318de94cc1648285afed28c92e6d334b7bae549e8c42e25e7cb0074eade::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GENESIS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

