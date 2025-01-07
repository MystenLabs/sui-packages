module 0x3645bc3ea472d8b9fee42f4ec242e81e2382090d634db0868fd8df9a2a03e9ed::tony {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 6, b"TONY", b"Tony the Blue Cat on Sui", b"It's just a blue cat, okay for sui.. SUIMAMAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_578718547c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

