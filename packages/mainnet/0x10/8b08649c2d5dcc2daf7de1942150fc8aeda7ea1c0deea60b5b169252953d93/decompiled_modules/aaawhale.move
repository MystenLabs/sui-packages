module 0x108b08649c2d5dcc2daf7de1942150fc8aeda7ea1c0deea60b5b169252953d93::aaawhale {
    struct AAAWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWHALE>(arg0, 6, b"AAAWHALE", b"AAA Whale", b"AAA Whale is the next big thing on the Sui network, a meme that represents power and influence in the crypto world! Just like the massive whales in the financial ocean, AAA Whale makes waves in the blockchain space. Hold tight, because with AAA, you're not just riding the tideyoure creating it. Get ready to join the pod and make some serious moves with this fun and mighty meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000248644_2ce9c5511c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

