module 0x4f639be7f03d11360716a496236a7502c46063f446de9f70aa6fbea7ff0811a8::chisui {
    struct CHISUI has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0xd17d2f448d4e4d633f38b5866672c7bc98b992b2c728b3ed5b2edc04e8505fb3
    }

    fun init(arg0: CHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHISUI>(arg0, 9, 0x1::string::utf8(b"CHISUI"), 0x1::string::utf8(b"chisui club"), 0x1::string::utf8(b"the coolest club on sui. "), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreih3tsbok4gem7v5qqkkj56uygzf6vjnuchvsrde2yt4ixay6oo4oy"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHISUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHISUI>>(0x2::coin_registry::finalize<CHISUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

