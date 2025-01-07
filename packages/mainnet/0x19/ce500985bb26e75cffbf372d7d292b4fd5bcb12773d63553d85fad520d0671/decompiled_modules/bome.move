module 0x19ce500985bb26e75cffbf372d7d292b4fd5bcb12773d63553d85fad520d0671::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 6, b"BOME", b"BOOK OF MEMES", b"The book that changed it all. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005486_46914da8f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

