module 0x52b5f82e0a33a39392d151dccbd674d890395eb6d9d6aa4a1ac210011e524722::abesui {
    struct ABESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABESUI>(arg0, 6, b"ABESUI", b"ABE ON SUI", b"FIRST ABE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cyw_Z_Nod_S_Xt_Y59b_Kli_M9_K3n6hs_85c68aa586.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

