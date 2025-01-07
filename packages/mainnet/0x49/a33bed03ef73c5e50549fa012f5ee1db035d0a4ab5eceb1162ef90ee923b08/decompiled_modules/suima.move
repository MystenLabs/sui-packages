module 0x49a33bed03ef73c5e50549fa012f5ee1db035d0a4ab5eceb1162ef90ee923b08::suima {
    struct SUIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMA>(arg0, 6, b"SUIMA", b"Saitama On Sui", b"The one punch man on Sui - $SUIMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_36_03_1f7bce0bc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

