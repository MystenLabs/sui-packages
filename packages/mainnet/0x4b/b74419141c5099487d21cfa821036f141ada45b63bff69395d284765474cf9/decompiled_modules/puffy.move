module 0x4bb74419141c5099487d21cfa821036f141ada45b63bff69395d284765474cf9::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 6, b"PUFFY", b"PUFFY SUI", b"PUFFY MEME ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D9pauf_R_Cehpk2_YGR_Pkz_JPEU_Dsv_Qja_TFK_Ny_F_Dqgd4xqd_4e56e56c20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

