module 0x8758cf872bafed0287c0114a865931567d97bbb6c5130d65b31edb9341f62cc3::fofo {
    struct FOFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFO>(arg0, 6, b"FOFO", b"DOGS ONE DOLLAR CUTE", b"DOGS A CUTE DOLLAR A AU AU NEEDS AFFECTION DEPOSIT YOUR LOVE IN DOLLARS AND WATCH IT GROW STRONG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000240874_ee26db8be0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

