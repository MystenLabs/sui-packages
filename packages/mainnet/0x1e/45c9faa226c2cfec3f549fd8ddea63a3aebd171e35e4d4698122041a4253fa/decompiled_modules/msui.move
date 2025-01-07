module 0x1e45c9faa226c2cfec3f549fd8ddea63a3aebd171e35e4d4698122041a4253fa::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 6, b"MSUI", b"Mrsui", b"KING OF THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000558065_80983e5285.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

