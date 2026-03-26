module 0xb395dfaf8aef16f7dfe37d78d8a870b78d14d99f5e21fb207e2fc862c06fcb17::sdex {
    struct SDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDEX>(arg0, 6, b"SDEX", b"SuiDex", b"Suidex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigohdndgh7j2lhut45oitl7hckn4j5hktcb3yc4w2xu26tk6t4hlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

