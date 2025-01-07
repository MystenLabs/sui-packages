module 0x4283a3b7aef14af4451d62853447924d03d8153c875e9c0588b4d203e7f328c8::suibrella {
    struct SUIBRELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRELLA>(arg0, 6, b"SUIBRELLA", b"Sui Umbrella", b"Meet $SUIBRELLA. Built on Sui, its here to weather the ups and downs while keeping things cool. Simple, reliable, and here to stay. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_81219975b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

