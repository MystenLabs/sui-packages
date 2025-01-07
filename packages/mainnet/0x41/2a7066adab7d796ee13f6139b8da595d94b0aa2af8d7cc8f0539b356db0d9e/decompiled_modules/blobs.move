module 0x412a7066adab7d796ee13f6139b8da595d94b0aa2af8d7cc8f0539b356db0d9e::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"Blobs", b"DeBlobs", b"De $blobs on SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957234780.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

