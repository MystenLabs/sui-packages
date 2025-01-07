module 0x18d031d9c40ce8293dd9f2e4d8a4bc63c7d33131b80c08db25582b9f51e652c6::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut", x"616e20616e696d616c20746861742068756d616e69747920636f756c64206e6f7420736176650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975490191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

