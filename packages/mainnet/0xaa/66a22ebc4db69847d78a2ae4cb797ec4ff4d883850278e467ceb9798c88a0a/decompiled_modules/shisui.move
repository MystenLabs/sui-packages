module 0xaa66a22ebc4db69847d78a2ae4cb797ec4ff4d883850278e467ceb9798c88a0a::shisui {
    struct SHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHISUI>(arg0, 6, b"SHISUI", b"SHISUI UCHIHA", b"ITACHIS BEST FRIEND ON SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHISUI_24eea6d7cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

