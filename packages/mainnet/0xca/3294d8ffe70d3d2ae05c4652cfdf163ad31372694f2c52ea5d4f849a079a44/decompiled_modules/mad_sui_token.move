module 0xca3294d8ffe70d3d2ae05c4652cfdf163ad31372694f2c52ea5d4f849a079a44::mad_sui_token {
    struct MAD_SUI_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD_SUI_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 823 || 0x2::tx_context::epoch(arg1) == 824, 1);
        let (v0, v1) = 0x2::coin::create_currency<MAD_SUI_TOKEN>(arg0, 9, b"MDST", b"Mad SUI Token", b"MAD SUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmXMQtn2JkbriKzFMgZMiJbpwqMuDSWYEGenZ2wXZriqH8"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAD_SUI_TOKEN>(&mut v2, 1000000000000000000, @0x8171c0c0df6a3136461e0ab5c66bc36c9234023af681e41cee8dfe0b978826d2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD_SUI_TOKEN>>(v2, @0x8171c0c0df6a3136461e0ab5c66bc36c9234023af681e41cee8dfe0b978826d2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAD_SUI_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

