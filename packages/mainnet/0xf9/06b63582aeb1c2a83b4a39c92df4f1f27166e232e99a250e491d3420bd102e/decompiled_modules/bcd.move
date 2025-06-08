module 0xf906b63582aeb1c2a83b4a39c92df4f1f27166e232e99a250e491d3420bd102e::bcd {
    struct BCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCD>(arg0, 9, b"BCD", b"BACOD", b"bacod lu njing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9fce639467f76fb9f698a82c6a030814blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

