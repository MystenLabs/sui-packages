module 0x810babcc2ea243998549abef479f8b7664f3d7e977b0be3c2d8d9ab003aa2c48::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"Sui Oink", x"f09f90bdf09fa4bf20244f494e4b20697320746865206d6f737420616476656e7475726f7573207069672c2073637562612d646976696e6720696e746f20535549204f6365616e20f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731028922463.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

