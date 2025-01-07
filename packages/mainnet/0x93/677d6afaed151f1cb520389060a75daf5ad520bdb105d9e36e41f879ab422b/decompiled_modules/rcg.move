module 0x93677d6afaed151f1cb520389060a75daf5ad520bdb105d9e36e41f879ab422b::rcg {
    struct RCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCG>(arg0, 9, b"RCG", b"racing", b"Fast and furious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d452c3a0-0257-4d0c-982b-b0dc6479e0ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCG>>(v1);
    }

    // decompiled from Move bytecode v6
}

