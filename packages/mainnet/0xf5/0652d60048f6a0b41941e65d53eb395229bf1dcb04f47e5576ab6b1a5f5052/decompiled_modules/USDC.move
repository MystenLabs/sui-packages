module 0xf50652d60048f6a0b41941e65d53eb395229bf1dcb04f47e5576ab6b1a5f5052::USDC {
    struct USDC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: 0x2::coin::Coin<USDC>) {
        0x2::coin::burn<USDC>(arg0, arg1);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 9, b"USDC", b"USD Coin", b"USD Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/usdc_019d7ef24b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

