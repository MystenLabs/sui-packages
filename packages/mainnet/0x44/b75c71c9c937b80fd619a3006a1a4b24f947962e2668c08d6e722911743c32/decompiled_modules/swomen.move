module 0x44b75c71c9c937b80fd619a3006a1a4b24f947962e2668c08d6e722911743c32::swomen {
    struct SWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOMEN>(arg0, 6, b"SWOMEN", b"Suiwomen", b"Who run the world? ... Women! $SWOMEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_20_59_56_71a37e29a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

