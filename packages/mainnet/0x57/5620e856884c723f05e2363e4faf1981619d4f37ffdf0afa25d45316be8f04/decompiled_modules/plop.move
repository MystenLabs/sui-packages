module 0x575620e856884c723f05e2363e4faf1981619d4f37ffdf0afa25d45316be8f04::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"Plop", b"Plop is here to plop plop SUI chain, buy under your own risks, we are meme coin with the only goal of create a community around SUI and Plop! Enjoy, have fun and create your best plop!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plop_logo_dc56b81a4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

