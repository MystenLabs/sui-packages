module 0xdf68001a33c31e650c37f0510eb6ce00da1123bf89e6ae7472217d4325c653a::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"King Fizh", x"322c313030204e46547320636f6e7175697374616e646f20537569204b696e67646f6d210a0a4361646120736572207669656e65207669766f20656e2065737465206d756e646f207075656465207365722074616e206772616e646520636f6d6f2073757320737565c3b16f73206c6f73207365612c20656c20737565c3b16f206465204b696e672046697a6820657320726570726573656e746172206120746f64612073752065737065636965207920706172612065736f207365206465626520636f6e766572746972736520656e20756e20244b494e47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidfimt4c2h5p6o7jvu7klpixm2t33i2q3cofzaduk3ozheoprqfpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

