module 0x4137d2732da21836d6f5bf27abc077f65b81c7375da61b0579477edea6a0b683::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORM>(arg0, 6, b"Worm", b"Worm SUI", b"Worms to feed the bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748414246566.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

