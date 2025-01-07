module 0xdcb72ab4f74357cdb5204921dfa3a893d868d936a6ae5f22acb62025569c8a57::nuhg {
    struct NUHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUHG>(arg0, 6, b"NUHG", b"Nuhg Sui", b"$NUHG meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_105530_deaa41c34f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

