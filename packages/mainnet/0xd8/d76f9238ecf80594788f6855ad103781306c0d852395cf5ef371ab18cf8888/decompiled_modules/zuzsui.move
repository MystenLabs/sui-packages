module 0xd8d76f9238ecf80594788f6855ad103781306c0d852395cf5ef371ab18cf8888::zuzsui {
    struct ZUZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUZSUI>(arg0, 6, b"ZUZSUI", b"ZUZ", b"\"Invest in **ZUZ**, the next-generation cryptocurrency that combines technological innovation with enhanced security, offering you solid returns and exclusive access to the economy of tomorrow. Dont miss the opportunity to be part of the financial revolution with ZUZ!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F227297_C_C35_F_4_BDB_A1_F1_7_C6_A3_AE_461_BB_e42b9d2b4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

