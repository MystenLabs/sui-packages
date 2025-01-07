module 0xb88a7ede5d9815692332bffd8f98040ef5c3d3f35bfbb21f6cccbf6de83c90b8::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"Pingu", b"Pingu on SUI", b"One of the only OG memes on SUI $PINGU Colony  We're too based for promo, don't even ask...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_Np6_Pv9b_400x400_8fc4f39e99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

