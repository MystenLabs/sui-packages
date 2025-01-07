module 0x272a182c9131acd4dbd3bdda2d7ef866a5f6d9e5ff40c46a4e30f4d333336b0d::pookat {
    struct POOKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKAT>(arg0, 6, b"POOKAT", b"Popkat Sui", b"The kat that Pops, multichain meme maskot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002440_25b4cfcfdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

