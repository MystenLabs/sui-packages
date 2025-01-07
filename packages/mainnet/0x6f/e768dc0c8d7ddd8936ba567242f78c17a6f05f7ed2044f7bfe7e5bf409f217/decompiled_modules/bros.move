module 0x6fe768dc0c8d7ddd8936ba567242f78c17a6f05f7ed2044f7bfe7e5bf409f217::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"BROS", b"SuiBros", b"A meme token inspired by Mario Bros, bringing classic gaming vibes to the Sui blockchain! Jump in, join the community, and collect your coins in this one-of-a-kind crypto adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012035534.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

