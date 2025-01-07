module 0x13ff9578a31f9fa96912fec5e6d5cefefe35757cad26669c4935e14e35fb7853::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"SuiDinoOnSui", b"SUISAURUS DINO OR SUIDINO IS CUTE FUN-LOVING, DINO ON THE SUI BLOCKCHAIN. HE DOESN'T STAY CUTE AND SMALL FOREVER THOUGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000241_db04f60ef0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

