module 0x35759795ae5a0e2b14c694d1ba6e45f2cb227d8e8062219db5d9e5753ee8b758::fudia {
    struct FUDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDIA>(arg0, 6, b"FUDIA", b"Fudia The Pug", b"FUD a beautiful wife ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001518_cebfd83ffe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

