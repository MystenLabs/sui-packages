module 0x65592eb916a0f41463376f7f6d57f6fcb3527d8168f1793853967dc0f5e08e0::suiwukomg {
    struct SUIWUKOMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWUKOMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWUKOMG>(arg0, 6, b"SUIWUKOMG", b"SUNWUKONG", x"426c61636b204d7974683a2057756b6f6e67206578636c7573697665206d656d65636f696e0a53554e57554b4f4e472e20546865206f7269656e74616c207375706572206865726f2053756e2057756b6f6e67210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_c42113379b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWUKOMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWUKOMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

