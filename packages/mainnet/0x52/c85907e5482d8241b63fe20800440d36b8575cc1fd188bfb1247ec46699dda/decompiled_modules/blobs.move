module 0x52c85907e5482d8241b63fe20800440d36b8575cc1fd188bfb1247ec46699dda::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"Blobs", b"DeBlobs", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_S1_K4xsb_400x400_4f72b311ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

