module 0xf57404e802acadcd5a0075ef2de31f184ba08e2f44a9179e80b6f58bd3371004::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CAT>(arg0, 9, 0x1::string::utf8(b"CAT"), 0x1::string::utf8(b"CAT AI"), 0x1::string::utf8(b"CAT Ai Now Live on sui chain buy and go to website mint your nft and enjoy with ur profit"), 0x1::string::utf8(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1789655452017-f39e56040d81a45d1cc40db1221d67de.jpg"), arg1);
        let v2 = v1;
        0x2::coin::mint_and_transfer<CAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CAT>>(0x2::coin_registry::finalize<CAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

