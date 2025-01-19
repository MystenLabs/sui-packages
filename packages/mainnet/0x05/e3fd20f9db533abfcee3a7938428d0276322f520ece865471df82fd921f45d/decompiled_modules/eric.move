module 0x5e3fd20f9db533abfcee3a7938428d0276322f520ece865471df82fd921f45d::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"Eric Trump by SuiAI", b"$ERIC is a commemorative token dedicated to celebrating Eric Trump's support and positive outlook on the Sui Network. This token aims to rally and unite fans and supporters of Eric Trump, as well as those who believe in the future of the Sui Network..Solana has $TRUMP. Sui has $ERIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1_96a7e3c2a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ERIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

