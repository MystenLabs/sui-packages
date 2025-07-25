module 0xc678de143e23821eef78663d15a3f6358ad735105bd25b60f8a2f5ead3f89f40::arceus {
    struct ARCEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCEUS>(arg0, 6, b"Arceus", b"The Pokemon God", x"546865204f726967696e616c204f6e652c2063726561746f72206f662074686520506f6bc3a96d6f6e20756e697665727365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfbxlv5xbacxn3zxdlwiymr7lhlwdzcfjbcdiodktz5hqac7lasm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARCEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

