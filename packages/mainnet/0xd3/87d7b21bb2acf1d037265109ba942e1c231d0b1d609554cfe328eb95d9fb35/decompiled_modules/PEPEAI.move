module 0xd387d7b21bb2acf1d037265109ba942e1c231d0b1d609554cfe328eb95d9fb35::PEPEAI {
    struct PEPEAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEAI>, arg1: 0x2::coin::Coin<PEPEAI>) {
        0x2::coin::burn<PEPEAI>(arg0, arg1);
    }

    fun init(arg0: PEPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEAI>(arg0, 9, b"PEPEAI", b"PEPEAI", b"PEPEAI on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/bsc/0xe57f73eb27da9d17f90c994744d842e95700c100.png?1683223924098")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

