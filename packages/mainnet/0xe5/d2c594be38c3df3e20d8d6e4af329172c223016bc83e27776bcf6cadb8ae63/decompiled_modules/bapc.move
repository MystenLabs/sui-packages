module 0xe5d2c594be38c3df3e20d8d6e4af329172c223016bc83e27776bcf6cadb8ae63::bapc {
    struct BAPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPC>(arg0, 6, b"BAPC", b"ApePixelsSui", b"MEMECOIN of PixelApes Collections. Mixing pixelart, bored apes and exclusivity in a single area!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A74_E4_F8_F_6_E34_4348_B4_C6_C4275488_EA_18_35658604c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

