module 0x35a384a257e73e4e1c3df8ab7e6e3436a6bca4e9d925bceb3b2fc08516822808::sui25 {
    struct SUI25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI25>(arg0, 6, b"Sui25", b"25sui", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_834b5bf083.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI25>>(v1);
    }

    // decompiled from Move bytecode v6
}

