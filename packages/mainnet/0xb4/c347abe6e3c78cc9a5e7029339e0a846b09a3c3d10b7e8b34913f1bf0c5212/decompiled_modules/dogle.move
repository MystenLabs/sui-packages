module 0xb4c347abe6e3c78cc9a5e7029339e0a846b09a3c3d10b7e8b34913f1bf0c5212::dogle {
    struct DOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLE>(arg0, 6, b"DOGLE", b"DogGoogle", b"Dogle is the google dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039228_5fe76edfd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

