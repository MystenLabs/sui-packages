module 0xc316d2834ef11ff9c475f27b349515d41843203cdd178ac1696bea3f5f017451::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"Pudgy Penguins", b"Spreading good vibes across the meta.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2zMMhcVQEXDtdE6vsFS7S7D5oUodfJHE8vd1gnBouauv.png?size=lg&key=c3f6fe")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGU>>(0x2::coin::mint<PENGU>(&mut v2, 7723000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PENGU>>(v2);
    }

    // decompiled from Move bytecode v6
}

