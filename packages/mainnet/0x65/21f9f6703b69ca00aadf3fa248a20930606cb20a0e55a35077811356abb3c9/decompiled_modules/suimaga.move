module 0x6521f9f6703b69ca00aadf3fa248a20930606cb20a0e55a35077811356abb3c9::suimaga {
    struct SUIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAGA>(arg0, 6, b"SUIMAGA", b"SUI MAGA", b"LET'S ALL GO TO THE MOON TOGETHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_16_23_29_55_91823e7065.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

