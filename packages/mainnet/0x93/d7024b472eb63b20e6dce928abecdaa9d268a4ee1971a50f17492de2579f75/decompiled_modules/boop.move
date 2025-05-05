module 0x93d7024b472eb63b20e6dce928abecdaa9d268a4ee1971a50f17492de2579f75::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 9, b"BOOP", b"BOOP", b"BOOP is the native utility token of the boop.fun platform. By staking BOOP, users can unlock airdrop rewards and trading fees from tokens launched on the platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/boopkpWqe68MSxLqBGogs8ZbUDN4GXaLhFwNP7mpP1i.png?size=xl&key=5b7ae9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

