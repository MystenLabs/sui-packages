module 0x85062931ff2430090f6fd567140df54cb8c5c0306e346d72eeced35a6b5550cd::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSE>(arg0, 9, b"HOUSE", b"Housecoin", b"The dev got exposed as a Real Estate Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DitHyRMQiSDhn5cnKMJV2CDDt6sVct96YrECiM49pump.png?size=xl&key=a0be58")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOUSE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

