module 0x4d0889c8bf462181e115e52683a8a232427aa2b35723f1e0bd862d1563a8d053::POPY {
    struct POPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPY>(arg0, 9, b"ELON", b"Elon Musk", b"Elon Musk wif Trump", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

