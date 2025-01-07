module 0xfd6be15a7c782e4bd3060a4f804d902042569df9651131ca5dd64b4c97c9949e::GLASSES {
    struct GLASSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLASSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLASSES>(arg0, 6, b"Gls", b"Glasses", b"Glasses is a meme token with glasses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-written-grasshopper-675.mypinata.cloud/ipfs/QmPFAWZHEenyTBYrvbyN7M58v2xFzdKycfgPhFV2amcb5r"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLASSES>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLASSES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLASSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

