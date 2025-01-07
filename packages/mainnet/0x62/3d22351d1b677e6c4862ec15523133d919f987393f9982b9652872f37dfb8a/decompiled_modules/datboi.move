module 0x623d22351d1b677e6c4862ec15523133d919f987393f9982b9652872f37dfb8a::datboi {
    struct DATBOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATBOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATBOI>(arg0, 9, b"DATBOI", b"DATBOI", b"0x5532bad51ac2ff97f5e73fb95e36b353701b0a0a553351953eb0a9567009967c::datboi::DATBOI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x5532bad51ac2ff97f5e73fb95e36b353701b0a0a553351953eb0a9567009967c::datboi::datboi.png?size=lg&key=e93f33")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DATBOI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATBOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DATBOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

