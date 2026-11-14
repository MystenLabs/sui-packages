module 0x426ec35ee15111c4acc23eee58b38e8d9dc1fa78665cba7a5eff1459379fba06::suiv {
    struct SUIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIV>(arg0, 6, 0x1::string::utf8(b"SUIV"), 0x1::string::utf8(b"SUIVIAL"), 0x1::string::utf8(x"426f726e20696e206368616f732e204275696c7420746f20737572766976652e0a0a466f722074686f73652077686f207374616e64207374726f6e67207468726f756768206576657279206d61726b65742073746f726d2e20f09f94b5"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/TaZAq675lkCeDp1ooMtkdMD2svFl9eLM_3tzcKCVJ6EBAQBlAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIV>>(0x2::coin_registry::finalize<SUIV>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

