module 0xf5c480ac120b12913991a58f68964d6109ad5d280a759fdf9562179186863f89::kebe {
    struct KEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEBE>(arg0, 6, b"KEBE", b"Sui Kebe", b"Lost in a dream... $kebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055011_e8ffd3a9fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

