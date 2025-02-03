module 0xaad304e5c2f9560590ee7206702b9a6e24e0d9cc4e00c8d288baba3c2dfd3d21::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO>(arg0, 6, b"Zero", b"zerotwo", x"54686520747275652074696b746f6b206d656d650a5068616f202d2032205068757420486f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738612681052.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

