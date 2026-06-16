module 0xdbebe11b3ddba46274c14ef3701b92c172c5870563dc4e3e751289bb90c82d4e::sir_coin {
    struct SIR_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIR_COIN>, arg1: 0x2::coin::Coin<SIR_COIN>) {
        0x2::coin::burn<SIR_COIN>(arg0, arg1);
    }

    fun init(arg0: SIR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR_COIN>(arg0, 6, b"WCCC", b"WCCC Token", b"WCCC - my own token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/wccc-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIR_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIR_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

