module 0x76638302f7a3d3a06afa6528b45fb5178856e1955a8c9bf0bad4b864c85d8cc0::jasper {
    struct JASPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASPER>(arg0, 6, b"JASPER", b"Against All Odds", b"Jasper, a rare foal, was born at Chester Zoo against all odds. With his species on the edge of extinction, he symbolizes a beacon of hope and resilience for his breed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_022338_428_a1ab04c057.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JASPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

