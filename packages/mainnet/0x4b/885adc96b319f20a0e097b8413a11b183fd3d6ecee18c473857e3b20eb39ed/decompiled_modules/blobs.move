module 0x4b885adc96b319f20a0e097b8413a11b183fd3d6ecee18c473857e3b20eb39ed::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"BLOBS", b"DeBlobs", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world. As the newest entrant on Hop.fun by hopaggregator, $blobs is set to disrupt the Sui ecosystem, bringing the meme energy with a serious backing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241106_200114_2110d579ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

