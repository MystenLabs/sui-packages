module 0x6a290f13e3a823ccd4e62044ba767c156a606742afc99d1ca6b0cc70346c3188::sdf {
    struct SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDF>(arg0, 6, b"SDF", b"asdas", b"sdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpaouw5qcw7dfurgxdxpje6gcf4pvptguuucgcex2ky37br26w64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

