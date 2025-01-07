module 0xbe335f73844a13e61f7b40105385ae0d8b4ce66f037182ba6d625ddcdb418699::lembingtok {
    struct LEMBINGTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMBINGTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMBINGTOK>(arg0, 9, b"LEMBINGTOK", b"Lembing", b"Meme koin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a71921a-608f-404d-abe2-5f4e17d61852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMBINGTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMBINGTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

