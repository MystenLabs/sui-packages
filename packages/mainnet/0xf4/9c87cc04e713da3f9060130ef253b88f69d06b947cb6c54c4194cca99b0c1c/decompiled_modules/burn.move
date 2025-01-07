module 0xf49c87cc04e713da3f9060130ef253b88f69d06b947cb6c54c4194cca99b0c1c::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"SUI BURN", b"The liquidity will slowly be burned more & more! Every month 10,000 tokens will be burned till 5m market cap!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734771608102.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

