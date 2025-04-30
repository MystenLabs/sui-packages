module 0xd59f8b2f3edc07d006b0819659d50fe730c8a8c988d4258bc358de6ad0e5160d::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 6, b"SH", b"sulsh", b"SLUSH is the native governance token of Swapsicle V2, a decentralized exchange (DEX) operating on the Telos EVM and Mantle blockchains. Swapsicle V2 introduces a dual-token economy comprising SLUSH and ICE tokens. SLUSH is primarily used for trading,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745981730132.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

