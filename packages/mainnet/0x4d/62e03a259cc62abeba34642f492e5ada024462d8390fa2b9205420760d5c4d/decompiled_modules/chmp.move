module 0x4d62e03a259cc62abeba34642f492e5ada024462d8390fa2b9205420760d5c4d::chmp {
    struct CHMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHMP>(arg0, 9, b"CHMP", b"ChillChimp", b" Relaxed vibes, chilled returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/223dbac6-b5bc-4e98-9d1c-5323604e9ea3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

