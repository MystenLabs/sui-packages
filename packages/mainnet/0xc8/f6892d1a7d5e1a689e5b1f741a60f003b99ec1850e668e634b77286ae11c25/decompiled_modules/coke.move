module 0xc8f6892d1a7d5e1a689e5b1f741a60f003b99ec1850e668e634b77286ae11c25::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKE>(arg0, 6, b"COKE", b"Cocaine Whale", b"Whale hello there - want to party? Website link below soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_2_2e08e0efdf.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

