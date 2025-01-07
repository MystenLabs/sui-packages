module 0xd43b62947cd0c5cdc2130b907991f234fe83777c2277d73978d9bf1459ae96fe::aaasatshi {
    struct AAASATSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASATSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASATSHI>(arg0, 6, b"AAASATSHI", b"aaa satshi", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Satshi_NNNNNNN_839bdf1880.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASATSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASATSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

