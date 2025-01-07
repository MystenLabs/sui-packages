module 0x975d01fe8fdc66237fb1ca57651fdf9c30972bc19fdf471d9212c0d3cf2f7703::emcwolf {
    struct EMCWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMCWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMCWOLF>(arg0, 6, b"EMCWOLF", b"Ethical Media Consumer Wolf", b"my original character ethical media consumer wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_043232_533_42eb40fab2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMCWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMCWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

