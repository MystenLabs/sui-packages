module 0x20a390622e4e849e47050acde202c49fb3caaae2927c4d832e036e48fb5c483b::hyd {
    struct HYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYD>(arg0, 9, b"HYD", b"Haydar", b"Haydar haydar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab883d0f-be05-4d2e-acac-7911955b59d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

