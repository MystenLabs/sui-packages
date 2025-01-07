module 0x20277f295fdc98cafb810badf60d2c8c56f9a3992b3a94af4780ab79231b6318::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"Musk", b"SuiMusk", x"5375694d75736b2069732061206d656d652d64726976656e20746f6b656e206f6e207468652053756920626c6f636b636861696e2c20696e737069726564206279207468652069636f6e20456c6f6e204d75736b2e20436f6d62696e696e67204d75736be280997320766973696f6e617279207370697269742077697468206d656d652063756c747572652c205375694d75736b206973206865726520666f722066756e2c20636f6d6d756e6974792c20616e642061206d6f6f6e2d626f756e64206d697373696f6e2e204a6f696e20746865207269646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731530052281.59")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

