module 0x1a6eed839f36b84457b0f76c2aac18284f3145afffb956d8f4af255451b5efa0::morg {
    struct MORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORG>(arg0, 6, b"MORG", b"MORG DOG ON SUI", b"If you like Dogs then you'll fall in love with $MORG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Pz_OZ_3q_WIA_Eo_J_Xx_358bf3903c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

