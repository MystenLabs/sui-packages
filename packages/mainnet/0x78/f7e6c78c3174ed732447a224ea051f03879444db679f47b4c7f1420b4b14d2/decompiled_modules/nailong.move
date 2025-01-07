module 0x78f7e6c78c3174ed732447a224ea051f03879444db679f47b4c7f1420b4b14d2::nailong {
    struct NAILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAILONG>(arg0, 6, b"NAILONG", b"Nailong", b"Nailong, a youthful dinosaur originating from a distant alien realm, brings a unique perspective to Earth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000117099_344834a208.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAILONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAILONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

