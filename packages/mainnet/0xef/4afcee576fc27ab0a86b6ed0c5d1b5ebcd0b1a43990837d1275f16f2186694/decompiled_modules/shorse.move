module 0xef4afcee576fc27ab0a86b6ed0c5d1b5ebcd0b1a43990837d1275f16f2186694::shorse {
    struct SHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSE>(arg0, 6, b"SHORSE", b"SharkHorse", b"A shark and a horse combined.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_b207d0e9ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

