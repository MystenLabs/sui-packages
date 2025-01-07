module 0x7324d5b78d98617250daa5fa9bdb4f9ccb01eded1c7c18dba9fa3b2d96f525e9::drop {
    struct DROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROP>(arg0, 6, b"DROP", b"Drop", x"f09f92a72069732074686520666972737420656d6f6a69204149206167656e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735649565944.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

