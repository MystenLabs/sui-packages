module 0xf8478260e42849ea348e1b1546c5fb2208c3a0ca0c90db4de11dc7c1d8c2f178::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UPS>(arg0, 6, b"UPS", b"UPS", b"@suilaunchcoin $UPS + UPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ups-dppuu0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

