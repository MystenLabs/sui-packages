module 0xe7ee143e0e8bc37c1965035c1598a1a6e2632e9599318db4a2e0d70a9756c1fc::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"ELIZA", b"Eliza by SuiAI", b"Eliza Coin is built on the Sui network. It utilizes intelligent algorithms to offer users highly efficient blockchain data processing services. This enables users to make precise decisions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2097_86a6502e35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELIZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

