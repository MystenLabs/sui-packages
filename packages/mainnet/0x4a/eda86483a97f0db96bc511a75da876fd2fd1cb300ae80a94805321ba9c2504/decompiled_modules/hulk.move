module 0x4aeda86483a97f0db96bc511a75da876fd2fd1cb300ae80a94805321ba9c2504::hulk {
    struct HULK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HULK>(arg0, 6, b"HULK", b"Hulk on Sui", b"Smashing through the Sui Network with pure strength, $HULK is here to make an impact. Big, green, and unstoppable. Dont stand in its way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_78_702b7de7f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HULK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HULK>>(v1);
    }

    // decompiled from Move bytecode v6
}

