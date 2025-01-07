module 0x2566492b48d124d881c404d7964d57ad90901bbbd53d9285407c87b35bdb7af3::alexisdog {
    struct ALEXISDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEXISDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEXISDOG>(arg0, 9, b"AlexIsDog", b"ALEX FARMER DEV", b"https://t.me/alexflashthefarmer ALEX FLASH CALL IS FARMER YOUTUBE DEV SCUMBAG NEVER BUY IF HE ON GROUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALEXISDOG>(&mut v2, 6845958000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEXISDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALEXISDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

