module 0xb69484ea27ce9fd8b8f1397407944374a82becc348f6a1ee4dec5dfc7f976aae::lukas {
    struct LUKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKAS>(arg0, 6, b"LUKAS", b"LUKAS THE CROCO", b"Lukas is the manager of the entire tourist area of the Amazon rainforest. He is a millionaire and has a real estate company where he manages all his properties.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crocoluk1_3a44382224.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

