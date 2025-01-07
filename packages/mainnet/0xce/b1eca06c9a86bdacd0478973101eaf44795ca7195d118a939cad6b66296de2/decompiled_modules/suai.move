module 0xceb1eca06c9a86bdacd0478973101eaf44795ca7195d118a939cad6b66296de2::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SuiAgent", b"Create and Co-own Onchain AI Agents @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/26375/standard/sui-ocean-square.png?1727791290")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

