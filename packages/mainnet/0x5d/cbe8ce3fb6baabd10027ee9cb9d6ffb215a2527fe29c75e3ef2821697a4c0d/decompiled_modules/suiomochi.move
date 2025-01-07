module 0x5dcbe8ce3fb6baabd10027ee9cb9d6ffb215a2527fe29c75e3ef2821697a4c0d::suiomochi {
    struct SUIOMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOMOCHI>(arg0, 6, b"SUIOMOCHI", b"OMOCHI", b"Its a cute froggo and me likey! $OMOCHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Yd8sb_Ws_AAP_2_SI_50019476f0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

