module 0x54eb50ea42830066595f2641484426a3a406c1895de161bdbb80f671bba63372::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"Chicken Fried", b"YOU LIKE FAST FOOD?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg_N0k9a_AA_Ec_Dw2_d084d8eee1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

