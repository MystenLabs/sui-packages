module 0x38f9fe1eaf76d0a8528d9c2fcb9ae9c1724b8ffcd3660a08795e927c4776a042::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x38f9fe1eaf76d0a8528d9c2fcb9ae9c1724b8ffcd3660a08795e927c4776a042::constructor::create_coin<GROW_SUI>(arg0, b"SUI", b"Grow SUI yield-bearing stablecoin", b"https://example.com/sui.png", arg1);
    }

    // decompiled from Move bytecode v6
}

