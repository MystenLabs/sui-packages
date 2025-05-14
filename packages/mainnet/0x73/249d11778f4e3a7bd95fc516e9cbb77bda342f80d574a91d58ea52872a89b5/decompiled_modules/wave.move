module 0x73249d11778f4e3a7bd95fc516e9cbb77bda342f80d574a91d58ea52872a89b5::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"Wave", b"Pirate Waves", b"Main Currency of Pirate Waves Game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.britishmuseumshoponline.org/media/catalog/product/cache/c7fa28c603a46999895490fd4b2a5ed6/f/u/fuji-wave-coin-cmcr57900.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAVE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

