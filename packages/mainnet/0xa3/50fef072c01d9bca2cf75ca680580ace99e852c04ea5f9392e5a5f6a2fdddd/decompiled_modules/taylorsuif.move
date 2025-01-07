module 0xa350fef072c01d9bca2cf75ca680580ace99e852c04ea5f9392e5a5f6a2fdddd::taylorsuif {
    struct TAYLORSUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAYLORSUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAYLORSUIF>(arg0, 6, b"TaylorSuif", b"TAYLOR SUIF", b"The First SUIFTIES on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3885_150254e302.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAYLORSUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAYLORSUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

