module 0xa44027d04511e5020cb8dac91ac8b2e51fc6462b97828eb3c5b46d8edb1b5c77::gigguh {
    struct GIGGUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGGUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGGUH>(arg0, 6, b"GIGGUH", b"$Gigguh Chad", x"24242447696767756820436861642028474947475548290a576861742773206775636369206d7920676967677568", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Xxc_D_Jg_Qq_Fu_S23xyo_Rjc_A_Kkd_AF_7_JB_9_GX_8_K4_Zx61_Ge5ht_a76cbc227d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGGUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGGUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

