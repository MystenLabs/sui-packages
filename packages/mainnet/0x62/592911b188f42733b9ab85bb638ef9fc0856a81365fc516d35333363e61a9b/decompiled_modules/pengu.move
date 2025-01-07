module 0x62592911b188f42733b9ab85bb638ef9fc0856a81365fc516d35333363e61a9b::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"Pudgy Penguins", b"$PENGU: Your best choice for this bullrun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4uqEEiM6fVKuSMdqqxzcznJXieYCQ2aPnCi5PzK8pump.png?size=xl&key=05bd92")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

