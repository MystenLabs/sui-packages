module 0x4e3964376b15ef62794ea308388f3959d592b6a49a97c29a6f09bdf602123a90::msfuku {
    struct MSFUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSFUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSFUKU>(arg0, 6, b"MSFUKU", b"MSUI FUKU", b"The beloved wife of Fuku who share his joy and sorrow, from sickness to heath, from poor to riches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_01_25_55_bb13518335.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSFUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSFUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

