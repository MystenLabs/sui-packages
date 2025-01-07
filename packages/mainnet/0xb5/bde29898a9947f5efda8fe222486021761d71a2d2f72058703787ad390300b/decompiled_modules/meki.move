module 0xb5bde29898a9947f5efda8fe222486021761d71a2d2f72058703787ad390300b::meki {
    struct MEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKI>(arg0, 9, b"MEKI", b"Maneki", b"Maneki-Coin (MEKI) is a unique digital collectible token inspired by the Japanese Maneki-Neko (Lucky Cat) legend. MEKI embodies the symbolism of good fortune, prosperity, and success in the cryptocurrency market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66139597-75ec-4809-a878-826e5e85e012.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

