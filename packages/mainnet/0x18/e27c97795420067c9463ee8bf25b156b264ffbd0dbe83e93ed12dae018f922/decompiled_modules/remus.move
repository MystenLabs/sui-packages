module 0x18e27c97795420067c9463ee8bf25b156b264ffbd0dbe83e93ed12dae018f922::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMUS>(arg0, 6, b"REMUS", b"AncientDnaClonedWold", x"546865204469726520576f6c66204973204261636b0a436f6c6f7373616c2c20612067656e657469637320737461727475702c2068617320626972746865642074687265652070757073207468617420636f6e7461696e20616e6369656e7420444e41207265747269657665642066726f6d207468652072656d61696e73206f662074686520616e696d616ce280997320657874696e637420616e636573746f72732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744063000226.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

