module 0x489e86ca39a09054d45bbb990f2b18ce94a32d1280ee8f30552e30920b37f3e4::suikea {
    struct SUIKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEA>(arg0, 6, b"SUIKEA", b"Suikea", b"Welcome To Real Suikea Store.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikea_0b06fc0b3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

