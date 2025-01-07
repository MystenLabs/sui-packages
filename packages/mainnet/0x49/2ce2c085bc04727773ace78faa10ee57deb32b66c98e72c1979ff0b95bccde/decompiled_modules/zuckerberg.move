module 0x492ce2c085bc04727773ace78faa10ee57deb32b66c98e72c1979ff0b95bccde::zuckerberg {
    struct ZUCKERBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCKERBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCKERBERG>(arg0, 6, b"ZUCKERBERG", b"UFC", b"Zuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GPUGNGEEJZGIBH_2_XZISENLBOUY_8386f726d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCKERBERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCKERBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

