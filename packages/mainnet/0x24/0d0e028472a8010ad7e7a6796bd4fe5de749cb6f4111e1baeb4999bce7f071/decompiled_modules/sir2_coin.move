module 0x240d0e028472a8010ad7e7a6796bd4fe5de749cb6f4111e1baeb4999bce7f071::sir2_coin {
    struct SIR2_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIR2_COIN>, arg1: 0x2::coin::Coin<SIR2_COIN>) {
        0x2::coin::burn<SIR2_COIN>(arg0, arg1);
    }

    fun init(arg0: SIR2_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR2_COIN>(arg0, 6, b"WCCC", b"WCCC Token", b"WCCC - my own token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/wccc-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR2_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR2_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIR2_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIR2_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

