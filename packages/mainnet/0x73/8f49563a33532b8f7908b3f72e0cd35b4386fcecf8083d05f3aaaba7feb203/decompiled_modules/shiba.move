module 0x738f49563a33532b8f7908b3f72e0cd35b4386fcecf8083d05f3aaaba7feb203::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA", b"SHIBA INU", b"SHIBA INU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/ce0668f0-2cc9-439b-9f7d-43946adbe7ad.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

