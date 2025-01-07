module 0xce230fab86e5a0e78368ae2fc7d8f557af9e043bc5f8a84f58690bb850292d02::fishstick {
    struct FISHSTICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHSTICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSTICK>(arg0, 6, b"FISHSTICK", b"Fishstick", b"Fishstick is a Rare Outfit in Fortnite, that can be purchased in the Item Shop for 1200 V-Bucks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_38_c83ff79a71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSTICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHSTICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

