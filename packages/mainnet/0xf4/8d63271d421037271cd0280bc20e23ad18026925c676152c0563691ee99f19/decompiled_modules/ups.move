module 0xf48d63271d421037271cd0280bc20e23ad18026925c676152c0563691ee99f19::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UPS>(arg0, 6, b"UPS", b"UPS", b"@suilaunchcoin $UPS + UPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

