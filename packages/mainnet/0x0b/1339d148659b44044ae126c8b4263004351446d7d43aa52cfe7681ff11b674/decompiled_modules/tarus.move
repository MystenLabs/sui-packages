module 0xb1339d148659b44044ae126c8b4263004351446d7d43aa52cfe7681ff11b674::tarus {
    struct TARUS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TARUS>, arg1: 0x2::coin::Coin<TARUS>) {
        0x2::coin::burn<TARUS>(arg0, arg1);
    }

    public fun disable_treasury(arg0: 0x2::coin::TreasuryCap<TARUS>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TARUS>>(arg0);
    }

    fun init(arg0: TARUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARUS>(arg0, 9, b"USDC_0123456", b"TarUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/tokenusdt/USDTlogo1/refs/heads/main/USD_Coin_logo_(cropped).png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TARUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TARUS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

