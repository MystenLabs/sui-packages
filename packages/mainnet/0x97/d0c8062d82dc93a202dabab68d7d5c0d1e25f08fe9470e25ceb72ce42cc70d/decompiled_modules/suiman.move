module 0x97d0c8062d82dc93a202dabab68d7d5c0d1e25f08fe9470e25ceb72ce42cc70d::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 9, b"Suiman", b"Suiman", b"Suiman is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xa8b69040684d576828475115b30cc4ce7c7743eab9c7d669535ee31caccef4f5::suiman::suiman.png?size=xl&key=65e38d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v2, @0xa85129f31a050e4cdfd67d8e7eaf8d943761def0dab2f2e8fe92170fbe88e51);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

