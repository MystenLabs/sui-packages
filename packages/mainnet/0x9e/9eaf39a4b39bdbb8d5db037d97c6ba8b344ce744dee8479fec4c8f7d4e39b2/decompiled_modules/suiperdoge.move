module 0x9e9eaf39a4b39bdbb8d5db037d97c6ba8b344ce744dee8479fec4c8f7d4e39b2::suiperdoge {
    struct SUIPERDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERDOGE>(arg0, 6, b"SUIPERDOGE", b"SUIPERDOGE", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ISF8TOC.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPERDOGE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

