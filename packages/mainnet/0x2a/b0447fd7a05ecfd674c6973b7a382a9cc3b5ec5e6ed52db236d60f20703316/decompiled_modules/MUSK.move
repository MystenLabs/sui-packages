module 0x2ab0447fd7a05ecfd674c6973b7a382a9cc3b5ec5e6ed52db236d60f20703316::MUSK {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MUSK>(arg0, 9, b"WER", b"WER the SUI", b"WER the SUI booster", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MUSK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

