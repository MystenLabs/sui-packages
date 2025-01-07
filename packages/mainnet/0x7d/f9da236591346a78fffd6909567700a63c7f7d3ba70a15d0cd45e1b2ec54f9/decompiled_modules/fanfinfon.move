module 0x7df9da236591346a78fffd6909567700a63c7f7d3ba70a15d0cd45e1b2ec54f9::fanfinfon {
    struct FANFINFON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANFINFON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANFINFON>(arg0, 6, b"FanFinFon", b"The Musta", b"Mustaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4583922_D91_D_425_C_8_BFD_5068521_BB_5_AE_77c6828622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANFINFON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FANFINFON>>(v1);
    }

    // decompiled from Move bytecode v6
}

