module 0x11a1ad98061bda306d96d805143a1e0cb7134ceea027d5892bc95a3beab32eb0::tan {
    struct TAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAN>(arg0, 6, b"TAN", b"TANCREDI", b"A knight in shining memes, charging straight into your portfolio with legendary gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_022601291_e0fdbfd310.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

