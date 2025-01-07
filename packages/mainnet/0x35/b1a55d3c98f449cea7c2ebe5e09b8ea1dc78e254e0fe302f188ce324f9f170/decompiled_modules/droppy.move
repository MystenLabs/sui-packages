module 0x35b1a55d3c98f449cea7c2ebe5e09b8ea1dc78e254e0fe302f188ce324f9f170::droppy {
    struct DROPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPY>(arg0, 6, b"Droppy", b"DroppyOnSui", b"Play the Droppy on Sui Telegram minigame", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zrzut_ekranu_2024_09_18_135736_d0f8434840.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

