module 0x12d374799dba7527141a7e64fbb2e0c8ac56cfb14b619704997815ec81ba9456::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 9, b"LEMON", b"Lemon", b"Lemon tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72add622-086b-4cf7-9291-072388c60cfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

