module 0x4d337473b4f56ab3cf0759ba9710cdec0291b703c3fb6f60a60b976f2cb1da42::russellsui {
    struct RUSSELLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELLSUI>(arg0, 6, b"RUSSELLSUI", b"RUSSELL ON SUI", b"The dogs name is Russell the wife of Brian Armstrongs NewLink cofounder Blake Byers spilled it in a wedding congratulations reply (since deleted) note that Russell is in the photo she is replying to.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4dc_Y02_Pr_400x400_1_d5eb8ead18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

