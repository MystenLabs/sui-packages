module 0xec867794315f6b1dc27705df1bbed4918671d4d383fb97d7db91e12b627328bd::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 6, b"GROGGO", b"GROGGO SUI", x"2467726f67676f207468652062617365642023506570652066726f672063726561746564206279204d6174742046757269652c20696e73706972656420627920746865204d696e64766973636f7369747920626f6f6b732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Copy_of_43e9fa_3b108372d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

