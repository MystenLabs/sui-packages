module 0xc611e49700545b92d63f1a4f46dbc512afa4c5ff2579eaa3466ccc9731aeb80d::bwl {
    struct BWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWL>(arg0, 6, b"BWL", b"BrumeW", b"BrumeWallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l0_Ex2_IM_8_D8bi_C057_brume3_430b000fed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

