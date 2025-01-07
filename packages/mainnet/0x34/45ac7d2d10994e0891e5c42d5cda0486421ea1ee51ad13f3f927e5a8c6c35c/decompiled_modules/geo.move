module 0x3445ac7d2d10994e0891e5c42d5cda0486421ea1ee51ad13f3f927e5a8c6c35c::geo {
    struct GEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEO>(arg0, 9, b"GEO", b"Geology", b"Mining and Geoligy working", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47775f36-ab5d-4aa7-bae2-8d5805d4f3b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

