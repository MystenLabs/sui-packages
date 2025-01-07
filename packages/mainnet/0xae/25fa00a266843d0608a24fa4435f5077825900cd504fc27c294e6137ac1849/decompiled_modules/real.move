module 0xae25fa00a266843d0608a24fa4435f5077825900cd504fc27c294e6137ac1849::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 6, b"Real", b"Supercycle Real", b"The memecoin supercycle is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0560_c40c891f2f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

