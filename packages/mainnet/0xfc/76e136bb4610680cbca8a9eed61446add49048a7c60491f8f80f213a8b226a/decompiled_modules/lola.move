module 0xfc76e136bb4610680cbca8a9eed61446add49048a7c60491f8f80f213a8b226a::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 6, b"LOLA", b"LOLA SUI", b"First Lola on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_4e46fbedc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

