module 0xf87a3b3668c5dca82de3b3797f6f03e3f5b7f2f95714c98dfb7abf3c48ccda2f::wild {
    struct WILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD>(arg0, 6, b"WILD", b"Wild Guyz", b"Young, wild and free!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wg_cc5e05c698.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

