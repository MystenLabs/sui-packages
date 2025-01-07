module 0xfbd6e80a5e497d92334ccac432adf587d21569be2baf35c5d84a0aea51d3c7ee::geo {
    struct GEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEO>(arg0, 9, b"GEO", b"Geology", b"Mining and Geoligy working", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ca11325-8fef-458f-8824-cd66a958362f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

