module 0x2e2eafc6e25c200bb313a91629fce0a23d19401fc0814ff34f893bbb960ef769::RICE {
    struct RICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICE>(arg0, 6, b"AniRice", b"RICE", b"A meme coin celebrating the anime aesthetic with a delicious twist - rice rendered in vibrant, anime-style artwork. Perfect for weebs and foodies alike!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/cf4bf28e-efed-4821-85d1-4b03d86fd5e8")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICE>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

