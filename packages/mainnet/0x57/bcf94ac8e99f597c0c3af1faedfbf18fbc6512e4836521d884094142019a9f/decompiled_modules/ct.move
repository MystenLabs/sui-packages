module 0x57bcf94ac8e99f597c0c3af1faedfbf18fbc6512e4836521d884094142019a9f::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 6, b"CT", b"City", b"City view is cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6GV0A2AGAFB6JPVDCVHSKD/01JB716K1X8GBYWSX5X87BN25H")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

