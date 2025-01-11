module 0x386ff0f6c600e57ac718ce0aace144ca1f495258b085f2f92dd5c5b5d6d4d896::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"Pepe", b"Pepe is here to make memecoins great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ptvh_QPQ_Kh8dn6m8_T47i4_CF_Qi1wgas1mh_C3_Gg7d_Wtk8_Sm_6e382f1ce1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

