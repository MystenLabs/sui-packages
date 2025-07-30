module 0x375ef7fd419749b2e6a212de007b0d1f1f494a28ee66ceeb756da6023fd05288::imdrop {
    struct IMDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMDROP>(arg0, 6, b"IMDROP", b"IKA MDROP", b"IKA MDROP IS ABOUT TO BLOW OUT, MORE INFO DROPPING ON X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmfxarf3iszomctk6opfaf2cxlyphclcjo3mtbojqovmk2vdnmiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMDROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

