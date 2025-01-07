module 0x92bcce24bf4996508606f5939e40a19f7aff50c0d889696705e5489df9033c1::suiomochi {
    struct SUIOMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOMOCHI>(arg0, 6, b"Suiomochi", b"OMOCHI", b"Its a cute froggo and me likey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Yd8sb_Ws_AAP_2_SI_50019476f0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOMOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOMOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

