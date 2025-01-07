module 0x370a7797c56027f47301671c89266242fa6baa53cabd134475243fd9e86a881b::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 6, b"SUP", b"SUIPREME", b"Supreme is a pioneer in streetwear, blending skate culture with high fashion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3352_68c0d2e4aa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

