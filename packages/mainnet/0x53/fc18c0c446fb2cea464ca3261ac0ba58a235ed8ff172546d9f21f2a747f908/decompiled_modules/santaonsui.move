module 0x53fc18c0c446fb2cea464ca3261ac0ba58a235ed8ff172546d9f21f2a747f908::santaonsui {
    struct SANTAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTAONSUI>(arg0, 6, b"Santaonsui", b"Santa on sui", b"Santa coming with exciting gifts for u happy christmas ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000905597_9d46294fff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

