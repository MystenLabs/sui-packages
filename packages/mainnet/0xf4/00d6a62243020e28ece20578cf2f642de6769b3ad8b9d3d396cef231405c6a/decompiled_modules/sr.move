module 0xf400d6a62243020e28ece20578cf2f642de6769b3ad8b9d3d396cef231405c6a::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SR>(arg0, 6, b"SR", b"SUI RISER ", b"THE FIRST RISER ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUI_RISER_PHOTO_de8bb051b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

