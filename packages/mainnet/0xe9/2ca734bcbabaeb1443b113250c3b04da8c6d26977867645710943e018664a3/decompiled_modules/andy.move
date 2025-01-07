module 0xe92ca734bcbabaeb1443b113250c3b04da8c6d26977867645710943e018664a3::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy Sui", x"416c6f6e672077697468206265737420667269656e647320506570652c20427265747420616e64204c616e64776f6c662c20416e647927732069636f6e69632063686172616374657220666561747572656420696e204d6174742046757269652773206e6f7720636c617373696320426f79277320436c756220636f6d696320626f6f6b207365726965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Qv2_OB_9e_400x400_d476720d02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

