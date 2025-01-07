module 0x29aa63da37cdc1cfb7ec3f5534ee7f053dd0016d96aac306a69ba74017634898::cyber {
    struct CYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER>(arg0, 6, b"CYBER", b"CYBER MOVE", b"At CYBER MOVE, we are redefining digital engagement by blending gamified learning, entertainment, and tangible ownership on the SUI Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo3_7e05df8921.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

