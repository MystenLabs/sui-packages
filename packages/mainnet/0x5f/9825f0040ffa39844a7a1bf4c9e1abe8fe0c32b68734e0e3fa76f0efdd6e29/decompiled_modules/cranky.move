module 0x5f9825f0040ffa39844a7a1bf4c9e1abe8fe0c32b68734e0e3fa76f0efdd6e29::cranky {
    struct CRANKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRANKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRANKY>(arg0, 6, b"CRANKY", b"Cranky on Sui", b"Hi, Im Cranky. Everything annoys me on Sui, and Im not afraid to say it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_a6cdfd0943.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRANKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRANKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

