module 0x4ce0a01d265205a40463e5920a6ffccfef27a46707138aa2cbe24caf10249dc7::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"TRUMP VANCE", b"TrumpVance: Tax-Free!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2024e06595d82573265a3b950f02f3ab0a2113a1.png?size=lg&key=818a92")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

