module 0xf850e7560d0b3118f7dc6fa6b87e2a56ad75e89cfc793b0b18a2a08c23a1d18f::pif {
    struct PIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIF>, arg1: 0x2::coin::Coin<PIF>) {
        0x2::coin::burn<PIF>(arg0, arg1);
    }

    fun init(arg0: PIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIF>(arg0, 9, b"PIF", b"PIF", b"PIF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Dpwy1X5Dp6dor8vBpU9xw6kKMn4vQxNkKZz7CZgrUBon.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIF>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIF>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIF>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

