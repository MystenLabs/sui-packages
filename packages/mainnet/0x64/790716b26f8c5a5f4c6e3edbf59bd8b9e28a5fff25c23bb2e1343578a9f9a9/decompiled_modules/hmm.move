module 0x64790716b26f8c5a5f4c6e3edbf59bd8b9e28a5fff25c23bb2e1343578a9f9a9::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HMM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HMM>>(0x2::coin::mint<HMM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMM>(arg0, 9, b"HMM", b"HMM Coin", b"The official HMM cryptocurrency", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

