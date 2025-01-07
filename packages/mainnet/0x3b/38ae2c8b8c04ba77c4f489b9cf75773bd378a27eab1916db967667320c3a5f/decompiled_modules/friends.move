module 0x3b38ae2c8b8c04ba77c4f489b9cf75773bd378a27eab1916db967667320c3a5f::friends {
    struct FRIENDS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FRIENDS>, arg1: 0x2::coin::Coin<FRIENDS>) {
        0x2::coin::burn<FRIENDS>(arg0, arg1);
    }

    fun init(arg0: FRIENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIENDS>(arg0, 9, b"FRIENDS", b"FRIENDS", b"FRIENDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x0bd4887f7d41b35cd75dff9ffee2856106f86670.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIENDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIENDS>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRIENDS>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FRIENDS>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

