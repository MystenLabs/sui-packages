module 0xea825f18b5b02b464c21a36d729d57211b77aca8bc6c22faa4ce06fe523d14b0::sfrogt {
    struct SFROGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROGT>(arg0, 6, b"SFROGT", b"Super Frog Turbo", b"SuperFrog Meme Token: SuperFrog is a fun, community-driven meme cryptocurrency inspired by the heroic spirit of frogs. Combining humor, creativity, and decentralization, SuperFrog aims to empower its holders while leaping into the meme token space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733467206762.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFROGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

