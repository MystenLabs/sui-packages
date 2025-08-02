module 0xd1e056a3e5d5ab0936879404c2f582fe2cae0c78ca0a84576d86517458865555::volatile {
    struct VOLATILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLATILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLATILE>(arg0, 6, b"VoLaTiLe", b"Volatile Coin", x"cf83", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754161871068.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLATILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLATILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

