module 0x368469e5f5bc1489859f950cf16174160e5335cc472f1dedb89eb44092e372b1::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOME>, arg1: 0x2::coin::Coin<BOME>) {
        0x2::coin::burn<BOME>(arg0, arg1);
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 4, b"BOME", b"BOME", b"BOOK OF MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ukHH6c7mMyiWCf1b9pnWe25TSpkDDt3H5pQZgZ74J82.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xf518a3cd1a0f7c73fa6d2ba862a847f7a9a357b05f84d039c5bbb40a04bde912, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOME>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOME>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOME>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

