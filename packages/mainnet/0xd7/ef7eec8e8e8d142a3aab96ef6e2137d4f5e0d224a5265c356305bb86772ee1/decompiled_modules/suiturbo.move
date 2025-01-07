module 0xd7ef7eec8e8e8d142a3aab96ef6e2137d4f5e0d224a5265c356305bb86772ee1::suiturbo {
    struct SUITURBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITURBO>, arg1: 0x2::coin::Coin<SUITURBO>) {
        0x2::coin::burn<SUITURBO>(arg0, arg1);
    }

    public entry fun give_up_permission(arg0: 0x2::coin::TreasuryCap<SUITURBO>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURBO>>(arg0, 0x2::address::from_u256(0));
    }

    fun init(arg0: SUITURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURBO>(arg0, 2, b"Sui Turbo", b"Sui Turbo", b"sui turbo is the first ecosystem focused meme coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/30117/large/turbo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITURBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITURBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

