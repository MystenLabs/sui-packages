module 0x1be078e05704465329ae6f59d064638f128d553d8a2d99533be102aafad5a52b::crock {
    struct CROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCK>(arg0, 6, b"CROCK", b"Sui Witc Crock", b"Mulitalent blue duck CROCK that will rock the basics, its trendy look will catch all eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000093234_bf957f0485.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

