module 0x80402cab17779617b26dd50b7c7200c1aa76edf9296d77f11750c6bd81fc61b4::spqr {
    struct SPQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPQR>(arg0, 6, b"SPQR", b"SPQR On Sui", b"Elon Musk's  twitter  today says : SPQR  coming on sui ,we are next big meme coin on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spqr_a6d0b1d51f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

