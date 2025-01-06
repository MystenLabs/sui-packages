module 0x4c9bd1b5ac630c3b7731218dd55916f35d806e1c1d335e2a8c68f83807da33ac::vvaifu {
    struct VVAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVAIFU>(arg0, 6, b"VVAIFU", b"vvaifu.fun", b"Discover new tokens, trade memes, and unleash your $VVAIFU power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736166721519.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVAIFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVAIFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

