module 0xa712415260b72220b7ed6e78dcb56fba245907aa1a849ebc22f7516de8cd9a17::pupui {
    struct PUPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUI>(arg0, 6, b"PUPUI", b"PUPUI ON SUI", b"PUPUI bring meme to another level", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd3fc5sfq6n65uzjfezpxvkjlqrzyjugkssjc7zyf5l73dh4pkp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

