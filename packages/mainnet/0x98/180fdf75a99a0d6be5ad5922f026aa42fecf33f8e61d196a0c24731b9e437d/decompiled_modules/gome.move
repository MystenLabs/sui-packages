module 0x98180fdf75a99a0d6be5ad5922f026aa42fecf33f8e61d196a0c24731b9e437d::gome {
    struct GOME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOME>, arg1: 0x2::coin::Coin<GOME>) {
        0x2::coin::burn<GOME>(arg0, arg1);
    }

    fun init(arg0: GOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOME>(arg0, 9, b"GOME", b"GOME", b"GOME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ULCkCTUa3XXrNXaDVzPcja2tdJtRdxRr8T4eZjVKqk.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOME>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOME>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOME>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

