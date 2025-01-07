module 0x832dc849e16ac5b3c1a30c22486dcc98b44942a9d5c24dccf15a35b8f0d8471c::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 6, b"PIGU", b"PIGU WORLD ON SUI OF COURSE", b"PIGU (FA&). He's Clumsy, Cheeky & Cruising through Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0546_b86bba867b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

