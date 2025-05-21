module 0xe258946f14d4c517d481f379c897f66522942b69cb8fc355f9291c015cbb09b2::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"sui slime", b"The first cute formless monster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif6aun5geykuuihpxhzfgnlx7voqsy6kh7qumipqo74ue63ux7cmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

