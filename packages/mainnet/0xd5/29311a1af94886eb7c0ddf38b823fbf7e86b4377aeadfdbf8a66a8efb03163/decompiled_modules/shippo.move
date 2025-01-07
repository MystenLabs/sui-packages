module 0xd529311a1af94886eb7c0ddf38b823fbf7e86b4377aeadfdbf8a66a8efb03163::shippo {
    struct SHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIPPO>(arg0, 6, b"SHIPPO", b"Sui Hippo", b"In Sui Wonderland, the Blue Hippo controls magical blockchain streams, unlocking wealth and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_49d624615c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

