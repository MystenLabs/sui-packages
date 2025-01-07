module 0xa727816325edb75843f41fad5978a1d72bcc04fd40fb11a4e81355e9cfa79de2::beef {
    struct BEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEF>(arg0, 6, b"BEEF", b"PepeBull", b"Welcome to PepeBull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rrr_02c5352735.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

