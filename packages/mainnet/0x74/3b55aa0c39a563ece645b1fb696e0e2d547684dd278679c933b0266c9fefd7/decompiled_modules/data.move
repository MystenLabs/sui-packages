module 0x743b55aa0c39a563ece645b1fb696e0e2d547684dd278679c933b0266c9fefd7::data {
    struct DATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATA>(arg0, 9, b"DATA", b"Data Network", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2070153040393277440/VZbxSUD6_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DATA>>(0x2::coin::mint<DATA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DATA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATA>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

