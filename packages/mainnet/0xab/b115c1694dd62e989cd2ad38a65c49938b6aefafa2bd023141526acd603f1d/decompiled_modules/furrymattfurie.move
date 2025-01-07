module 0xabb115c1694dd62e989cd2ad38a65c49938b6aefafa2bd023141526acd603f1d::furrymattfurie {
    struct FURRYMATTFURIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRYMATTFURIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRYMATTFURIE>(arg0, 6, b"FURRYMATTFURIE", b"FURRY BY MATT FURIE", b"FURRY ART MINDVISCOSITY BY MATT FURIE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3654_d1230c9bda.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRYMATTFURIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRYMATTFURIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

