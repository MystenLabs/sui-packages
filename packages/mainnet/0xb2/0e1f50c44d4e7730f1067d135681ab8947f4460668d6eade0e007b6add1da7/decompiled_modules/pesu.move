module 0xb20e1f50c44d4e7730f1067d135681ab8947f4460668d6eade0e007b6add1da7::pesu {
    struct PESU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESU>(arg0, 6, b"PESU", b"Pepe", b"Make Pepe Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/98jzq_YD_400x400_b3f31c62c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESU>>(v1);
    }

    // decompiled from Move bytecode v6
}

