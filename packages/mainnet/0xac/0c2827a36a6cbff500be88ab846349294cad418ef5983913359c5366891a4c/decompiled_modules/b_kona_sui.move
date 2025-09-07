module 0xac0c2827a36a6cbff500be88ab846349294cad418ef5983913359c5366891a4c::b_kona_sui {
    struct B_KONA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KONA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KONA_SUI>(arg0, 9, b"bkonaSUI", b"bToken konaSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KONA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KONA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

