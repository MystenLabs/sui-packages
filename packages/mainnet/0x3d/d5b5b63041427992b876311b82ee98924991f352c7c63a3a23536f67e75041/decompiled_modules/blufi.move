module 0x3dd5b5b63041427992b876311b82ee98924991f352c7c63a3a23536f67e75041::blufi {
    struct BLUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUFI>(arg0, 6, b"BLUFI", b"Blufi On Sui", b"$BLUFI  The Coolest Panda on the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000430_49eb3ff034.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

