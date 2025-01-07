module 0x9ab79acc03068789737274a65489bf8febf179b4a1136c398169f812fa527c67::glantern {
    struct GLANTERN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLANTERN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLANTERN>(arg0, 6, b"GLANTERN", b"Green Lantern", b"green light for 100 bonding curve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bc4408f71aba61766fb4a2a71e17422e_5bf77dee70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLANTERN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLANTERN>>(v1);
    }

    // decompiled from Move bytecode v6
}

