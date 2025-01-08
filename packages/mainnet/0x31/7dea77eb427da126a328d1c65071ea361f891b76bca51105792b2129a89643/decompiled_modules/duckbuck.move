module 0x317dea77eb427da126a328d1c65071ea361f891b76bca51105792b2129a89643::duckbuck {
    struct DUCKBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKBUCK>(arg0, 6, b"DUCKBUCK", b"DUCK BUCK", x"5468652066756e6e69657374206d656d65636f696e20696e207468652063727970746f2073706163652e2057697468206120746f756368206f662068756d6f7220616e6420612076696272616e7420636f6d6d756e6974792c20244455434b4255434b206973207468652073796d626f6c206f6620647265616d6572732077686f2062656c6965766520746865206e6578742022746f20746865206d6f6f6e222077696c6c206265206c65642062792061206475636b2e20484f444c2c206c617567682c20616e6420656e6a6f7920746865207269646520746f2074686520746f702120f09fa686f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736373165172.32")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKBUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKBUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

