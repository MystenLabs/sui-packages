module 0x8f475be2665e5d7c0421a63739fff4514ea33a60bee3d19bee6b36205aa70d1d::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 9, b"NEKO", b"Nekotan", b"Nekotan is a vibrant cryptocurrency inspired by anime culture, featuring a cute cat mascot. It fosters community engagement and rewards creativity, connecting anime fans in a fun and innovative ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff4abbe1-5dec-413f-830b-4d7ab883c190.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

