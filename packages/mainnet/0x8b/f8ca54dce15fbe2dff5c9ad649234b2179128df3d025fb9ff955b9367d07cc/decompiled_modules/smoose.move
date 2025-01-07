module 0x8bf8ca54dce15fbe2dff5c9ad649234b2179128df3d025fb9ff955b9367d07cc::smoose {
    struct SMOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOOSE>(arg0, 6, b"SMOOSE", b"SEA MOOSE", b"Moon and chill, make daddy rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/camel_toe_grande_a715352e1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

