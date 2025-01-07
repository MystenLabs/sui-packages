module 0xacadaa7eaaceaf02f13e3d86c6b005ca5b7dc2b260a49cb5ca7fbcbd0af63bbf::suiiiii {
    struct SUIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIII>(arg0, 6, b"SUIIIII", b"SUIIIIII!", b"BETTER THEN MESSI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiiiii_cad7877477.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

