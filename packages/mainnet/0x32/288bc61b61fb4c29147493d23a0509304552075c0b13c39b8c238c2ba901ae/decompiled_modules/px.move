module 0x32288bc61b61fb4c29147493d23a0509304552075c0b13c39b8c238c2ba901ae::px {
    struct PX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PX>(arg0, 6, b"PX", b"PX2000", b"Future ai citizen of SUI city.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_28_21_04_10_df7be76777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

