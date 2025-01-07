module 0xf1b7828ec0b57fb663b5684f6d9986e1c1af56930093cfd850e259e7987f2009::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"LFGrok", b"Grok.Sui #LFGrok Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api-mainnet.suifrens.sui.io/suifrens/0x1e60e271316307a92af02b526485e8684d402b12f726089c57051c8305596872/svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROK>(&mut v2, 6942000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

