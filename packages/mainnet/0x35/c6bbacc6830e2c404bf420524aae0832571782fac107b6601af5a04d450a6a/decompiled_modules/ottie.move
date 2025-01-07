module 0x35c6bbacc6830e2c404bf420524aae0832571782fac107b6601af5a04d450a6a::ottie {
    struct OTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTIE>(arg0, 6, b"OTTIE", b"ottie", x"446f6e27742061736b202c204a757374204368696c6c696e2720616e64204d6f6f6e696e27202e2e2e21f09fa6a620f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731443298680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

