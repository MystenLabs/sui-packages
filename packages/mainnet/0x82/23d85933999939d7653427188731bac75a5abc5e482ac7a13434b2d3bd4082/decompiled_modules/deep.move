module 0x8223d85933999939d7653427188731bac75a5abc5e482ac7a13434b2d3bd4082::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DeepBook", b"The premier decentralized liquidity layer for builders, traders, and the broader DeFi community, exclusively on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-rapid-stork-14.mypinata.cloud/ipfs/QmR1ewwEm8QNW7eWdUuAK6dDnNyqB5zWN1oZrrtUHi3jWE")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP>>(0x2::coin::mint<DEEP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

