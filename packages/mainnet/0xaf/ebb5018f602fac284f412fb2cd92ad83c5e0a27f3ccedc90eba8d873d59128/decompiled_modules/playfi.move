module 0xafebb5018f602fac284f412fb2cd92ad83c5e0a27f3ccedc90eba8d873d59128::playfi {
    struct PLAYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAYFI>(arg0, 9, b"PLAYFI", b"Play", b"Playfi meme token. Buy this meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d7c4245-a7f9-4aae-89a7-6b6fb959648c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAYFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAYFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

