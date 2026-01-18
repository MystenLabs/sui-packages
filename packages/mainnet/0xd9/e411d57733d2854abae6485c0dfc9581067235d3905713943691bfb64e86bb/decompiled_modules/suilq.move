module 0xd9e411d57733d2854abae6485c0dfc9581067235d3905713943691bfb64e86bb::suilq {
    struct SUILQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILQ>(arg0, 6, b"SUILQ", b"$SUILiquid", b"Built on Sui. Used as liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1768738081231.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

