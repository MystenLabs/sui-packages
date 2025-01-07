module 0xc16d6c909f55942d912c2e0e904045452e47f71d67e0d0f6a27686c53c994d8::aigirl {
    struct AIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIGIRL>(arg0, 9, b"AIGIRL", b"CYBER GIRL", b"CYBER ATTACK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8vMornfVvm5TQDD7mTLAECZcHDZj5s8UaS5p8TDpump.png?size=xl&key=cb7bfb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIGIRL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIGIRL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

