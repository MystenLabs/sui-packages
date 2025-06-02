module 0x60d5e8d8d644da5bee444a5999775422b7fcaf63024274e7f3a36d0877f2c318::trenches {
    struct TRENCHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHES>(arg0, 6, b"TRENCHES", b"Sui Trenches", b"Official Coin of Sui Trenches, alpha and insight into crypto leading products and apps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsuz54zx3spwlbvfk6jooxef5fte4zacy6qrgkvzeyfq2nh3ka7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRENCHES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

