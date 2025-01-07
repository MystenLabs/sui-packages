module 0x42f29931b41c0edc600bee7a465203a37c0e8e7b8c12b34010f94e17d5d47b26::ivfun {
    struct IVFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVFUN>(arg0, 6, b"IVfun", b"Invest Zone", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Vfun_TYE_2h_X_1r_R7_Q8_Gfw_F_Ka_1d947d661d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IVFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

