module 0x7d36498ff3695fd2b889c8a2590eeacbf2d9ba619ebe981b42d4f34adff9d34d::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CAN>, arg1: 0x2::coin::Coin<CAN>) {
        0x2::coin::burn<CAN>(arg0, arg1);
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 4, b"CAN", b"CAN", b"CAN coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FF4dN8Qy8NNF88HRgMA3TkbRVZ8PTXWXZCZJb59X3Sbg.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xd437be3eb32e137a6b287d114cb37f6be9a5412483c5913bf1734174e7fd46dd, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAN>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAN>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CAN>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

