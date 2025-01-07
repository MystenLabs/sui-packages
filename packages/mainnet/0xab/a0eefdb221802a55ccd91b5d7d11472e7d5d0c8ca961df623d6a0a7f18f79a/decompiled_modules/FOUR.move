module 0xaba0eefdb221802a55ccd91b5d7d11472e7d5d0c8ca961df623d6a0a7f18f79a::FOUR {
    struct FOUR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOUR>, arg1: 0x2::coin::Coin<FOUR>) {
        0x2::coin::burn<FOUR>(arg0, arg1);
    }

    fun init(arg0: FOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUR>(arg0, 2, b"FOUR", b"FOUR", b"FOUR on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0x244b797d622d4dee8b188b03546acaabd0cf91a0.png?1683600762397")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOUR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOUR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

