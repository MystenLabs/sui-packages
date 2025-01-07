module 0x41d3988670f09f63125a471811a87a3ece1c9e6ae1c53c255d3b200e74ba84b8::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"Mood", b"Moodeng", b"Moodeng on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24_10_06_23_37_36_347_deco_309057be35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

