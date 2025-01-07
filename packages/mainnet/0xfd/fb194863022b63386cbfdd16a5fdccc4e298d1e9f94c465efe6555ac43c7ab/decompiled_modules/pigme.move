module 0xfdfb194863022b63386cbfdd16a5fdccc4e298d1e9f94c465efe6555ac43c7ab::pigme {
    struct PIGME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGME>(arg0, 6, b"PIGME", b"Pig On Sui", b"Pig Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipig_3e5b8e109d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGME>>(v1);
    }

    // decompiled from Move bytecode v6
}

