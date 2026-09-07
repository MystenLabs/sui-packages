module 0x745cbf8727a4b1e157ea70ce5662ae13c16fbc52ea33a6fb759703e7dd786e86::ript {
    struct RIPT has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0xe279414ae2a5926f438e036b2ee16a7d0a586899b8fc679ed13ccd5d593a56c3
    }

    fun init(arg0: RIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RIPT>(arg0, 9, 0x1::string::utf8(b"RIPT"), 0x1::string::utf8(b"RIPT"), 0x1::string::utf8(b"The platform token of ript.fi (Riptide Protocol)"), 0x1::string::utf8(b"https://ipfs.io/ipfs/bafkreie4l7iynqjxsacaw5impgohhdoop5tc4fnduwhq5yd7wfn25enxsy"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RIPT>>(0x2::coin_registry::finalize<RIPT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

