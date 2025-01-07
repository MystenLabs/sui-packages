module 0x4a04c4f7ff0433eb04924695f1ea89e3a5ba4c94ffa5547d263185434be00e69::cin {
    struct CIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIN>(arg0, 6, b"CIN", b"CIN ", b"I don't really like sharing information or explaining myself, so I'll leave it to you to decide for yourself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734229507897.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

