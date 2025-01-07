module 0xfb16b0d9ed248b9715693f40c5779a83c6442e73f2ea8070882e056adef79fff::WETH {
    struct WETH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WETH>, arg1: 0x2::coin::Coin<WETH>) {
        0x2::coin::burn<WETH>(arg0, arg1);
    }

    fun init(arg0: WETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETH>(arg0, 9, b"WETH", b"Wrapped Ether", b"Wrapped Ether", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/ethereum-eth-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WETH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WETH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WETH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

