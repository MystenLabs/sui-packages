module 0xf3f5ed06e6e222b70e796e7d0304dbaebe45bd3c1a943cae212203917b3c2f08::sundi {
    struct SUNDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNDI>(arg0, 6, b"SUNDI", b"Sundi on Sui", b"The fastest dog on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_23_77b3b5c9f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

