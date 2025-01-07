module 0x1531a28533cd5c251b60535858fa99d14d3d0bab44a1bc7ada7c91a975a9b42d::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 6, b"REAL", b"Suirealntate", b"GTA AND MORE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/join_fe082f0928.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

