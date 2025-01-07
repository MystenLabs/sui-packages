module 0xc42073acb2187c1a516788d0fc1335e616e0d97f997979affe0e20f5a7e02e47::cosmos {
    struct COSMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMOS>(arg0, 6, b"COSMOS", b"CosmosAI", x"0a546865206669727374204149206d656d65636f696e206f6e207468652053554920626c6f636b636861696e2c206275696c742077697468207468652068656c70206f6620436861744750542e2054686579e280997265206e6f7420726561647920666f722077686174e280997320636f6d696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040329818.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSMOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

