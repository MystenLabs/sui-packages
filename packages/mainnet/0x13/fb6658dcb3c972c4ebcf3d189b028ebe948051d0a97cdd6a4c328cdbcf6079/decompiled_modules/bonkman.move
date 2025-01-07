module 0x13fb6658dcb3c972c4ebcf3d189b028ebe948051d0a97cdd6a4c328cdbcf6079::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"BONKMAN", b"BONKMANSUI", b"Hello, I am Bonkman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018274_19ed8c6b94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

