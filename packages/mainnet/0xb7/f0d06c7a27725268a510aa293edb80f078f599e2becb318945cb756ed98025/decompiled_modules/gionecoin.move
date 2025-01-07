module 0xb7f0d06c7a27725268a510aa293edb80f078f599e2becb318945cb756ed98025::gionecoin {
    struct GIONECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIONECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIONECOIN>(arg0, 9, b"GIONECOIN", b"GIONE", b"Top meme gione coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55021a41-a1bb-47c7-979b-6339cdd86cf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIONECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIONECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

