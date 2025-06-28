module 0xfb5bf9a64cd6c6311a256910f5417993250a64388713e2fa4ea78e0bab55dc4b::crypto {
    struct CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO>(arg0, 9, b"CRYPTO", b"meme", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/168d6f3fd881aae1458c786f4ac5f7a2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

