module 0x80686b3237c2f7aa7e1aca46b0619c73dd916a8270800a126b03e1273af9a3a1::suitardio {
    struct SUITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARDIO>(arg0, 6, b"SUITARDIO", b"SUITARDIO SUI", b"SUITARDIO IS MEME FOR HSUI LFG PUMP IT UPPPP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x862c5f46431d4be2fc3042f9ded715b019b95126006a99df80a0904ba1f0cbe6_suitardio_suitardio_98777201d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

