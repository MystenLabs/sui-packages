module 0x51139d77091bbfad6e1b8da3ff48f5a293c135451db8a8833f2170aec40c0842::cooksui {
    struct COOKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKSUI>(arg0, 6, b"COOKSUI", b"COOK", b"COOKSUI SUI COOK COOKIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_1108897064_4253a6384d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

