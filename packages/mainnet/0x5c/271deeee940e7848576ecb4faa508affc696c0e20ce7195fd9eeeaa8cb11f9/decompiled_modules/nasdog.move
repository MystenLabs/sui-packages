module 0x5c271deeee940e7848576ecb4faa508affc696c0e20ce7195fd9eeeaa8cb11f9::nasdog {
    struct NASDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDOG>(arg0, 6, b"NASDOG", b"Nasdog", b"The Nasdaq of Dogs. Nasdog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NASDOG_df85eea303.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NASDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

