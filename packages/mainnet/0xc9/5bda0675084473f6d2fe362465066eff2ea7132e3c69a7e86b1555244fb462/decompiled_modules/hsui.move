module 0xc95bda0675084473f6d2fe362465066eff2ea7132e3c69a7e86b1555244fb462::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 6, b"HSUI", b"Suicune", b"The Legendary Beast of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J8_s_G_Zl5_400x400_27a9c2de7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

