module 0xab9d353258fc5731925125ca9e16a75e3839567dd78a01082731622eec930f0f::suiduckz {
    struct SUIDUCKZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDUCKZ>, arg1: 0x2::coin::Coin<SUIDUCKZ>) {
        0x2::coin::burn<SUIDUCKZ>(arg0, arg1);
    }

    fun init(arg0: SUIDUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCKZ>(arg0, 6, b"SUIDUCKZ", b"Sui Duckz", b"Since October 26, 2022. SuiDuckz NFT is a unique NFT Project, 6666 Programmatically generated , only for Sui Ecosystem. Token holder wil gain access to our exclusive events", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/x2RLgch/suiduckz.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDUCKZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCKZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDUCKZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDUCKZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

