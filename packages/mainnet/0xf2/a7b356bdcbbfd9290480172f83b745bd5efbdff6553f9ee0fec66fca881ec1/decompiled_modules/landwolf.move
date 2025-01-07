module 0xf2a7b356bdcbbfd9290480172f83b745bd5efbdff6553f9ee0fec66fca881ec1::landwolf {
    struct LANDWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDWOLF>(arg0, 6, b"LANDWOLF", b"KRAZY LANDWOLF", b"Krazyy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7130_cff6046749.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

