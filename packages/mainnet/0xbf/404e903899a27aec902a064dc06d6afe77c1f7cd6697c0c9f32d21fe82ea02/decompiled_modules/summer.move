module 0xbf404e903899a27aec902a064dc06d6afe77c1f7cd6697c0c9f32d21fe82ea02::summer {
    struct SUMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMER>(arg0, 9, b"SUMMER", b"Summer", b"Summer Smith", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b899e80-32b3-4afc-9b11-b1bee87a2016.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

