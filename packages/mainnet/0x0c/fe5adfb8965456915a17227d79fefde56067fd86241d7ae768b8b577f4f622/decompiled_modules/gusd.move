module 0xcfe5adfb8965456915a17227d79fefde56067fd86241d7ae768b8b577f4f622::gusd {
    struct GUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSD>(arg0, 9, b"GUSD", b"G-United States Dollar", b"Doubleup's USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walrus-agg-main.bucketprotocol.io/v1/blobs/{blobId}")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

