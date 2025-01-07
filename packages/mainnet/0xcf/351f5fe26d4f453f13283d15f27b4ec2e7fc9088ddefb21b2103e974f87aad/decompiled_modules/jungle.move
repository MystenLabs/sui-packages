module 0xcf351f5fe26d4f453f13283d15f27b4ec2e7fc9088ddefb21b2103e974f87aad::jungle {
    struct JUNGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNGLE>(arg0, 6, b"JUNGLE", b"JUNGLEdoge", b"FEATHERS STAY ON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jungle_697fe3a859.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

