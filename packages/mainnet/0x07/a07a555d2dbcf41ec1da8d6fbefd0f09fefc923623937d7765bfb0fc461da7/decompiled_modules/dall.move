module 0x7a07a555d2dbcf41ec1da8d6fbefd0f09fefc923623937d7765bfb0fc461da7::dall {
    struct DALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DALL>(arg0, 6, b"Dall", b"dallino", b" Passionate about all things sui-20!  |  Dall community  | Exploring the NFT universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLI_a84efa9b26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

