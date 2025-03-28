module 0xc24273d018a0e92cc07f4661ff42d4c37adcbf69212d016ea06acb0514705c88::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JERRY>, arg1: 0x2::coin::Coin<JERRY>) {
        0x2::coin::burn<JERRY>(arg0, arg1);
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 9, b"JERRY", b"JERRY", b"JERRY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E4jVYMPqtDL1xeGEnC6u826rUnqM77673jkt1L49daiP.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JERRY>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JERRY>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

