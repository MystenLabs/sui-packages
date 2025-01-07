module 0x91c366c3aad9f5d0b5dfc49fa06321c3e32e56882253ec554076d4b77820c94a::catwif {
    struct CATWIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATWIF>, arg1: 0x2::coin::Coin<CATWIF>) {
        0x2::coin::burn<CATWIF>(arg0, arg1);
    }

    fun init(arg0: CATWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIF>(arg0, 4, b"CatWif", b"CatWif", b"CatWifHat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Avb1PBRudW7uUV9MqTUqfZ3EZTDvNkKS63W3wyPseudf.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIF>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATWIF>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATWIF>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

