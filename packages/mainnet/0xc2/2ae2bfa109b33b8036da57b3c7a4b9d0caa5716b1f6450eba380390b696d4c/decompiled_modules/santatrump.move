module 0xc22ae2bfa109b33b8036da57b3c7a4b9d0caa5716b1f6450eba380390b696d4c::santatrump {
    struct SANTATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTATRUMP>(arg0, 6, b"SANTATRUMP", b"Make Christmas Great Again", b"MAKE CHRISTMAS GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_12_04_00_02_37_02faacb1d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

