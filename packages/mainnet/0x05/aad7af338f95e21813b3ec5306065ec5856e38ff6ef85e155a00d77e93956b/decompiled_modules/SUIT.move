module 0x5aad7af338f95e21813b3ec5306065ec5856e38ff6ef85e155a00d77e93956b::SUIT {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUI MAGNET", b"Magnet", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8iWsK2WH3AGviQwAnt43zvc8yLy6QMUSuv8PK2A7pump.png?size=lg&key=0badf2")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

