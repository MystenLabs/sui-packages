module 0x13a38e88b0b404fff33ac66a7d4e6267a53c1427e3a212bf80fcf92ae5506956::yzy {
    struct YZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YZY>(arg0, 9, b"YzY", b"Yeezy Coin", b"DELETE MY TWITTER DELETE MY SHOPIFY IMMA BUY YOU MOTHERFUCKERS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4NBTf8PfLH4oLFnwf3knv46FY9i5oXjDxffCetXRpump.png?size=lg&key=69cd28")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YZY>>(0x2::coin::mint<YZY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YZY>>(v2);
    }

    // decompiled from Move bytecode v6
}

