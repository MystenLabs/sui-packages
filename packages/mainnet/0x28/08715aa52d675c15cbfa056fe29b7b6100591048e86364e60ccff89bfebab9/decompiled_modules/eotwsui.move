module 0x2808715aa52d675c15cbfa056fe29b7b6100591048e86364e60ccff89bfebab9::eotwsui {
    struct EOTWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOTWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOTWSUI>(arg0, 6, b"EOTWSUI", b"EOFTW SUI", b"Is this the end of SUI Chain?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_25_at_8_44_54a_PM_a0435738f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOTWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOTWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

