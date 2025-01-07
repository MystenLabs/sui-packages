module 0x62a5b6645b60316153baab78a245219577664139330a99cc4d0e266945dc5bcb::jokr {
    struct JOKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKR>(arg0, 6, b"JOKR", b"Jokr SUI", b"They laugh at me for trading memecoins, but the joke's on them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_79840ba8bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

