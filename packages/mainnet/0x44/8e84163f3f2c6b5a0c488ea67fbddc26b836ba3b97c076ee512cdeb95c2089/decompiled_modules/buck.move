module 0x448e84163f3f2c6b5a0c488ea67fbddc26b836ba3b97c076ee512cdeb95c2089::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 9, b"BUCK", b"GME MASCOT", b"Gamestop Official Mascot $BUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FLqmVrv6cp7icjobpRMQJMEyjF3kF84QmC4HXpySpump.png?size=xl&key=f7138a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUCK>>(0x2::coin::mint<BUCK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUCK>>(v2);
    }

    // decompiled from Move bytecode v6
}

