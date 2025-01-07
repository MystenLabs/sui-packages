module 0xc2e08f5a1e24aeef37bc0e5c5541073bb4d44a443ecde05350ad7620abcd1bb6::gtsui {
    struct GTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTSUI>(arg0, 6, b"GTSUI", b"great sui", b"let us make sui great", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WET_TRH_Ej_Y_Gba_RXX_1ttkro_3ac1a2478f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

