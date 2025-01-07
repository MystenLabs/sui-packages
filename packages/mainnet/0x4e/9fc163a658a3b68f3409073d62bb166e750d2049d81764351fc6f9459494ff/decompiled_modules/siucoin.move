module 0x4e9fc163a658a3b68f3409073d62bb166e750d2049d81764351fc6f9459494ff::siucoin {
    struct SIUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUCOIN>(arg0, 9, b"SIUCOIN", b"Siuuucoin ", b"Collection memcoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeaf0a98-2bd6-4ebd-8a8a-909425f8cd35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

