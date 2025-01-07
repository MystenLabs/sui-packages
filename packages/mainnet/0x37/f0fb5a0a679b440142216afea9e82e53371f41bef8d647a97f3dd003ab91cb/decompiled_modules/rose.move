module 0x37f0fb5a0a679b440142216afea9e82e53371f41bef8d647a97f3dd003ab91cb::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 6, b"ROSE", b"First Rose Sui", b"First Rose on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_10_43341e4710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

