module 0x708fefb86a19133e71478b14f7593bd093115abfce3b0b040d0b7a7f23a4b9f::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"doug", b"international parcel service", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doug2_24311e6c9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

