module 0xb40eff0bb1190ecb4325a7f453b3874c09fc396b39349ac876077822ee386199::wssr {
    struct WSSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSSR>(arg0, 6, b"WSSR", b"Wasser", b"Community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3131_4b98cb718d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

