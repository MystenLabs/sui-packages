module 0x94d68bf2bee6a26e811ceabbe92ce4f17271b67cb2845eed0d8f64140b98eeb0::lulol {
    struct LULOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULOL>(arg0, 6, b"Lulol", b"qsdz", b"sqd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiton_f26bd00808.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LULOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

