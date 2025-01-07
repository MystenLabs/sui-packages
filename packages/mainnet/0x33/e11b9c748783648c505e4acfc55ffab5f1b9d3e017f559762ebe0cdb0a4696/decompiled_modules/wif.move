module 0x33e11b9c748783648c505e4acfc55ffab5f1b9d3e017f559762ebe0cdb0a4696::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIF>, arg1: 0x2::coin::Coin<WIF>) {
        0x2::coin::burn<WIF>(arg0, arg1);
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 9, b"WIF", b"WIF", b"Roaring Kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EKpQGSJtjMFqKZ9KQanSqYXRcF8fBopzLHYxdM65zcjm.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIF>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIF>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

