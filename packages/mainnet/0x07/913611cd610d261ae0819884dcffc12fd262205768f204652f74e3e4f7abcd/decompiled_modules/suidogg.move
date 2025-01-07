module 0x7913611cd610d261ae0819884dcffc12fd262205768f204652f74e3e4f7abcd::suidogg {
    struct SUIDOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGG>(arg0, 6, b"SuiDogg", b"Sui Dogg", b"Ladi dadi! It's time to party! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020958_fb8521671c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

