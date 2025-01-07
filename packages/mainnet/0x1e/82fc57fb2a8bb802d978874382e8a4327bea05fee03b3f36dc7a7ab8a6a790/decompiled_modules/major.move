module 0x1e82fc57fb2a8bb802d978874382e8a4327bea05fee03b3f36dc7a7ab8a6a790::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 9, b"MAJOR", b"Major", b"Major meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f80e693e-4818-4320-82b0-d269a2689e11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

