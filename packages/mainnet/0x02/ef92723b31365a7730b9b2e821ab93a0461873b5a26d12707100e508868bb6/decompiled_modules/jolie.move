module 0x2ef92723b31365a7730b9b2e821ab93a0461873b5a26d12707100e508868bb6::jolie {
    struct JOLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLIE>(arg0, 6, b"JOLIE", b"Joliebee", b"test only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_6b809ce5c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

