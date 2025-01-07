module 0x821e68c476c0419f31614eb17e41094bacc1b3a381be52e17f7d036b08822e4c::redy {
    struct REDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDY>(arg0, 6, b"REDY", b"RedyOnSui", b"Redy Official - Your sweet gateway to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001068_b0c963a6a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

