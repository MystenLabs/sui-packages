module 0x727bbdea7a360524ffabe72b64bb925a489df47046367e1719d03461f8fd959c::goblin {
    struct GOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBLIN>(arg0, 6, b"GOBLIN", b"Gold Goblins", x"476f6c6420476f626c696e7320746f6b656e206f6e205355492e200a456e7465722074686520476f6c6420476f626c696e73206572612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gghbpepe_1_paint2_e17e8c3b36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

