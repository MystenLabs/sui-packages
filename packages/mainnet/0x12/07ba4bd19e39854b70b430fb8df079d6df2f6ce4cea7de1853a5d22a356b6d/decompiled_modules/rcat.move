module 0x1207ba4bd19e39854b70b430fb8df079d6df2f6ce4cea7de1853a5d22a356b6d::rcat {
    struct RCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCAT>(arg0, 6, b"Rcat", b"sui Repost Cat", b"lets Repost ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_15_08_53_2_b4cdeba3c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

