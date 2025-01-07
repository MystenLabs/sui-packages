module 0x6c93477c1349e58818dc071d28cafd176b0c52e4f634c5bec6c105c360a3bba1::haigui {
    struct HAIGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIGUI>(arg0, 6, b"HAIGUI", b"Hai Gui Sui", b"Meet $HAIGUI - Sui's original sea turtle! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031918_49983cecc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIGUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIGUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

