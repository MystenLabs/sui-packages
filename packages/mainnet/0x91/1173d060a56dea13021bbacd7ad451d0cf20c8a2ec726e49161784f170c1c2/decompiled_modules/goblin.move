module 0x911173d060a56dea13021bbacd7ad451d0cf20c8a2ec726e49161784f170c1c2::goblin {
    struct GOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBLIN>(arg0, 6, b"GOBLIN", b"Goblin on Sui", b"$GOBLIN  The Christmas Goblin on SUI  We're here to break the rules and shake up the memecoin community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul25_20241219151053_8f0508f89f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

