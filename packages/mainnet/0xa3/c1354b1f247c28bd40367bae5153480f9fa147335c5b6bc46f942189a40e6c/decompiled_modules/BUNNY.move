module 0xa3c1354b1f247c28bd40367bae5153480f9fa147335c5b6bc46f942189a40e6c::BUNNY {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 6, b"Bunny Token", b"BUNNY", x"486f7020696e746f207468652066757475726520776974682042756e6e7920546f6b656e2120412066756e2c20666173742c20616e64206675727279206d656d6520636f696e2074686174277320616c6c2061626f757420636f6d6d756e6974792c206a6f792c20616e6420656e646c65737320636172726f74732e205065726665637420666f722063727970746f20656e7468757369617374732077686f206c6f76652061206c6974746c6520626f756e636520696e20746865697220706f7274666f6c696f2e204c6574e2809973206d616b652063727970746f20637564646c7920616761696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreihxih24mikncmke3yuoqdbekwoovqzd4cdodvfaylmh6q6vvwxrzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, @0xa5f11852c66d81fe289b74600041f13ea29d3b43ebf53db4a5ac2d934effd6b9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

