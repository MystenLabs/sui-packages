module 0xed003f455f75952eec7f381eead78a78c99427a43eff104abc97e2da8473b622::koak {
    struct KOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOAK>(arg0, 6, b"KOAK", b"Koak On Sui", b"Koak is a lively duck who has big dreams of sailing the seas of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020807_8fc0f54d58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

