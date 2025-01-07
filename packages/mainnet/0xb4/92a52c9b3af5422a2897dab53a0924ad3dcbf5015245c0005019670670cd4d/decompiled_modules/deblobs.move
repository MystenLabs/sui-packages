module 0xb492a52c9b3af5422a2897dab53a0924ad3dcbf5015245c0005019670670cd4d::deblobs {
    struct DEBLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEBLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEBLOBS>(arg0, 6, b"DeBlobs", b"De Blobs", b"De $blobs coming on SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954018834.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEBLOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEBLOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

