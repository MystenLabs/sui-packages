module 0xeb9f2d74764ae79c78331c8c5f49fc98b091fac45d8beec9ace61134a25643b7::kittys {
    struct KITTYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTYS>(arg0, 6, b"KittyS", b"Kitty Sui", b"Introducing Kitty Meme Coin on Sui: A feline-themed cryptocurrency combining fun, innovation, and efficient trading for meme enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001364694_90d42c5df3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

