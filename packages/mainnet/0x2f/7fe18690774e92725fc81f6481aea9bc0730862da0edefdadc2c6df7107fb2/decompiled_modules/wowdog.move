module 0x2f7fe18690774e92725fc81f6481aea9bc0730862da0edefdadc2c6df7107fb2::wowdog {
    struct WOWDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWDOG>(arg0, 6, b"WOWDOG", b"WOWDOG ON SUI", b"WOWDOG on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOWDOG_969b78b119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

