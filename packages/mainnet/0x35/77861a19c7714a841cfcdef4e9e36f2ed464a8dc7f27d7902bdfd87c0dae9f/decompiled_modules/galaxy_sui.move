module 0x3577861a19c7714a841cfcdef4e9e36f2ed464a8dc7f27d7902bdfd87c0dae9f::galaxy_sui {
    struct GALAXY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALAXY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALAXY_SUI>(arg0, 9, b"galaxySUI", b"Galaxy Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7wiiytcj6qhel34ssbvccgbetq0oprjr.lambda-url.us-west-2.on.aws/?file=2025-04-27T14-01-20-956Z-cc76737da2cb02cc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALAXY_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALAXY_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

