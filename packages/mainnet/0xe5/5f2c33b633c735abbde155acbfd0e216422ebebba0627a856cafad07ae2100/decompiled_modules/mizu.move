module 0xe55f2c33b633c735abbde155acbfd0e216422ebebba0627a856cafad07ae2100::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"MIZU = SUI", b"$MIZU is an essential element of life from the rich culture of the Japanese and the $SUI blockchain,Join the community now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735846593181.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

