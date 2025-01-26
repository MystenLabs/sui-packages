module 0x5672785eeb23283346da2308669c1254c5a4d90ff112cf6601f51b9113d0e8f8::mons {
    struct MONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONS>(arg0, 6, b"MONS", b"Monsters Egg", b"Mons Build On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029946_7c2349f3cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

