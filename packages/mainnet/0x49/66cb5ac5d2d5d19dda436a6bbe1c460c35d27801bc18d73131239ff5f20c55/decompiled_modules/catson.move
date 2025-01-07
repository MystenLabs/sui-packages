module 0x4966cb5ac5d2d5d19dda436a6bbe1c460c35d27801bc18d73131239ff5f20c55::catson {
    struct CATSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSON>(arg0, 6, b"CATSON", b"Sui Catson", b"Catson at work with $PEPE.. more in the next episode", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014954_e0454c6520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

