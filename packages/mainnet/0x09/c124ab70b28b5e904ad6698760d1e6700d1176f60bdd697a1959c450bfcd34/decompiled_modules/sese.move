module 0x9c124ab70b28b5e904ad6698760d1e6700d1176f60bdd697a1959c450bfcd34::sese {
    struct SESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESE>(arg0, 6, b"SESE", b"SESE SUI", b"The frog whos just vibin' through a candy-colored dreamland, leaping where the fun never stops!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_blue_87e10b84a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

