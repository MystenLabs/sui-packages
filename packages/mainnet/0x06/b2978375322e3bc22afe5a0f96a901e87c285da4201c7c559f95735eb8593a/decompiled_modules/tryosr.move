module 0x6b2978375322e3bc22afe5a0f96a901e87c285da4201c7c559f95735eb8593a::tryosr {
    struct TRYOSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYOSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYOSR>(arg0, 9, b"TRYOSR", b"TRYOSRR", b"TRYBETH2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYOSR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYOSR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYOSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

