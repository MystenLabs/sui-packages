module 0x30058df04fb6d2f2cb193bd6cc1e4bc5db5359130bcb14de0f3b1c5d52861c72::jillBoden {
    struct JILLBODEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JILLBODEN>, arg1: 0x2::coin::Coin<JILLBODEN>) {
        0x2::coin::burn<JILLBODEN>(arg0, arg1);
    }

    fun init(arg0: JILLBODEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JILLBODEN>(arg0, 9, b"JillBoden", b"JillBoden", b"JillBoden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BidenWjdX6XTBNdhQNbD3hXTAHVQD8wtFXvhLCqsVMV7.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JILLBODEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JILLBODEN>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JILLBODEN>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JILLBODEN>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

