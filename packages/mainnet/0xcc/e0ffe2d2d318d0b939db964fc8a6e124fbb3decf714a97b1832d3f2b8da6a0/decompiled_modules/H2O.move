module 0xcce0ffe2d2d318d0b939db964fc8a6e124fbb3decf714a97b1832d3f2b8da6a0::H2O {
    struct H2O has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<H2O>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<H2O>>(0x2::coin::split<H2O>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<H2O>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<H2O>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<H2O>(arg0);
        };
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 9, b"H2O", b"H2+O2=H2O", b"65% of your body is water, so why not bag H2O?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://h2ox.xyz/logo_h2o.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H2O>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<H2O>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<H2O>>(0x2::coin::mint<H2O>(&mut v2, 6500000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

