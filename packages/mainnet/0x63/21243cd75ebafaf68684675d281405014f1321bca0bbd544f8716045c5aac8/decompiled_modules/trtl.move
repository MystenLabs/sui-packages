module 0x6321243cd75ebafaf68684675d281405014f1321bca0bbd544f8716045c5aac8::trtl {
    struct TRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRTL>(arg0, 6, b"TRTL", b"turtleONsui", b"TRTL ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/turtle_f7fc373b16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

