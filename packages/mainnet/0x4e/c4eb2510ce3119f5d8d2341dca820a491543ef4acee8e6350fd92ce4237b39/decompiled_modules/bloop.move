module 0x4ec4eb2510ce3119f5d8d2341dca820a491543ef4acee8e6350fd92ce4237b39::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop ON Sui", b"Hey i am BLOOP, Hand drawn by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_123703_392_511367370c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

