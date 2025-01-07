module 0x6fa87a89b7b797ce8063f04e2ae40a10f59bd73894516b00092bdcf27f063c3c::coki {
    struct COKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKI>(arg0, 6, b"COKI", b"SuiCoki", b"My name is Coki and shrimps like me are used to aristocratic treatment only, so you better bring me something nice. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_16_T200016_949_7d6ec949b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

