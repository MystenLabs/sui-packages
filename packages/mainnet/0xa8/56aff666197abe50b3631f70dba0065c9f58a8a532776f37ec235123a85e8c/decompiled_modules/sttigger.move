module 0xa856aff666197abe50b3631f70dba0065c9f58a8a532776f37ec235123a85e8c::sttigger {
    struct STTIGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STTIGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STTIGGER>(arg0, 6, b"STTigger", b"SuiTigger", x"2453545469676765723a245355490a41207469676765722066726f6d2053554920616e642077696c6c20746f20676f206d6f6f6e2c2066617374206669726520616e6420717569636b2067726f77207570212121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_48bb06b52d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STTIGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STTIGGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

