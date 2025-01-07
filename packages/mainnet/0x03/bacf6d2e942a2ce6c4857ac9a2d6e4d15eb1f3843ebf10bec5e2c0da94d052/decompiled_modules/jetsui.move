module 0x3bacf6d2e942a2ce6c4857ac9a2d6e4d15eb1f3843ebf10bec5e2c0da94d052::jetsui {
    struct JETSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETSUI>(arg0, 6, b"Jetsui", b"Jet Sui", x"5370656564207468726f75676820537569207769746820244a4554535549210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jetsui_08e005c7ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JETSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

