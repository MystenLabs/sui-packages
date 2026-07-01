module 0xae946f57520935e7ecd5799d15741b0c0c0871202cd7fc1b766ea0cabb1b2127::sswap {
    struct SSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWAP>(arg0, 9, b"SSWAP", b"SuiSwap", b"SuiSwap protocol reward token. Fixed supply of 1,000,000,000 SSWAP, minted once at publish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://swap.epinio.playunknown.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SSWAP>>(0x2::coin::mint<SSWAP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSWAP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SSWAP>>(v2);
    }

    // decompiled from Move bytecode v7
}

