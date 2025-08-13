module 0xc724c5cbc4afe5373079ad77f882bf8d9ec35bac558c684e768df5f167e06758::summon {
    struct SUMMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMON>(arg0, 6, b"SUMMON", b"summon.fun", x"43726561746520796f757220636f696e20617420687474703a2f2f73756d6d6f6e2e66756e20546167200a4053756d6d6f6e46756e2077697468206c6f676f2c206e616d652c20245449434b45522c20616e6420636861696e20535549206f7220534f4c20616e642077652077696c6c2068616e646c65207468652072657374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibojqkgrx66swzlcuirnq67bboj627y2uvn2keypf5tbcob474j3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

