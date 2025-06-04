module 0x3eefa76679df4a4003772ee013b6d4271190ced429142bd243a01b90d5ff4a8d::straight {
    struct STRAIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAIGHT>(arg0, 6, b"STRAIGHT", b"Straight sui", b"Stg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihiug5on5q27ig62hdx44uucsamlg6sij63ywko65dnnmcrb2i5la")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRAIGHT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

