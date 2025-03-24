module 0x8088ca231581ec42ca247fd8cc99c988019516f71e776f4df1d89dae59692760::presidownt {
    struct PRESIDOWNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESIDOWNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESIDOWNT>(arg0, 9, b"PRESIDOWNT", b"Downald Trump", b"\"PRESIDOWNT\" Downald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVU7eSAdeYCF1Bi9CJBTCi6gPnnNWtuZi6iiGxBpgvjst")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRESIDOWNT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRESIDOWNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESIDOWNT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

