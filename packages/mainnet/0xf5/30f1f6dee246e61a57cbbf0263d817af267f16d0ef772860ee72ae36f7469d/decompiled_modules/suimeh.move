module 0xf530f1f6dee246e61a57cbbf0263d817af267f16d0ef772860ee72ae36f7469d::suimeh {
    struct SUIMEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEH>(arg0, 6, b"SUIMEH", b"SUI MEH", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731243989713.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

