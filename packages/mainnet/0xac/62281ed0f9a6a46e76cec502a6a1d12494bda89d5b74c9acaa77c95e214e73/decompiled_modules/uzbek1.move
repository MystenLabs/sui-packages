module 0xac62281ed0f9a6a46e76cec502a6a1d12494bda89d5b74c9acaa77c95e214e73::uzbek1 {
    struct UZBEK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UZBEK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UZBEK1>(arg0, 9, b"UZBEK1", b"Uzbek Meme", b"Uzbek Meme just a meme.Listings - 35% Marketing - 30% Team - 10.3%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0705eb79-2c2e-42db-95a4-0a99dd1d52c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UZBEK1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UZBEK1>>(v1);
    }

    // decompiled from Move bytecode v6
}

