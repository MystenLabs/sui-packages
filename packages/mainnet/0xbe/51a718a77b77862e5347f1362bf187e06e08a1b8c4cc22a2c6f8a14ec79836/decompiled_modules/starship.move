module 0xbe51a718a77b77862e5347f1362bf187e06e08a1b8c4cc22a2c6f8a14ec79836::starship {
    struct STARSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP>(arg0, 6, b"STARSHIP", b"Starship", b"The starship will land people on Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731796692287.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARSHIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

