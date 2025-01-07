module 0x1780e324489877b8409fdcdbb04c2449cbcdb7af2fec2a1047802decb51615f8::ces {
    struct CES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CES>(arg0, 6, b"CES", b"Cesar", b"The new biggest meme coin in the world soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000401288_a4a443f761.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CES>>(v1);
    }

    // decompiled from Move bytecode v6
}

