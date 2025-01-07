module 0x1da2271d6ca5ea90de444b67aea5b7aa89053dd7f9856fc510c0e8716cc0088f::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKA>(arg0, 6, b"KAKA", b"Kaka the cat", b"Kaka the Cat is more than just a meme coinits a playful blend of fun, creativity, and innovation. Powered by the $SUI network, $KAKA brings AI-driven updates, custom stickers, and viral GIFs to life, connecting crypto and community like never before. Join the fun and lets make the internet purr!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056192_50ed2db7fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

