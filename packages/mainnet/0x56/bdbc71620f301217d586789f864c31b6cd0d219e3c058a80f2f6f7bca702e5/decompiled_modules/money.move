module 0x56bdbc71620f301217d586789f864c31b6cd0d219e3c058a80f2f6f7bca702e5::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEY>(arg0, 6, b"MONEY", b"INFINITE MONEY GLITCH", b"INFINITE MONEY GLITCH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5045_c16541e982.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

