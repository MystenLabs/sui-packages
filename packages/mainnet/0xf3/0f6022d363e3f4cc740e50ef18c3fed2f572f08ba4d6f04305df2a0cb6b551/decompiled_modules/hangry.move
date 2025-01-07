module 0xf30f6022d363e3f4cc740e50ef18c3fed2f572f08ba4d6f04305df2a0cb6b551::hangry {
    struct HANGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGRY>(arg0, 6, b"HANGRY", b"Hungry Angry Cat", x"4341543a20576865726573206d7920666f6f640a444f473a20492074686f7567687420796f7520776572656e742068756e6772792c206e6f7720796f752048414e475259", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_00_06_30_e991a1fcd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

