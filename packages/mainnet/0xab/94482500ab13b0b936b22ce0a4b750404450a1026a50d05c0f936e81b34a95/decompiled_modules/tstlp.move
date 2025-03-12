module 0xab94482500ab13b0b936b22ce0a4b750404450a1026a50d05c0f936e81b34a95::tstlp {
    struct TSTLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTLP>(arg0, 6, b"TSTLP", b"TestLpToken", b"Parrot vaults lp token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/H6RiSi7PDvKaKCzgsLybW1Pdaq4pvakBHnTvghWD5Kad")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSTLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

