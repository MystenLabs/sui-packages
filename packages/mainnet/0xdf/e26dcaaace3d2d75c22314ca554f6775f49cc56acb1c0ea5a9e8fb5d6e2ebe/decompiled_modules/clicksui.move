module 0xdfe26dcaaace3d2d75c22314ca554f6775f49cc56acb1c0ea5a9e8fb5d6e2ebe::clicksui {
    struct CLICKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLICKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLICKSUI>(arg0, 6, b"CLICKSUI", b"SUI CURSOR", b"ONE CLICK SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_016d4010db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLICKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLICKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

