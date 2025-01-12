module 0x1f0891fd05229c9171be6270054046af373fdbd7a0881a52429945036408853::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 6, b"ffff", x"64c491", b"ddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d9791aa1-3cc3-4d80-8ebc-119e43a97b96.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

