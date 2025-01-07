module 0x80450fc45cb2f5ddaa7a79479d500a074b591f7383bfcb6ecb2c4148df30dacd::pgm {
    struct PGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGM>(arg0, 6, b"Pgm", b"PEPE Green Mode", b"Pepe tradng on  sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_1_Prg_Db_EA_Aa1_Km_700a165361.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

