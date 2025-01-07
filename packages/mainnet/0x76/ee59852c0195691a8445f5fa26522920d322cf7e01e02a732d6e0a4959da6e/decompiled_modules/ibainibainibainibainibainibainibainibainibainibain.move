module 0x76ee59852c0195691a8445f5fa26522920d322cf7e01e02a732d6e0a4959da6e::ibainibainibainibainibainibainibainibainibainibain {
    struct IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN>(arg0, 6, b"IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN", b"Inu IBAINIBAINIBAINIBAINIBAINIBAIN", b"alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla alalalallalala alla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6GV0A2AGAFB6JPVDCVHSKD/01JB90DGAA592VRXVPK34TY87K")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAINIBAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

