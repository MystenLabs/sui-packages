module 0x53b174080a9226d17aacd343aa38e46db6f0801fb436f08c07257caab2fa6d0d::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"BLOBS", b"DeBlobs", b"$BLOBS is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974780657.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

