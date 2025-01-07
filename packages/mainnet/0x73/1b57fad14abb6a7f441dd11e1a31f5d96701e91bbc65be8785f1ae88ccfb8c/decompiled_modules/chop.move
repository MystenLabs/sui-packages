module 0x731b57fad14abb6a7f441dd11e1a31f5d96701e91bbc65be8785f1ae88ccfb8c::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"CHOPCHOP", b"In the deep, dark waters of Crypto Cove, there lived a legendary chefa shark named Chop, the Sui King. Chop wasnt your ordinary shark; he didnt care for fish. His true love? Chopping up blockchains into bite-sized pieces.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_201755245_604b4833c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

