module 0x9f969560b10cba3fcffd1cd64c77415d88c5df8e7ba24e2ae8bd8df1b8ec909b::apple {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLE>(arg0, 6, b"APPLE", b"apple", b"Our Apple bot is finally LIVE!  Dive in now and start exploring all the fun, memes, and exclusive rewards weve prepared for you. Let the games begin! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000348_e0bf24f591.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

