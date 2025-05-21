module 0x473f16ec1501476993f6af0940a1b85fb062429549a33ff91aeebbdae34d7496::bananza {
    struct BANANZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANZA>(arg0, 6, b"BANANZA", b"Sui Bananza", b"Welcome to Bananza, where the markets slip, slide, and go absolutely bananas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegb5byetsgn6ibucjk5rvqif6ngmbywveh2g7rsrwwptitqdkbty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BANANZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

