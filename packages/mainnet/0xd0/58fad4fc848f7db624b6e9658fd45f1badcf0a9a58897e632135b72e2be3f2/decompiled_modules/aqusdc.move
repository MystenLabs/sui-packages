module 0xd058fad4fc848f7db624b6e9658fd45f1badcf0a9a58897e632135b72e2be3f2::aqusdc {
    struct AQUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUSDC>(arg0, 6, b"aqUSDC", b"AquaYield USDC", b"Yield-bearing USDC vault token from AquaYield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/LGWQ0045SzePRFHnuGK5mxF25zBOToRmEpWrUSpSkOI")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

