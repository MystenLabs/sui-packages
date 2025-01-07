module 0xa18a8d6c4d5e3ec1711800a977334392399207dfddb3ac344b2709e67fd686e5::fuckfuckfuckfuckfuckfuckfuckfuckfuck {
    struct FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK>(arg0, 6, b"Fuckfuckfuckfuckfuckfuckfuckfuckfuck", b"FUUUUUUUCCCCKKK", b"fuckfuckfuckfuckfuckfuckfuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/regrgrtgrgrgrgrg_02caa75a02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCKFUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

