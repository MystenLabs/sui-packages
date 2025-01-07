module 0xf696a0c20b877d207b073752f68f3043906fba1965dcfa68ec71922cde427ef::siuu {
    struct SIUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUU>(arg0, 6, b"SIUU", b"SIUU on SUI", x"53495555206f6e20535549202d20636f6d6d756e6974792d64726976656e20746f6b656e2064656469636174656420474f41542c204352372e20506f77657265642062792066616e732c20666f722066616e732e20204a6f696e20746865206d6f76656d656e74206f6e20535549210a537570706c7920636f6e74726f6c6564206279205465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giffer_6e404da0c4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

