module 0x95a016f408089a5b17b37dfe4ad91f54d4322a4fe3a3acaef7074f37a01eb362::seho {
    struct SEHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEHO>(arg0, 6, b"SEHO", b"SEHO on SUI", b"The quirky hippocampus on Sui Blockchain...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tt_Z_Wr_Jzh_400x400_67528792e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

