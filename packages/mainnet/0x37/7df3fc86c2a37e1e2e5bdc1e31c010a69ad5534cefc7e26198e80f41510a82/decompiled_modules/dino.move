module 0x377df3fc86c2a37e1e2e5bdc1e31c010a69ad5534cefc7e26198e80f41510a82::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: 0x2::coin::Coin<DINO>) {
        0x2::coin::burn<DINO>(arg0, arg1);
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 9, b"DINO", b"DINO", b"DINO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x85e90a5430af45776548adb82ee4cd9e33b08077.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DINO>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

