module 0xdeba4ec48253ea233d6597de45709c8cb9ec754598368ad9b9b0c29de76b6608::nlyra {
    struct NLYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLYRA>(arg0, 6, b"NLYRA", b"Lyra Seven", x"535549206e61746976652076657273696f6e206f66204149206167656e74206c61756e63686564206f6e2064616f732066756e2061742053756d6d657220323032352e200a0a496e206f70656e20636f6e6e656374656420746f204e616e6f20576f726c642020766f6c2e203120616e6420766f6c2e2032204e465420636f6c6c656374696f6e2c206173207374616b696e67207265776f72642e20466f72206d6f72652064657461696c7320666f6c6c6f77206f757220582e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifasnpqamixh2rvtv3rvukkgkj22jq65eyyccox6knsucor44ua2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NLYRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

