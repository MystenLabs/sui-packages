module 0xcf6a43d2767b469b2a0f6f89334f78bd46d6a14bc92c60086a6148bc1c086676::den {
    struct DEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEN>(arg0, 6, b"DEN", b"den", b"this is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/space_bg8574_e059d39051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

