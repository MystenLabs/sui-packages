module 0x548a6d0af474b505d594482bb06f258d3eaa34f4416416e9a36a47db7b911544::yetis {
    struct YETIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETIS>(arg0, 6, b"YETIS", b"Yetis", b"Climbing to the top of Mt. Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8059_a20675f6f9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

