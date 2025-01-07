module 0x65c9b94265f9332c116d38bc916f4629d5c307fd8e61f10f57979ce67529e491::pcon {
    struct PCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCON>(arg0, 9, b"PCON", b"Piece Coin", b"A piece of a coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/21e76e1cd4dbabfb3ea138ebe1732072blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

