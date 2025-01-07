module 0x45437ba4b96edbcb9eae0d67da45815ca5cd81b620238b0cf6fad1ee120d1862::cobra {
    struct COBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBRA>(arg0, 9, b"COBRA", b"CobraX", x"436f62726158206973206120666173742c2073656375726520746f6b656e206f6e207468652053756920626c6f636b636861696e2c20696e7370697265642062792074686520636f627261e2809973206167696c69747920616e6420707265636973696f6e2e2049747320225822207374616e647320666f722063726f73732d636861696e20636f6d7061746962696c6974792c206f66666572696e67207377696674207472616e73616374696f6e7320616e6420766572736174696c697479206163726f737320706c6174666f726d732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1608449801435095041/Jfm7v_Gq.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COBRA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBRA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

