module 0x2fbed1da424da88f0bd56fab2d1a29a67c06bc1dc72c86428b40a1e5ce312941::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 6, b"SHOCK", b"Aqua Shock", b"The waters are rising. We are watching always. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4577_6fb37eca71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

