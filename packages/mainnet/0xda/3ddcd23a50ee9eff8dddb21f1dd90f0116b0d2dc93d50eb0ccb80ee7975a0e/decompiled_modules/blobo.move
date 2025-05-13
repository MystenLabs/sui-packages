module 0xda3ddcd23a50ee9eff8dddb21f1dd90f0116b0d2dc93d50eb0ccb80ee7975a0e::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 6, b"BLOBO", b"Sui Blobo", b"$BLOBO, the stupidest and funniest fish on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidivipff3sfzr2yapovzibwlioyrixjh7shii6yziz3qbcvua5zv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

