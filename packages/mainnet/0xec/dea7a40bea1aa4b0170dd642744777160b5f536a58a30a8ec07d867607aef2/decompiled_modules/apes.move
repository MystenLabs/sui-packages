module 0xecdea7a40bea1aa4b0170dd642744777160b5f536a58a30a8ec07d867607aef2::apes {
    struct APES has drop {
        dummy_field: bool,
    }

    fun init(arg0: APES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APES>(arg0, 6, b"APES", b"APESCOIN", b"BAPC DAO, PixelApes Collections. Mixing pixelart, bored apes and exclusivity in a single area!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A74_E4_F8_F_6_E34_4348_B4_C6_C4275488_EA_18_f996e3e46d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APES>>(v1);
    }

    // decompiled from Move bytecode v6
}

