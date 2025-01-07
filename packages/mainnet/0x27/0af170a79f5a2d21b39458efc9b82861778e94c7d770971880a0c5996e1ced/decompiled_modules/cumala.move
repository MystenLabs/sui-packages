module 0x270af170a79f5a2d21b39458efc9b82861778e94c7d770971880a0c5996e1ced::cumala {
    struct CUMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMALA>(arg0, 9, b"CUMALA", b"CUMALA", b"Grrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9aTxbtxhmMP5LwCP83C5p6GZHFH9McoKdPZa7J42S7xA.png?size=lg&key=063e64")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CUMALA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMALA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

