module 0x8d0a2d5087a2aa6da573e2d68272d51c4b88f44ccab8e511cbe56a77576ab92e::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"SHARK", b"Deep Blue Sui", b"Just a meme for gags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shark_33887fdc62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

