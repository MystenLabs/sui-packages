module 0x2bd71cb778d88f7ef82ca07c5b92a95f62c3b2f2617f1df027085c497447fc06::NOT {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"Not a meme", b"NOT", b"Because Rooter said so.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreif6jp3kc4gd4fwxhpznsxt2qaq7blrwp6cfmjmfjvhzqnumwautpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

