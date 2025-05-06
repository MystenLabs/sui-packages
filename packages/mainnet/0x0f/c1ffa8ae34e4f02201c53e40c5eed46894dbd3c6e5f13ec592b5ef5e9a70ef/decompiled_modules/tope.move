module 0xfc1ffa8ae34e4f02201c53e40c5eed46894dbd3c6e5f13ec592b5ef5e9a70ef::tope {
    struct TOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPE>(arg0, 6, b"TOPE", b"TOILET PEPE", b"TOILET PEPE IS A GOOD MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6yijust4o42i77irkrk36cl3ury4vvvjmrt727vexqpjzcja7jy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

