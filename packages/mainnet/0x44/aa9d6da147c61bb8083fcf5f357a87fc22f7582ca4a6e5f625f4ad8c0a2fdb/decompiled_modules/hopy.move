module 0x44aa9d6da147c61bb8083fcf5f357a87fc22f7582ca4a6e5f625f4ad8c0a2fdb::hopy {
    struct HOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPY>(arg0, 6, b"HOPY", b"Sui Hopy", b"Hopy is an adorable little hippo calf that is endangered", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010990_53d36aeec9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

