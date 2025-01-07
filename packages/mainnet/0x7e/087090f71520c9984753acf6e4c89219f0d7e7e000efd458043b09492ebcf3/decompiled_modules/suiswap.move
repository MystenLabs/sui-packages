module 0x7e087090f71520c9984753acf6e4c89219f0d7e7e000efd458043b09492ebcf3::suiswap {
    struct SUISWAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: 0x2::coin::Coin<SUISWAP>) {
        0x2::coin::burn<SUISWAP>(arg0, arg1);
    }

    fun init(arg0: SUISWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISWAP>(arg0, 9, b"SUISWAP", b"SUISWAP", b"Suiswap AMM Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISWAP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

