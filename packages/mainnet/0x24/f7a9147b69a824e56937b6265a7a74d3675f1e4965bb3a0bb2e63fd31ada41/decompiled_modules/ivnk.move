module 0x24f7a9147b69a824e56937b6265a7a74d3675f1e4965bb3a0bb2e63fd31ada41::ivnk {
    struct IVNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVNK>(arg0, 6, b"IVNK", b"Ivanka Trump", x"4d616b652043727970746f20436c6173737920416761696e0a457870657269656e636520746865206d6f737420736f7068697374696361746564206d656d6520746f6b656e20696e207468652063727970746f20776f726c642e205768657265206c7578757279206d6565747320626c6f636b636861696e2c20616e6420636c617373206d6565747320636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747514090274.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

