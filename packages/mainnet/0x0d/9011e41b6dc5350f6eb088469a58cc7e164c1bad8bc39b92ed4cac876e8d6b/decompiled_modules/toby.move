module 0xd9011e41b6dc5350f6eb088469a58cc7e164c1bad8bc39b92ed4cac876e8d6b::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBY>(arg0, 6, b"TOBY", b"toby frog", b"Chiling in sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOBY_fddb86e9d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

