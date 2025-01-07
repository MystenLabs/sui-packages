module 0x70b6b9f6b889454c69c9fe7156337b20ccbbbcf6aa3878056a4f29e2f89d046::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 9, b"PURR", b"PurrCoin", b"PurrCoin is the ultimate meme cryptocurrency, powered by the purr-fect vibes of a playful community. With its cheeky mascot leading the charge, PurrCoin aims to bring joy, laughter, and a touch of cosmic luck to the world of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f6ecd42-20c0-410f-8b23-817b8044ba79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

