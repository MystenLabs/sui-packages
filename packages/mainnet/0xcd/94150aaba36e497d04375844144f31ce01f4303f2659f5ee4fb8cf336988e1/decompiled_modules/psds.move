module 0xcd94150aaba36e497d04375844144f31ce01f4303f2659f5ee4fb8cf336988e1::psds {
    struct PSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSDS>(arg0, 9, b"PSDS", b"PsuiDuck.Exchange", b"The New Popular Exchange", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PSDS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

