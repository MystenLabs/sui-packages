module 0xb42c02af348d6cc8613d7fd215c1a9ecc412652221e92210b7d13414bfc4fc84::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Department of Government efficiency on Sui", x"4c65742773206d616b652069742074686520666972737420746f2072756e206f6e20537569202c204a6f696e20696e20696620796f7520617265206120446f67652066616e200a0a536f6369616c7320616674657220626f6e64696e67200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002036356_30e828b87e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

