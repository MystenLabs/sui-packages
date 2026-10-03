module 0xf164f63613c39ebc2a9f313049c0ef955c1c20a40b9bca7296f3d3c6378b01fd::paperhand {
    struct PAPERHAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPERHAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PAPERHAND>(arg0, 6, 0x1::string::utf8(b"PAPERHAND"), 0x1::string::utf8(b"Paper Hand Coin"), 0x1::string::utf8(x"41726520596f752050617065722068616e6420436f696e3f2042756c6c72756e20636f6d696e6720696e0a4c6574732050617065726c657373"), 0x1::string::utf8(b"https://popularsui.xyz/media/ed92cce8496b0325ec315ea24ae8c67580a1bb88bd187c1a25ceda01d8f283b7.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPERHAND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PAPERHAND>>(0x2::coin_registry::finalize<PAPERHAND>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

