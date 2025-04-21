module 0xbb88331bdd0dca0415551962427cbb27db38b6c67ea1b2586ad6a8bb064e286b::YO {
    struct YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YO>(arg0, 6, b"YO", b"friggin packet yo", x"696620796f7520776f756c64206a7573742067657420757020616e64207465616368207468656d20696e7374656164206f662068616e64696e67207468656d206120667265616b696e67207061636b65742c20796f2e207468657265e2809973206b696420696e2068657265207468617420646f6ee2809974206c6561726e206c696b6520746861742e2074686579206e65656420746f206c6561726e206661636520746f20666163652e20796f75e280997265206a7573742067657474696e67206d616420626563617573652069e280996d20706f696e74696e67206f757420746865206f6276696f75732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmcDcAfWSK1ESCY79oC3Q4h9ByKSTQtPA9yrVcTUrdtWvh")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

