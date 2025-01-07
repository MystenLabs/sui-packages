module 0x890b686c8c2826d3acd954c2e57d781ca21906980a4efead4c7c25eaa7e1198d::bullsui {
    struct BULLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSUI>(arg0, 6, b"Bullsui", b"Bull on sui", b"Bull for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000903422_b17378d78b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

