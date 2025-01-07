module 0x498a202079284dd53c8c390f4e65c1b8dfe1005dc712e8d080f7ae5cd8671a3b::senta {
    struct SENTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENTA>(arg0, 6, b"SENTA", b"Senta Klaws", b"Merry Christmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7114_1ad9c117bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

