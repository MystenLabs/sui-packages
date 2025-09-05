module 0xb3d81fa9128b445b56e791e5ef013d0e1ed5ad49dbd6222d9d840052dff19db7::skitten {
    struct SKITTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SKITTEN>(arg0, b"Skitten", b"SuiCat", b"splash cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfZ5Fti5GTYJ88jfmnAA54vz515ez8Rq1ZfKaHrRzDmp8")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003db2b8325d56373c192ccea15133496d6c6003b71be5b202ee244fe7ef4923ec7cb6154e66ec8767c12fd27ed679fd9d0cc42c075e0380a5e6fe7f82639bdb08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757050319"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

