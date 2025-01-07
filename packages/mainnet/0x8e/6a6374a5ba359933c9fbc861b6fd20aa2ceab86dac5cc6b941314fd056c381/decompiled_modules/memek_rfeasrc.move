module 0x8e6a6374a5ba359933c9fbc861b6fd20aa2ceab86dac5cc6b941314fd056c381::memek_rfeasrc {
    struct MEMEK_RFEASRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRC>(arg0, 6, b"MEMEKRFEASRC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRC>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

