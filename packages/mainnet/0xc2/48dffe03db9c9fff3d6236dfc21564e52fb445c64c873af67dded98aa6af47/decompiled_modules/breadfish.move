module 0xc248dffe03db9c9fff3d6236dfc21564e52fb445c64c873af67dded98aa6af47::breadfish {
    struct BREADFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADFISH>(arg0, 6, b"BREADFISH", b"Bread Fish", b"Have You Seen the Marvelous Breadfish?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_6b49947dfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

