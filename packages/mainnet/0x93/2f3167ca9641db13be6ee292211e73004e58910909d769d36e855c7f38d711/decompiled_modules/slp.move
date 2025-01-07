module 0x932f3167ca9641db13be6ee292211e73004e58910909d769d36e855c7f38d711::slp {
    struct SLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP>(arg0, 9, b"SLP", b"Strater LP token for assets management", b"SLP is the Strater liquidity provider token that consists of a basket of crypto assets used for liquidity mining and other strategies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSPtmG45f3CvnfzGTw7upoeTvadYmf58sF4JPwA97qkg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

