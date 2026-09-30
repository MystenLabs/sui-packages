module 0xcebb1d2800131ff312dd6102caad2521dc97dfe3db1ea5868cd4d10ed6d0b3d8::test5 {
    struct TEST5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST5>(arg0, 9, b"test5", b"test5", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST5>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST5>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

