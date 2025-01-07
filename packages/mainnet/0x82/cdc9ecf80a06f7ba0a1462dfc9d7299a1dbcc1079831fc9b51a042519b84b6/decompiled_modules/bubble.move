module 0x82cdc9ecf80a06f7ba0a1462dfc9d7299a1dbcc1079831fc9b51a042519b84b6::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"Bubble", b"Water Bubble", b"just a bubble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2076_f39cc9d373.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

