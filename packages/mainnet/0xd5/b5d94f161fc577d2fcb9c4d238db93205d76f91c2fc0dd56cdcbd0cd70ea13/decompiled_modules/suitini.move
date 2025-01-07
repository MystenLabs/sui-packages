module 0xd5b5d94f161fc577d2fcb9c4d238db93205d76f91c2fc0dd56cdcbd0cd70ea13::suitini {
    struct SUITINI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITINI>, arg1: 0x2::coin::Coin<SUITINI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITINI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITINI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUITINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITINI>(arg0, 6, b"STI", b"Suitini", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITINI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITINI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUITINI>, arg1: 0x2::coin::Coin<SUITINI>) : u64 {
        0x2::coin::burn<SUITINI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUITINI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUITINI> {
        0x2::coin::mint<SUITINI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

