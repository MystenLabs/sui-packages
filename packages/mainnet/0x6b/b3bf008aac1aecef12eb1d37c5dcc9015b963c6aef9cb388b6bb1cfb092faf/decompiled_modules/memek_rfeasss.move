module 0x6bb3bf008aac1aecef12eb1d37c5dcc9015b963c6aef9cb388b6bb1cfb092faf::memek_rfeasss {
    struct MEMEK_RFEASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASSS>(arg0, 6, b"MEMEKRFEASSS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASSS>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

