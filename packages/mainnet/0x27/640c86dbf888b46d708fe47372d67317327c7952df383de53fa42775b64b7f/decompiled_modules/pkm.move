module 0x27640c86dbf888b46d708fe47372d67317327c7952df383de53fa42775b64b7f::pkm {
    struct PKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKM>(arg0, 6, b"PKM", b"POKEMON", b"go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia56riakzqt74rtgsir7iynnb6emtquvu345niwjtnxeej2zj5mf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PKM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

