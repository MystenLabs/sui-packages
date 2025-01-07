module 0x60ebee2766c69cf0a539d4149bb722bf435978d7387dd7d21833e8c852828ae4::hippie {
    struct HIPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPIE>(arg0, 6, b"HIPPIE", b"Hippie Pepe Sui", b"Just a Hippie dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippiepepeprof_2c464d6fcb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

